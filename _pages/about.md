---
permalink: /
title: ""
excerpt: ""
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---

{% if site.google_scholar_stats_use_cdn %}
{% assign gsDataBaseUrl = "https://cdn.jsdelivr.net/gh/" | append: site.repository | append: "@" %}
{% else %}
{% assign gsDataBaseUrl = "https://raw.githubusercontent.com/" | append: site.repository | append: "/" %}
{% endif %}
{% assign url = gsDataBaseUrl | append: "google-scholar-stats/gs_data_shieldsio.json" %}

<span class='anchor' id='about-me'></span>

# About Me

Hello! I am a third-year undergraduate student (2023-2027) pursuing a dual degree program at the University of Reading and Nanjing University of Information Science and Technology, majoring in Data Science. I am seeking PhD positions for 2027 Fall and warmly welcome any remote/onsite industrial or research internship. Please feel free to contact me via email at <a href="mailto:zhiqing@nuist.edu.cn">zhiqing@nuist.edu.cn</a> or <a href="mailto:dh803755@student.reading.ac.uk">dh803755@student.reading.ac.uk</a>.

# 🚀 Research Aim
My research interests lie at the intersection of AI for Earth Science (AI4Earth), spatiotemporal data mining, and the reasoning, scheduling, and memory capabilities of LLM agents. I am dedicated to applying these techniques, along with multimodal reasoning, to large-scale real-world scenarios like air pollution management, ultimately aiming to deepen our understanding of the Earth's environment.

# 🔍 Research Topics
Over the past year, I worked on spatiotemporal data mining with Assistant Professor [Binwu Wang](https://continualgoing.github.io/) at USTC, resulting in multiple publications. Following this, I was a visiting intern at HKUST(GZ) under Assistant Professor [Yuxuan Liang](https://yuxuanliang.com/), focusing on causal data relationships and deploying large-model reasoning in real-world settings. Driven by my interest in LLM agent reasoning, I have also collaborated with [Jiahao Yuan](https://jhcircle.github.io/) (ECNU). Currently, I am an intern at Texas AM University working with Professor [Yu Zhang](https://engineering.tamu.edu/cse/profiles/zhang-yu.html) in LLM Agents. Furthermore, I am honored to participate in a summer research program at MIT, supervised by Professor [Jinhua Zhao](https://dusp.mit.edu/people/jinhua-zhao) and [Dingyi Zhuang](https://mobility.mit.edu/people/dingyi-zhuang/).

# 🔥 News 
<div class="news-scroll" data-news-scroll tabindex="0" aria-label="Latest news" markdown="1">
- *2026.06*: &nbsp;🏆🏆 Received full funding from the KDD Undergraduate Consortium and Travel Grant. See you on the beautiful Jeju Island. Thanks to KDD!
- *2026.06*: &nbsp;🏆🏆 Received full funding from the Association for Computational Linguistics in recognition of exceptional contributions and accomplishments. Thanks to ACL!
- *2026.05*: &nbsp;🎉🎉 My paper "Uno-Orchestra" was published on arXiv. This work marks my initial exploration into multi-agent reinforcement learning and routing orchestration.
- *2026.04*: &nbsp;🎉🎉 My paper "MADGCN" was accepted by IEEE TKDE, initiated during my freshman year. Thanks to Bin!
- *2026.04*: &nbsp;🎉🎉 My paper "Augur: Modeling Covariate Causal Associations in Time Series via Large Language Models" was accepted main conference on ACL.
- *2026.02*: &nbsp;🎉🎉 Our paper "PaperX" was published on arXiv. We introduce the first unified framework for academic presentation. I am honored to lead this work. Thanks to Tao and other friends!
- *2026.01*: &nbsp;🎉🎉 My led paper "OminiAir" was published on arXiv, the best air quality dataset and model in the world.
- *2025.11*: &nbsp;🏆🏆 Received full funding from the AAAI Undergraduate Consortium, the scholarship for best UG AI researchers. Thanks to AAAI!
- *2025.06*: &nbsp;🎉🎉 My led work "Draw with Thought" was accepted by ACM MM, and I delivered the oral presentation.
- *2025.04*: &nbsp;🎉🎉 My first top-tier conference paper "CauAir" was accepted as an oral presentation at IJCAI. I was responsible for compiling the large-scale dataset LargeAQ and delivering the oral presentation. Thanks to Binwu and Jiaming for their contributions.
- *2025.03*: &nbsp;🎉🎉 My work on foundation models for tropical cyclones was accepted by Frontiers of Computer Science. Presented at EGU, AGU, and other meteorology conferences, and received recognition from NASA.
- *2025.02*: &nbsp;🏆🏆 Won the 3rd place in the ACL LLMSR@ XLLM25 competition. Thanks to Jiahao for the collaboration.
- *2024.06*: &nbsp;🏆🏆 Received the First-Class Scholarship from Nanjing University of Information Science and Technology (NUIST). 
</div>

# 📝 Publications 

<details class="publication-section" open markdown="1">
<summary class="publication-summary">
  <span class="publication-summary-title">First-Author Accepted Papers</span>
  <span class="publication-count">5 papers</span>
</summary>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--accepted">ACL 2026</div><img src='images/Augur.png' alt="Augur" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Augur: Modeling Covariate Causal Associations in Time Series via Large Language Models](https://arxiv.org/abs/2510.07858)

**Zhiqing Cui**, Binwu Wang, Qingxiang Liu, Yeqiang Wang, Zhengyang Zhou, Yuxuan Liang, Yang Wang

**ACL 2026 (Main)**
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--accepted">IJCAI 2025</div><img src='images/CauAir.png' alt="CauAir" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Causal Learning Meet Covariates: Empowering Lightweight and Effective Nationwide Air Quality Forecasting](https://doi.org/10.24963/ijcai.2025/353)

Jiaming Ma†, **Zhiqing Cui†**, Binwu Wang, Pengkun Wang, Zhengyang Zhou, Zhe Zhao, Yang Wang

**IJCAI 2025 (Oral)**

† Equal contribution
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--accepted">IEEE TKDE</div><img src='images/madgcn.png' alt="MADGCN" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[MADGCN: A Meteorology-Aware Spatio-Temporal Graph Convolution Network for Long-term Air Pollution Forecasting](https://doi.org/10.1109/TKDE.2026.3692204)

**Zhiqing Cui†**, Binwu Wang†, Guanjun Wang, Zhengyang Zhou, Fan Meng, Jingjia Luo, Yang Wang

**IEEE Transactions on Knowledge and Data Engineering (TKDE)**

† Equal contribution
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--accepted">ACM MM 2025</div><img src='images/Dwt.png' alt="Draw with Thought" width="100%"></div></div>
<div class='paper-box-text' markdown="1">
[Draw with Thought: Unleashing Multimodal Reasoning for Scientific Diagram Generation](https://arxiv.org/abs/2504.09479)

**Zhiqing Cui**, Jiahao Yuan, Hanqing Wang, Yanshu Li, Chenxu Du, Zhenglong Ding

**ACM MM 2025 (Oral)**
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--accepted">Frontiers of Computer Science</div><img src='images/TC.png' alt="Prithvi-TC" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Breaking through tropical cyclone intensity prediction: a foundation model Prithvi-TC](https://doi.org/10.1007/s11704-025-41268-6)

**Zhiqing Cui**, Fan Meng, Jingjia Luo

**Frontiers of Computer Science**
</div>
</div>

</details>

<details class="publication-section" markdown="1">
<summary class="publication-summary">
  <span class="publication-summary-title">First-Author Preprints</span>
  <span class="publication-count">4 papers</span>
</summary>
<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--preprint">arXiv</div><img src='images/scope-router.png' alt="SCOPE-Router" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[SCOPE-Router: Cost-Aware Open-Set VLM Routing for Execution-Oriented Tasks](https://arxiv.org/abs/2608.12127)

Tao Yu†, Yifei Qu†, **Zhiqing Cui†** (Project Leader), Pengfei Zhou, Zhongtian Luo, Yujia Yang, Shenghua Chai, Haopeng Jin, Zhenghao Zhang, Xinming Wang, Hongzhu Yi, Wangbo Zhao, Zhenglin Wan, Yan Huang, Yeshani, Jinwen Luo, Yang You

**arXiv preprint**

† Equal contribution
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--preprint">arXiv</div><img src='images/uno.png' alt="Uno-Orchestra" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Uno-Orchestra: Parsimonious Agent Routing via Selective Delegation](https://arxiv.org/abs/2605.05007)

**Zhiqing Cui**, Haotong Xie, Jiahao Yuan, Cheng Yang, Hanqing Wang, Yuxin Wu, Yifan Wu, Siru Zhong, Tao Yu, Yifu Guo, Siyu Zhang, Xinlei Yu, Qibing Ren, Usman Naseem

</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--preprint">arXiv</div><img src='images/paperx.png' alt="paperx" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[PaperX: A Unified Framework for Multimodal Academic Presentation Generation with Scholar DAG](https://arxiv.org/abs/2602.03866)

Tao Yu†, Minghui Zhang†, **Zhiqing Cui†** (Project Leader), Hao Wang, Zhongtian Luo, Shenghua Chai, Junhao Gong, Yuzhao Peng, Yuxuan Zhou, Yujia Yang, Zhenghao Zhang, Haopeng Jin, Xinming Wang, Yufei Xiong, Jiabing Yang, Jiahao Yuan, Hanqing Wang, Hongzhu Yi, YiFan Zhang, Yan Huang, Liang Wang

**arXiv preprint**

† Equal contribution
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--preprint">arXiv</div><img src='images/connect.png' alt="Regional Barrier" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Breaking the Regional Barrier: Inductive Semantic Topology Learning for Worldwide Air Quality Forecasting](https://arxiv.org/abs/2601.21899)

**Zhiqing Cui**, Siru Zhong, Ming Jin, Shirui Pan, Qingsong Wen, Yuxuan Liang

**arXiv preprint**

</div>
</div>

</details>

<details class="publication-section" markdown="1">
<summary class="publication-summary">
  <span class="publication-summary-title">Co-Authored Papers</span>
  <span class="publication-count">6 papers</span>
</summary>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--accepted">ECCV 2026</div><img src='images/dag.png' alt="Diffusion Models are Open-World Affordance Learners" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Diffusion Models are Open-World Affordance Learners: Leveraging Generative Priors for 3D Affordance Learning](https://arxiv.org/abs/2508.01651)

Hanqing Wang, Zhenhao Zhang, Kaiyang Ji, Mingyu Liu, Wenti Yin, Yuchao Chen, Zhirui Liu, Xiangyu Zeng, Tianxiang Gui, Hangxing Zhang, Jiahao Yuan, **Zhiqing Cui**, Jiaxin Liu, Zhiyuan Ma, Hui Xiong

**ECCV 2026**
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--accepted">ICML 2026</div><img src='images/drop.png' alt="DropoutTS" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[DropoutTS: Sample-Adaptive Dropout for Robust Time Series Forecasting](https://arxiv.org/abs/2601.21726)

Siru Zhong, Yiqiu Liu, **Zhiqing Cui**, Zezhi Shao, Fei Wang, Qingsong Wen, Yuxuan Liang

**ICML 2026**
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--accepted">ACL 2025</div><img src='images/Reflect.png' alt="ReflectDiffu" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[ReflectDiffu: Reflect between Emotion-intent Contagion and Mimicry for Empathetic Response Generation via a RL-Diffusion Framework](https://aclanthology.org/2025.acl-long.1235/)

Jiahao Yuan, Zixiang Di, **Zhiqing Cui**, Guisong Yang, Usman Naseem

**ACL 2025 (Main)**
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--accepted">WWW 2026</div><img src='images/Kardia.png' alt="Kardia-R1" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Kardia-R1: Unleashing LLMs to Reason toward Understanding and Empathy for Emotional Support via Rubric-as-Judge Reinforcement Learning](https://arxiv.org/abs/2512.01282)

Jiahao Yuan, **Zhiqing Cui**, Hanqing Wang, Yuansheng Gao, Yucheng Zhou, Usman Naseem

**WWW 2026**
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--accepted">AAAI 2026</div><img src='images/Affor.png' alt="Affordance-R1" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Affordance-R1: Reinforcement Learning for Generalizable Affordance Reasoning in Multimodal Large Language Model](https://arxiv.org/abs/2508.06206)

Hanqing Wang, Shaoyang Wang, Yiming Zhong, Zemin Yang, Jiamin Wang, **Zhiqing Cui**, Jiahao Yuan, Yifan Han, Mingyu Liu, Yuexin Ma

**AAAI 2026 (Oral)**
</div>
</div>

<div class='paper-box'><div class='paper-box-image paper-box-image--landscape'><div><div class="badge badge--accepted">ACL 2025</div><img src='images/less-is-more-poster.png' alt="Less is More poster" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[LLMSR@XLLM25: Less is More: Enhancing Structured Multi-Agent Reasoning via Quality-Guided Distillation](https://aclanthology.org/2025.xllm-1.23/)

Jiahao Yuan, Xingzhe Sun, Xing Yu, Jingwen Wang, Dehui Du, **Zhiqing Cui**, Zixiang Di

**XLLM@ACL 2025 (Shared Task, 3rd Place)**
</div>
</div>

</details>

<details class="publication-section" markdown="1">
<summary class="publication-summary">
  <span class="publication-summary-title">preprint Papers</span>
  <span class="publication-count">3 papers</span>
</summary>
<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--preprint">arXiv</div><img src='images/omni-deepsearch.png' alt="Omni-DeepSearch" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Omni-DeepSearch: A Benchmark for Audio-Driven Omni-Modal Deep Search](https://arxiv.org/abs/2605.08762)

Tao Yu, Yiming Ding, Shenghua Chai, Minghui Zhang, Zhongtian Luo, Xinming Wang, Xinlong Chen, Zhaolu Kang, Junhao Gong, Yuxuan Zhou, Haopeng Jin, **Zhiqing Cui**, Jiabing Yang, YiFan Zhang, Hongzhu Yi, Zheqi He, Xi Yang, Yan Huang, Liang Wang

**arXiv preprint**
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--preprint">arXiv</div><img src='images/videoafford.png' alt="VideoAfford" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[VideoAfford: Grounding 3D Affordance from Human-Object-Interaction Videos via Multimodal Large Language Model](https://arxiv.org/abs/2602.09638)

Hanqing Wang, Mingyu Liu, Xiaoyu Chen, Chengwei Ma, Yiming Zhong, Wenti Yin, Yuhao Liu, **Zhiqing Cui**, Jiahao Yuan, Lu Dai, Zhiyuan Ma, Hui Xiong

**arXiv preprint**
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge badge--preprint">arXiv</div><img src='images/ration.png' alt="Rationale-Grounded" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Rationale-Grounded In-Context Learning for Time Series Reasoning with Multimodal Large Language Models](https://arxiv.org/abs/2601.02968)

Qingxiang Liu, **Zhiqing Cui**, Xiaoliang Luo, Yuqian Wu, Zhuoyang Jiang, Huaiyu Wan, Sheng Sun, Lvchun Wang, Wei Yu, Yuxuan Liang

</div>
</div>

</details>


# 🎖 Honors and Awards
- *2024.06*: First-Class Scholarship, Nanjing University of Information Science and Technology (NUIST).
- *2024.09*: First Prize, National Undergraduate Mathematical Contest in Modeling (Jiangsu Province).
- *2025.04*: 3rd Place, ACL LLMSR@ XLLM25 Competition.
- *2025.08*: Second Prize (National Level), China Graduate Mathematical Contest in Modeling (participated independently as an undergraduate).
- *2025.10*: Full Scholarship, AAAI-26 Undergraduate Consortium (UC).
- *2025.12*: Third Prize (National Level), Global Campus AI Algorithm Elite Competition - Smart Meteorology Challenge.
- *2026.03*: Excellent Conclusion (National Level), National Undergraduate Innovation and Entrepreneurship Training Program project on AI for Science (AI4S).
- *2026.06*: Full Scholarship, ACL Diversity and Inclusion Subsidy.
- *2026.06*: Full Scholarship, KDD-26 Undergraduate Consortium (UC).

# 📖 Research Experiences
<div class="research-experience-list">
  <div class="research-experience-item">
    <div class="research-experience-logo"><img src='images/ICAR.png' alt="ICAR logo"></div>
    <div class="research-experience-text"><em>2023 - 2024</em>, Institute of Climate and Application Frontier Research (ICAR), Nanjing University of Information Science and Technology. Mentor: Jingjia Luo.</div>
  </div>
  <div class="research-experience-item">
    <a class="research-experience-logo" href="https://di.ustc.edu.cn/main.htm" aria-label="Data Intelligence Lab website"><img src='images/ustc.png' alt="University of Science and Technology of China logo"></a>
    <div class="research-experience-text"><em>2024 - 2025</em>, Data Intelligence Laboratory, University of Science and Technology of China. Mentors: <a href="https://continualgoing.github.io/">Binwu Wang</a>, Yang Wang.</div>
  </div>
  <div class="research-experience-item">
    <a class="research-experience-logo" href="https://trust-agi.github.io/" aria-label="TrustAGI Lab website"><img src='images/Griffith_University_Logo_Variant_2022.svg' alt="Griffith University logo"></a>
    <div class="research-experience-text"><em>2025 - 2025</em>, TrustAGI Lab, Griffith University. Mentors: <a href="https://mingjin.dev/">Ming Jin</a>, <a href="https://shiruipan.github.io/">Shirui Pan</a>.</div>
  </div>
  <div class="research-experience-item">
    <a class="research-experience-logo" href="https://www.citymind.top/" aria-label="CityMind Lab website"><img src='images/Hong_Kong_University_of_Science_and_Technology-Logo.wine.svg' alt="Hong Kong University of Science and Technology logo"></a>
    <div class="research-experience-text"><em>2025 - 2026</em>, CityMind Lab, Hong Kong University of Science and Technology (Guangzhou). Mentor: <a href="https://yuxuanliang.com/">Yuxuan Liang</a>.</div>
  </div>
  <div class="research-experience-item">
    <a class="research-experience-logo" href="https://zwt233.github.io/" aria-label="PKU Data-Centric AI Group website"><img src='images/pku.png' alt="Peking University logo"></a>
    <div class="research-experience-text"><em>2026 - 2026</em>, PKU-DCAI (Data-Centric AI) Research Group, Peking University. Mentor: <a href="https://zwt233.github.io/">Wentao Zhang</a>.</div>
  </div>
  <div class="research-experience-item">
    <a class="research-experience-logo" href="https://engineering.tamu.edu/cse/profiles/zhang-yu.html" aria-label="Yu Zhang at Texas A&amp;M University"><img src='images/tamu.png' alt="Texas A&amp;M University logo"></a>
    <div class="research-experience-text"><em>2026 - 2026</em>, SKY Lab, Texas A&amp;M University. Mentor: <a href="https://engineering.tamu.edu/cse/profiles/zhang-yu.html">Yu Zhang</a>.</div>
  </div>
  <div class="research-experience-item">
    <a class="research-experience-logo" href="https://mobility.mit.edu/" aria-label="MIT JTL Urban Mobility Lab website"><img src='images/MIT.png' alt="Massachusetts Institute of Technology logo"></a>
    <div class="research-experience-text"><em>2026 - 2026</em>, JTL Transit Lab, UrbanAI Lab, Massachusetts Institute of Technology. Mentors: <a href="https://dusp.mit.edu/people/jinhua-zhao">Jinhua Zhao</a>, <a href="https://mobility.mit.edu/people/dingyi-zhuang/">Dingyi Zhuang</a>.</div>
  </div>
</div>

# 🎓 Services
- **Journal Reviewer**: Neurocomputing, TNNLS, npj AI, JBHI, TASL 
- **Conference Reviewer**: ACL, IJCAI, ICML, NeurIPS, AAAI

# 💻 Internships
<div class="internship-list">
  <div class="internship-item">
    <a class="internship-logo internship-logo--institute" href="https://www.ustciscr.cn/" aria-label="Yangtze River Delta Information Intelligence Innovation Research Institute website">
      <img src='images/yangtze-info-institute.svg' alt="Yangtze River Delta Information Intelligence Innovation Research Institute logo">
    </a>
    <div class="internship-text"><em>2024.06 - 2024.08</em>, Yangtze River Delta Information Intelligence Innovation Research Institute, China.</div>
  </div>
  <div class="internship-item">
    <a class="internship-logo internship-logo--evolvent" href="https://evolvent.co/" aria-label="Evolvent AI website">
      <img src='images/evolvent-ai.png' alt="Evolvent AI logo">
    </a>
    <div class="internship-text"><em>2026.07 - 2026.08</em>, Evolvent AI.</div>
  </div>
</div>

# 👥 Visitors
{% include visitor-map.html %}
