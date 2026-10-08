<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
NLP Cloud Augmentor exposes eight NLP Cloud API tasks (summarize, classify, generate, translate, extract) as Augmentor plugins for use in Augmentor AI-augmentation workflows.

---

NLP Cloud Augmentor is a provider module for the Augmentor framework. It ships eight Augmentor plugins — Entities extraction (NER), Classification, Summarization, Headline generation, Keywords & keyphrases extraction, Text generation, Blog post generation, and Translation — that all extend the shared `NPLCloudBase` class and call NLP Cloud's REST API through the `nlpcloud/nlpcloud-client` PHP SDK. Each plugin has an `execute(string $text)` method that Augmentor calls to send text to a selected NLP Cloud model and return the result under a `default` key (or an `_errors` message on failure). Model, language, and task-specific options (translation source/target, summary size, classification threshold, generation max length, etc.) are configured per-augmentor in Augmentor's admin UI. The NLP Cloud API key is read through a Key entity via the Augmentor base, and calls are made to the fixed `https://api.nlpcloud.io` endpoint over HTTPS. Because the plugins are standard Augmentors, they can be wired into any Augmentor-driven pipeline (field widgets, ECA/automations, batch content processing) that the Augmentor module supports.

---

- Summarize long body text into a shorter abstract with the Summarization augmentor (Bart Large CNN / GPT-J / GPT-NeoX; small or large size).
- Generate a short headline-style summary from an article with the Headline generation augmentor (T5 Base EN model).
- Classify content against the labels of an entity bundle using the Classification augmentor with a configurable score threshold.
- Auto-suggest taxonomy/category labels for a node by classifying its text against a chosen bundle.
- Extract named entities (people, places, organizations) from text with the Entities extraction (NER) augmentor.
- Pull the main keywords and keyphrases from an article for meta tags or search with the Keywords & keyphrases extraction augmentor.
- Free-form text generation / autocompletion from a prompt with the Text generation augmentor (Fine-tuned LLaMA 2 70B, Dolphin, ChatDolphin, or a custom model).
- Draft a full blog post from a title with the Blog post generation augmentor.
- Translate field content between 200 languages with the Translation augmentor (Facebook NLLB-200 3.3B).
- Localize editorial content by wiring a Translation augmentor into a translated field's workflow.
- Fill a summary or teaser field automatically from the main body using an Augmentor field integration.
- Build multi-step content pipelines (e.g. summarize then classify) by chaining several NLP Cloud augmentors in Augmentor.
- Use your own custom NLP Cloud model by entering its model name where a model select is offered.
- Choose GPU vs CPU behavior per task (defaults are set per plugin) for latency vs cost trade-offs.
- Set the source language of input text so NLP Cloud translates it to English before processing.
- Tune classification precision by adjusting the threshold and the maximum number of labels.
- Provide a custom "no result" message when classification returns nothing above the threshold.
- Constrain generation length via the Max Length option for LLaMA 2 70B / Dolphin models.
- Template a generation prompt with a `{input}` placeholder in the Text generation Context field.
- Centralize NLP Cloud API-key storage via a Key entity shared across all the augmentors.
- Prefer NLP Cloud for GDPR-sensitive deployments (European servers, no user-data retention) over other AI services.
- Process content in batch by attaching augmentors to Augmentor's batch/queue tooling.
- Enrich imported content with entities, keywords, or summaries as part of a migration or feed workflow.
- Standardize AI text processing across a site by using NLP Cloud as the Augmentor provider.
