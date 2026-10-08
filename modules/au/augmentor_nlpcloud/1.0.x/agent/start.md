<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NLP Cloud Augmentor (augmentor_nlpcloud) — agent index

Provides integration of the **Augmentor** framework with the **NLP Cloud** REST API. Ships eight Augmentor
plugins that send text to NLP Cloud models and return the result. Version **1.0.2**, core `^10.2 || ^11 || ^12`.

- **Depends on:** `augmentor` (base framework). Composer: `nlpcloud/nlpcloud-client:^1.0`, `drupal/augmentor:^1.0`.
- **Provides:** no routes, no permissions, no config schema of its own. Config, key storage, and admin UI come from
  the Augmentor module (`administer augmentors` permission). One service: `AugmentorNlpcloudHooks` (`hook_help`).
- **Base class:** `src/NPLCloudBase.php` — extends `Drupal\augmentor\AugmentorBase`; `getClient()` builds an
  `NLPCloud\NLPCloud` SDK client with the API key from a Key entity (`getKeyValue()`) and a per-plugin `language`.
- **Plugins** (`src/Plugin/Augmentor/`, plugin type `Augmentor` from the base module):
  - `augmentor_nlpcloud_entities` — Entities extraction / NER (`NLPCloudEntities`).
  - `augmentor_nlpcloud_classification` — zero-shot classification against an entity bundle's labels (`NLPCloudClassification`).
  - `augmentor_nlpcloud_summarization` — summarization (`NLPCloudSummarization`).
  - `augmentor_nlpcloud_headline_generation` — short headline summary (`NLPCloudHeadlineGeneration`).
  - `augmentor_nlpcloud_keywords_and_keyphrases_extraction` — keywords/keyphrases (`NLPCloudKeywordsKeyphrasesExtraction`).
  - `augmentor_nlpcloud_text_generation` — prompt-based text generation (`NLPCloudTextGeneration`).
  - `augmentor_nlpcloud_blog_post_generation` — full blog post from a title (`NLPCloudBlogPostGeneration`).
  - `augmentor_nlpcloud_translation` — 200-language translation, NLLB-200 3.3B (`NLPCloudTranslation`).

## Solution docs

- [Install & operate](agent/config/install.md) — requirements, key setup, how the augmentors are configured and run.
- [Plugins reference](agent/plugins/augmentors.md) — each plugin's `execute()`, models, options, return shape.
