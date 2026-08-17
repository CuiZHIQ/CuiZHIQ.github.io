param(
    [ValidateSet("Content", "Styles", "Behavior", "All")]
    [string]$Check = "All"
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$aboutPath = Join-Path $repoRoot "_pages/about.md"
$scssPath = Join-Path $repoRoot "assets/css/main.scss"
$scriptsIncludePath = Join-Path $repoRoot "_includes/scripts.html"
$newsScriptPath = Join-Path $repoRoot "assets/js/news-scroll.js"
$about = Get-Content -Raw -LiteralPath $aboutPath
$scss = Get-Content -Raw -LiteralPath $scssPath
$scriptsInclude = Get-Content -Raw -LiteralPath $scriptsIncludePath
$newsScript = if (Test-Path -LiteralPath $newsScriptPath) {
    Get-Content -Raw -LiteralPath $newsScriptPath
} else {
    ""
}
$failures = [System.Collections.Generic.List[string]]::new()

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { $script:failures.Add($Message) }
}

function Assert-BalancedTag([string]$Markup, [string]$TagName) {
    $tokens = [regex]::Matches($Markup, "(?i)</?$TagName\b[^>]*>")
    $depth = 0
    $openingCount = 0
    $closingCount = 0
    $underflow = $false

    foreach ($token in $tokens) {
        if ($token.Value -like '</*') {
            $closingCount++
            if ($depth -eq 0) {
                $underflow = $true
            } else {
                $depth--
            }
        } elseif ($token.Value -notmatch '/\s*>$') {
            $openingCount++
            $depth++
        }
    }

    Assert-True (-not $underflow) "Found a closing <$TagName> tag before its opening tag."
    Assert-True ($openingCount -eq $closingCount -and $depth -eq 0) "Unbalanced <$TagName> tags: $openingCount opening, $closingCount closing."
}

function Assert-BalancedContainerNesting([string]$Markup) {
    $tokens = [regex]::Matches($Markup, '(?i)</?(details|div)\b[^>]*>')
    $stack = [System.Collections.Generic.List[string]]::new()

    foreach ($token in $tokens) {
        $name = ([regex]::Match($token.Value, '(?i)(details|div)')).Value.ToLowerInvariant()
        if ($token.Value -like '</*') {
            if ($stack.Count -eq 0) {
                Assert-True $false "Found a closing <$name> tag without an open container."
            } elseif ($stack[$stack.Count - 1] -ne $name) {
                Assert-True $false "Container nesting mismatch: expected </$($stack[$stack.Count - 1])> before </$name>."
                $stack.RemoveAt($stack.Count - 1)
            } else {
                $stack.RemoveAt($stack.Count - 1)
            }
        } elseif ($token.Value -notmatch '/\s*>$') {
            $stack.Add($name)
        }
    }

    Assert-True ($stack.Count -eq 0) "Unclosed container tags remain: $($stack -join ', ')."
}

function Assert-LocalImageReferences([string]$Markup, [string]$Root) {
    $imagePattern = '<img\b[^>]*\bsrc\s*=\s*(?:"(?<doubleSrc>[^"]+)"|''(?<singleSrc>[^'']+)'')'
    $imageMatches = [regex]::Matches($Markup, $imagePattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    $srcAttributeMatches = [regex]::Matches($Markup, '(?i)<img\b[^>]*\bsrc\s*=')
    Assert-True ($imageMatches.Count -eq $srcAttributeMatches.Count) "Could not parse every local image src attribute."

    $imageFiles = [System.Collections.Generic.Dictionary[string, string]]::new([System.StringComparer]::Ordinal)
    if (Test-Path -LiteralPath $Root -PathType Container) {
        foreach ($file in Get-ChildItem -LiteralPath $Root -File -Recurse) {
            $relativePath = [System.IO.Path]::GetRelativePath($Root, $file.FullName).Replace('\', '/')
            if (-not $imageFiles.ContainsKey($relativePath)) {
                $imageFiles.Add($relativePath, $file.FullName)
            }
        }
    } else {
        Assert-True $false "Missing repository root."
    }

    $localReferenceCount = 0
    foreach ($match in $imageMatches) {
        $source = if ($match.Groups['doubleSrc'].Success) {
            $match.Groups['doubleSrc'].Value
        } else {
            $match.Groups['singleSrc'].Value
        }

        # Protocol and protocol-relative URLs are not repository-local assets.
        if ($source -match '^(?:[A-Za-z][A-Za-z0-9+.-]*:|//)') { continue }

        $localReferenceCount++
        $normalizedSource = ($source -split '[?#]', 2)[0].Replace('\', '/')
        while ($normalizedSource.StartsWith('./', [System.StringComparison]::Ordinal)) {
            $normalizedSource = $normalizedSource.Substring(2)
        }
        $normalizedSource = $normalizedSource.TrimStart('/')
        try {
            $normalizedSource = [System.Uri]::UnescapeDataString($normalizedSource)
        } catch {
            Assert-True $false "Invalid URL encoding in local image: $source"
            continue
        }

        # Ordinal dictionary lookup preserves case sensitivity even on Windows.
        Assert-True ($imageFiles.ContainsKey($normalizedSource)) "Missing or case-mismatched local image: $source"
    }

    Assert-True ($localReferenceCount -gt 0) "Expected at least one local image reference."
}

if ($Check -in @("Content", "All")) {
    Assert-BalancedTag $about "details"
    Assert-BalancedTag $about "div"
    Assert-BalancedContainerNesting $about

    $detailMatches = [regex]::Matches($about, '(?s)<details\b(?<attrs>[^>]*)>(?<body>.*?)</details\s*>')
    Assert-True ($detailMatches.Count -eq 4) "Expected four details elements."

    $publicationSections = [System.Collections.Generic.List[object]]::new()
    foreach ($detailMatch in $detailMatches) {
        $attrs = $detailMatch.Groups['attrs'].Value
        if ($attrs -notmatch '(?:^|\s)class="publication-section"(?:\s|$)') { continue }

        $body = $detailMatch.Groups['body'].Value
        $summaryMatches = [regex]::Matches($body, '(?s)<summary\b[^>]*class="publication-summary"[^>]*>(?<summaryBody>.*?)</summary\s*>')
        Assert-True ($summaryMatches.Count -eq 1) "Each publication section must contain exactly one publication summary."

        $title = ""
        $displayCount = -1
        if ($summaryMatches.Count -eq 1) {
            $summaryBody = $summaryMatches[0].Groups['summaryBody'].Value
            $titleMatches = [regex]::Matches($summaryBody, '<span\b[^>]*class="publication-summary-title"[^>]*>(?<title>[^<]*)</span\s*>')
            $countMatches = [regex]::Matches($summaryBody, '<span\b[^>]*class="publication-count"[^>]*>(?<count>\d+) papers</span\s*>')
            Assert-True ($titleMatches.Count -eq 1) "Each publication summary must contain exactly one title."
            Assert-True ($countMatches.Count -eq 1) "Each publication summary must contain exactly one paper count."
            if ($titleMatches.Count -eq 1) { $title = $titleMatches[0].Groups['title'].Value.Trim() }
            if ($countMatches.Count -eq 1) { $displayCount = [int]$countMatches[0].Groups['count'].Value }
        }

        $acceptedCount = ([regex]::Matches($body, 'class="badge badge--accepted"')).Count
        $preprintCount = ([regex]::Matches($body, 'class="badge badge--preprint"')).Count
        $paperCount = ([regex]::Matches($body, 'class=[''"]paper-box[''"]')).Count
        Assert-True (($acceptedCount + $preprintCount) -eq $paperCount) "Every paper card in '$title' must have exactly one classified badge."

        $publicationSections.Add([pscustomobject]@{
            Title = $title
            DisplayCount = $displayCount
            PaperCount = $paperCount
            AcceptedCount = $acceptedCount
            PreprintCount = $preprintCount
            IsOpen = ($attrs -match '(^|\s)open(?:\s|$)')
        })
    }

    Assert-True ($publicationSections.Count -eq 4) "Expected four publication-section disclosures."
    Assert-True (([regex]::Matches($about, 'class="publication-summary"')).Count -eq 4) "Expected four publication summaries."
    Assert-True (([regex]::Matches($about, 'class=[''"]paper-box[''"]')).Count -eq 18) "Expected 18 paper cards."

    $expectedSections = @(
        @{ Title = 'First-Author Accepted Papers'; Papers = 5; Accepted = 5; Preprint = 0; Open = $true },
        @{ Title = 'First-Author Preprints'; Papers = 4; Accepted = 0; Preprint = 4; Open = $false },
        @{ Title = 'Co-Authored Papers'; Papers = 6; Accepted = 6; Preprint = 0; Open = $false },
        @{ Title = 'preprint Papers'; Papers = 3; Accepted = 0; Preprint = 3; Open = $false }
    )

    foreach ($expected in $expectedSections) {
        $matches = @($publicationSections | Where-Object { $_.Title -eq $expected.Title })
        Assert-True ($matches.Count -eq 1) "Expected exactly one publication section named '$($expected.Title)'."
        if ($matches.Count -eq 1) {
            $section = $matches[0]
            Assert-True ($section.DisplayCount -eq $expected.Papers) "Section '$($expected.Title)' has the wrong displayed paper count."
            Assert-True ($section.PaperCount -eq $expected.Papers) "Section '$($expected.Title)' has the wrong number of paper cards."
            Assert-True ($section.AcceptedCount -eq $expected.Accepted) "Section '$($expected.Title)' has the wrong accepted-badge distribution."
            Assert-True ($section.PreprintCount -eq $expected.Preprint) "Section '$($expected.Title)' has the wrong preprint-badge distribution."
            Assert-True ($section.IsOpen -eq $expected.Open) "Section '$($expected.Title)' has the wrong open state."
        }
    }

    $expectedTitles = @($expectedSections | ForEach-Object { $_.Title })
    foreach ($section in $publicationSections) {
        Assert-True ($expectedTitles -contains $section.Title) "Unexpected publication section: '$($section.Title)'."
    }
    $openSections = @($publicationSections | Where-Object { $_.IsOpen })
    Assert-True ($openSections.Count -eq 1 -and $openSections[0].Title -eq 'First-Author Accepted Papers') "Only First-Author Accepted Papers may be open by default."

    Assert-True (([regex]::Matches($about, 'class="badge badge--accepted"')).Count -eq 11) "Expected 11 accepted badges."
    Assert-True (([regex]::Matches($about, 'class="badge badge--preprint"')).Count -eq 7) "Expected seven preprint badges."
    Assert-True (([regex]::Matches($about, 'class="badge"')).Count -eq 0) "Found an unclassified publication badge."
    Assert-True (-not $about.Contains('Assistant Professor [Wentao Zhang](https://github.com) (PKU) to develop automated research agents')) "Research Topics still contains the removed Wentao Zhang clause."
    Assert-True ($about.Contains('I have also collaborated with [Jiahao Yuan](https://github.com) (ECNU).')) "Jiahao Yuan collaboration sentence is missing."
    Assert-True ($about.Contains('*2024.06 - 2024.08*, Yangtze River Delta Information Intelligence Innovation Research Institute, China.')) "Yangtze institute internship is missing."
    Assert-True ($about.Contains('*2026.07 - 2026.08*, Evolvent AI.')) "Evolvent AI internship is missing."
    Assert-True ($about.Contains('[LLMSR@XLLM25: Less is More: Enhancing Structured Multi-Agent Reasoning via Quality-Guided Distillation](https://aclanthology.org/2025.xllm-1.23/)')) "Less is More title or official link is missing."
    Assert-True ($about.Contains('Jiahao Yuan, Xingzhe Sun, Xing Yu, Jingwen Wang, Dehui Du, **Zhiqing Cui**, Zixiang Di')) "Less is More author order is incorrect."
    Assert-True ($about.Contains('**XLLM@ACL 2025 (Shared Task, 3rd Place)**')) "Less is More venue is incorrect."
    Assert-True ($about.Contains('class="badge badge--accepted">XLLM 2025</div>')) "Less is More accepted badge is missing."
    Assert-True ($about.Contains('src=''images/less-is-more.png'' alt="Less is More"')) "Less is More official image is missing."
    Assert-True (([regex]::Matches($about, 'class="internship-item"')).Count -eq 2) "Expected two branded Internship rows."
    Assert-True ($about.Contains('src=''images/yangtze-info-institute.svg'' alt="Yangtze River Delta Information Intelligence Innovation Research Institute logo"')) "Yangtze institute logo is missing."
    Assert-True ($about.Contains('src=''images/evolvent-ai.png'' alt="Evolvent AI logo"')) "Evolvent AI logo is missing."
    Assert-True ($about.Contains('href="https://www.ustciscr.cn/"')) "Yangtze institute official link is missing."
    Assert-True ($about.Contains('href="https://evolvent.co/"')) "Evolvent AI official link is missing."
    $equalContributionPrefixes = @(
        'Jiaming Ma†, **Zhiqing Cui†**, Binwu Wang',
        '**Zhiqing Cui†**, Binwu Wang†, Guanjun Wang',
        'Tao Yu†, Yifei Qu†, **Zhiqing Cui†** (Project Leader), Pengfei Zhou',
        'Tao Yu†, Minghui Zhang†, **Zhiqing Cui†** (Project Leader), Hao Wang'
    )
    foreach ($prefix in $equalContributionPrefixes) {
        Assert-True ($about.Contains($prefix)) "Missing standardized equal-contribution author line: $prefix"
    }
    Assert-True (([regex]::Matches($about, [regex]::Escape('† Equal contribution'))).Count -eq 4) "Expected four equal-contribution notes."
    Assert-True (([regex]::Matches($about, [regex]::Escape('(Project Leader)'))).Count -eq 2) "Expected exactly two Project Leader labels."
    Assert-True (-not $about.Contains('<sup>*</sup> Equal contribution')) "Found the former asterisk equal-contribution note."
    Assert-True (-not $about.Contains('<sup>*</sup>')) "Found the former superscript asterisk author notation."
    Assert-True (([regex]::Matches($about, 'class="news-scroll"')).Count -eq 1) "Expected exactly one News scroll viewport."
    Assert-True ($about.Contains('data-news-scroll')) "News viewport is missing its behavior hook."
    Assert-True ($about.Contains('tabindex="0"')) "News viewport is not keyboard focusable."
    Assert-True ($about.Contains('aria-label="Latest news"')) "News viewport is missing its accessible label."
    Assert-LocalImageReferences $about $repoRoot
}

if ($Check -in @("Styles", "All")) {
    foreach ($selector in @('.publication-section', '.publication-summary', '.publication-count', '.badge--accepted', '.badge--preprint')) {
        Assert-True ($scss.Contains($selector)) "Missing style selector: $selector"
    }
    Assert-True ($scss.Contains('focus-visible')) "Missing keyboard focus styling."
    Assert-True ($scss.Contains('grid-template-columns')) "Missing desktop publication grid."
    Assert-True ($scss.Contains('overflow-wrap: anywhere')) "Missing narrow-screen overflow protection."
    Assert-True ($scss.Contains('#1d4ed8')) "Missing accepted-paper blue."
    Assert-True ($scss.Contains('#b45309')) "Missing preprint amber."
    Assert-True ($scss.Contains('@media (max-width: 480px)')) "Missing narrow-mobile breakpoint."
    foreach ($internshipStyle in @('.internship-list', '.internship-item', '.internship-logo', '170px', '64px', '140px', '52px', 'object-fit: contain')) {
        Assert-True ($scss.Contains($internshipStyle)) "Missing Internship style rule: $internshipStyle"
    }
    foreach ($newsStyle in @('.news-scroll', 'max-height: 14rem', 'overflow-y: auto', 'overscroll-behavior: contain', 'scroll-behavior: smooth', 'prefers-reduced-motion: reduce', 'max-height: 11rem')) {
        Assert-True ($scss.Contains($newsStyle)) "Missing News style rule: $newsStyle"
    }
}

if ($Check -in @("Behavior", "All")) {
    Assert-True (Test-Path -LiteralPath $newsScriptPath -PathType Leaf) "Missing News behavior script."
    Assert-True ($scriptsInclude.Contains('<script src="assets/js/news-scroll.js" defer></script>')) "News behavior script is not loaded by the site."
    foreach ($token in @('data-news-scroll', '4000', '8000', 'prefers-reduced-motion: reduce', 'mouseenter', 'focusin', 'wheel', 'pointerdown', 'scrollTo')) {
        Assert-True ($newsScript.Contains($token)) "Missing News behavior token: $token"
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Host "FAIL: $_" -ForegroundColor Red }
    exit 1
}

Write-Output "Publication validation passed ($Check)."
