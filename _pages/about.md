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

# 🔍 Research Topics

My research interests include spatiotemporal data mining and multimodal reasoning. Currently, I am dedicated to studying the practical applications of spatiotemporal data mining in large-scale real-world scenarios, particularly in Earth science and air pollution management. I worked with Assistant Professor [Binwu Wang](https://github.com) at USTC on spatiotemporal data mining for over a year, publishing multiple papers. Currently, I am a visiting intern at HKUST(GZ) with Professor [Yuxuan Liang](https://github.com). I am particularly interested in causal relationships in data and strive to introduce large model reasoning processes into real-world scenarios. Additionally, I am interested in LLM agents, reasoning, and memory and collaborate with [Jiahao Yuan](https://github.com) in the field of Large Language Models (LLM). My research aims to enhance human understanding of the Earth's environment and practical applications in the real world.


# 🔥 News
- *2025.11*: &nbsp;🏆🏆 Received full funding from the AAAI Undergraduate Consortium.
- *2025.10*: &nbsp;🎉🎉 My paper "Augur: Modeling Covariate Causal Associations in Time Series via Large Language Models" was published on arXiv.
- *2025.06*: &nbsp;🎉🎉 My led work "Draw with Thought" was accepted by ACM MM, and I delivered the oral presentation.
- *2025.04*: &nbsp;🎉🎉 My first top-tier conference paper "CauAir" was accepted as an oral presentation at IJCAI. I was responsible for compiling the large-scale dataset LargeAQ and delivering the oral presentation. Thanks to Binwu and Jiaming for their contributions.
- *2025.03*: &nbsp;🎉🎉 My work on foundation models for tropical cyclones was accepted by Frontiers of Computer Science. Presented at EGU, AGU, and other meteorology conferences, and received recognition from NASA.
- *2025.02*: &nbsp;🏆🏆 Won the 3rd place in the ACL LLMSR@ XLLM25 competition. Thanks to Jiahao for the collaboration.
- *2024.06*: &nbsp;🏆🏆 Received the First-Class Scholarship from Nanjing University of Information Science and Technology (NUIST). 

# 📝 Publications 

## First-Author Accepted Papers

<div class='paper-box'><div class='paper-box-image'><div><div class="badge">IJCAI 2025</div><img src='images/CauAir.png' alt="CauAir" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Causal Learning Meet Covariates: Empowering Lightweight and Effective Nationwide Air Quality Forecasting]()

**Jiaming Ma***, **Zhiqing Cui***, Binwu Wang, Pengkun Wang, Zhengyang Zhou, Zhe Zhao, Yang Wang

**IJCAI 2025 (Oral)**
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge">ACM MM 2025</div><img src='images/Dwt.png' alt="Draw with Thought" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Draw with Thought: Unleashing Multimodal Reasoning for Scientific Diagram Generation]()

**Zhiqing Cui**, Jiahao Yuan, Hanqing Wang, Yanshu Li, Chenxu Du, Zhenglong Ding

**ACM MM 2025 (Oral)**
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge">Frontiers of Computer Science</div><img src='images/TC.png' alt="Prithvi-TC" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Breaking through tropical cyclone intensity prediction: a foundation model Prithvi-TC]()

**Zhiqing Cui**, Fan Meng, Jingjia Luo

**Frontiers of Computer Science**
</div>
</div>

## First-Author Preprints

<div class='paper-box'><div class='paper-box-image'><div><div class="badge">arXiv</div><img src='images/Augur.png' alt="Augur" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Augur: Modeling Covariate Causal Associations in Time Series via Large Language Models]()

**Zhiqing Cui**, Binwu Wang, Qingxiang Liu, Yeqiang Wang, Zhengyang Zhou, Yuxuan Liang, Yang Wang

**arXiv preprint**
</div>
</div>

## Co-Authored Papers

<div class='paper-box'><div class='paper-box-image'><div><div class="badge">ACL 2025</div><img src='images/Reflect.png' alt="ReflectDiffu" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[ReflectDiffu: Reflect between Emotion-intent Contagion and Mimicry for Empathetic Response Generation via a RL-Diffusion Framework]()

Jiahao Yuan, Zixiang Di, **Zhiqing Cui**, Guisong Yang, Usman Naseem

**ACL 2025 (Main Conference)**
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge">WWW</div><img src='images/Kardia.png' alt="Kardia-R1" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Kardia-R1: Unleashing LLMs to Reason toward Understanding and Empathy for Emotional Support via Rubric-as-Judge Reinforcement Learning]()

Jiahao Yuan, **Zhiqing Cui**, Hanqing Wang, Yuansheng Gao, Yucheng Zhou, Usman Naseem

**WWW4Good**
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge">AAAI 2026</div><img src='images/Affor.png' alt="Affordance-R1" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Affordance-R1: Reinforcement Learning for Generalizable Affordance Reasoning in Multimodal Large Language Model]()

Hanqing Wang, Shaoyang Wang, Yiming Zhong, Zemin Yang, Jiamin Wang, **Zhiqing Cui**, Jiahao Yuan, Yifan Han, Mingyu Liu, Yuexin Ma

**AAAI 2026 (Oral)**
</div>
</div>

<div class='paper-box'><div class='paper-box-image'><div><div class="badge">arXiv</div><img src='images/ration.png' alt="Rationale-Grounded" width="100%"></div></div>
<div class='paper-box-text' markdown="1">

[Rationale-Grounded In-Context Learning for Time Series Reasoning with Multimodal Large Language Models]()

Qingxiang Liu, **Zhiqing Cui**, Xiaoliang Luo, Yuqian Wu, Zhuoyang Jiang, Huaiyu Wan, Sheng Sun, Lvchun Wang, Wei Yu, Yuxuan Liang

**arXiv preprint**
</div>
</div>

# 🎖 Honors and Awards
- *2024.06*: First-Class Scholarship, Nanjing University of Information Science and Technology (NUIST).
- *2024.09*: First Prize, National Undergraduate Mathematical Contest in Modeling (Jiangsu Province).
- *2025.04*: 3rd Place, ACL LLMSR@ XLLM25 Competition.
- *2025.08*: Second Prize (National Level), China Graduate Mathematical Contest in Modeling (participated independently as an undergraduate).
- *2025.10*: Full Scholarship, AAAI-26 Undergraduate Consortium (UC).
- *2025.12*: Third Prize (National Level), Global Campus AI Algorithm Elite Competition - Smart Meteorology Challenge. 

# 📖 Research Experiences
- *2023 - 2024*, <img src='images/ICAR.png' alt="ICAR" style="height: 1em; vertical-align: middle;"> Institute of Climate and Application Frontier Research (ICAR), Nanjing University of Information Science and Technology. Mentor: Jingjia Luo.
- *2024 - 2025*, <img src='images/ustc.png' alt="USTC" style="height: 1em; vertical-align: middle;"> Data Intelligence Laboratory, University of Science and Technology of China. Mentor: Binwu Wang, Yang Wang.
- *2025 - 2026*, <img src='images/Hong_Kong_University_of_Science_and_Technology-Logo.wine.svg' alt="HKUST" style="height: 1em; vertical-align: middle;"> CityMind Lab, Hong Kong University of Science and Technology(Guang Zhou). Mentor: Yuxuan Liang.
- *2025 - 2026*, <img src='images/Griffith_University_Logo_Variant_2022.svg' alt="Griffith" style="height: 1em; vertical-align: middle;"> TrustAGI Lab, Griffith University. Mentors: Ming Jin, Shirui Pan. 

# 🎓 Services
- **Journal Reviewer**: Neurocomputing
- **Conference Reviewer**: ACL

# 💻 Internships
- *2024.06 - 2024.08*, Yangtze River Delta Information Intelligence Innovation Research Institute, China.

# 👥 Visitors
{% include visitor-map.html %}
