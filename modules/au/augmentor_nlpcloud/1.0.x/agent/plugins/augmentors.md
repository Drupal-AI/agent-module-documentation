<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NLP Cloud Augmentor plugins reference

All plugins live in `src/Plugin/Augmentor/`, use the `#[Augmentor(...)]` attribute (plugin type from the base
`augmentor` module), and extend `NPLCloudBase`. Each implements `execute(string $text): array` returning
`['default' => <value>]` or, on any `\Throwable`, logging to the `augmentor` channel and returning
`['_errors' => <message>]`. `$gpu` below is the plugin's `NLP_CLOUD_GPU` constant.

| Plugin id | Class | SDK call | Default model | GPU | Returns (`default`) |
|---|---|---|---|---|---|
| `augmentor_nlpcloud_entities` | `NLPCloudEntities` | `entities($text)` | `fast-gpt-j` | no | `json_encode($result->entities)`; input trimmed to first 1024 chars |
| `augmentor_nlpcloud_classification` | `NLPCloudClassification` | `classification($text, $labels, TRUE)` | `bart-large-mnli-yahoo-answers` | no | array of labels scoring above threshold, else the "no result" text |
| `augmentor_nlpcloud_summarization` | `NLPCloudSummarization` | `summarization($text, $size)` | `bart-large-cnn` | no | `$result->summary_text` |
| `augmentor_nlpcloud_headline_generation` | `NLPCloudHeadlineGeneration` | `summarization($text)` on model `t5-base-en-generate-headline` | fixed model | no | `$result->summary_text` |
| `augmentor_nlpcloud_keywords_and_keyphrases_extraction` | `NLPCloudKeywordsKeyphrasesExtraction` | `kwKpExtraction($text)` | `finetuned-llama-2-70b` | yes | `$result->keywords_and_keyphrases` |
| `augmentor_nlpcloud_text_generation` | `NLPCloudTextGeneration` | `generation($context, $maxLength, ...)` | `finetuned-llama-2-70b` | yes | `$result->generated_text` |
| `augmentor_nlpcloud_blog_post_generation` | `NLPCloudBlogPostGeneration` | `articleGeneration($title)` on `fast-gpt-j` | fixed model | yes | `$result->generated_article` |
| `augmentor_nlpcloud_translation` | `NLPCloudTranslation` | `translation($text, $source, $target)` on `nllb-200-3-3b` | fixed model | no | `$result->translation_text` |

## Notes per plugin

- **Entities (NER)** — `getSupportedModels()`: `en_core_web_lg`, `fast-gpt-j`, `finetuned-gpt-neox-20b`. Input is
  `substr($text, 0, 1024)` to approximate the 256-token synchronous limit; result is JSON-encoded entity array.
- **Classification** — the only plugin with an injected constructor (adds `entity_type.bundle.info` and
  `entity_type.manager`). `getBundleLabels()` runs an access-checked entity query (`accessCheck(TRUE)`, published only)
  over the selected entity type + bundle, capped at "Max labels", and uses those entity labels as candidate categories.
  `getLabelsFromResult()` keeps labels whose score exceeds the configured **threshold**; empty → the "No result" string.
  `getSupportedEntityTypes()` lists content-entity types that have a bundle entity type.
- **Summarization** — models `bart-large-cnn`, `fast-gpt-j`, `finetuned-gpt-neox-20b`; **Size** select `small`/`large`.
- **Headline generation** — no config form beyond the base; hardwired to `t5-base-en-generate-headline` and calls the
  SDK's `summarization()`.
- **Keywords & keyphrases** — models `finetuned-llama-2-70b`, `dolphin`.
- **Text generation** — builds `$context` by `str_replace('{input}', preg_replace("/[^A-Za-z0-9 ]/", '', $text), ...)`
  (strips non-alphanumerics from the input before templating). Passes a long fixed argument list to `generation()`
  (max length, plus fixed sampling params). Models `finetuned-llama-2-70b`, `chatdolphin`, `dolphin`. **Max Length**
  field is shown only for LLaMA 2 70B / Dolphin.
- **Blog post generation** — calls the SDK's `articleGeneration()`, which NLP Cloud has **deprecated**; on error it also
  logs a note pointing to issue 3400729. Returns the generated HTML article.
- **Translation** — `getSupportedLanguages()` enumerates ~200 NLLB language codes (e.g. `eng_Latn`, `fra_Latn`).
  Source defaults `eng_Latn`, target defaults `fra_Latn`.

## Base class (`NPLCloudBase`)

- `defaultConfiguration()` adds `language => NULL` on top of `AugmentorBase`.
- `buildConfigurationForm()` adds the **Language** textfield; `submitConfigurationForm()` saves it.
- `getClient(string $model, bool $gpu = FALSE, string $language = '', bool $asynchronous = FALSE)` memoizes and returns
  an `NLPCloud\NLPCloud` client, passing `getKeyValue()` (Key entity value) as the token. The SDK targets
  `https://api.nlpcloud.io/v1/` over HTTPS and sends the token as an `Authorization: Token` header.
