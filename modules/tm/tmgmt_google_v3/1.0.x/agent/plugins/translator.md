# The `google_v3` TranslatorPlugin

Contributes one plugin to TMGMT's `tmgmt.translator` plugin type.

## Definition

```
@TranslatorPlugin(
  id = "google_v3",
  label = @Translation("Google V3"),
  description = @Translation("Google V3 Translator service."),
  ui = "Drupal\tmgmt_google_v3\GoogleV3TranslatorUi",
  logo = "icons/google.svg",
)
```

Class `GoogleV3Translator` extends `TranslatorPluginBase`, implements
`ContainerFactoryPluginInterface` and **`ContinuousTranslatorInterface`** (so it supports
continuous jobs). Injected: `tmgmt.data`, `entity_type.manager`, `event_dispatcher`.

## Key methods

| Method | Behaviour |
|---|---|
| `checkAvailable($translator)` | `AvailableResult::yes()` only if `location`, `api_project` and `google_credentials` settings are all set; else `no()` with a link to configure. |
| `requestTranslation($job)` | translates all job items, then marks the job `submitted` unless rejected. |
| `requestJobItemsTranslation($items)` | per item: flatten translatable data (`tmgmt.data`), translate each segment, dispatch `PostTranslationEvent`, then `addTranslatedData()`. Continuous jobs mark items active first. |
| `getSupportedRemoteLanguages($translator)` | initializes the client and calls Google `getSupportedLanguages()`; used by the form's Connect button. |
| `hasCheckoutSettings($job)` | returns FALSE (no per-job checkout settings). |

## Translation internals

- `initializeClient()` loads the credentials **file** (from the `google_credentials` fids),
  resolves its real path, and constructs `Google\Cloud\Translate\V3\TranslationServiceClient`
  with `['credentials' => <path>]`.
- `googleTranslateRequestTranslation()` builds a context from the job's remote source/target
  languages, the `api_project` and `location`, plus `glossary_mappings`.
- `executeTranslation()`:
  - **Chunks** any text longer than **20,000 characters** (recursively) to respect API limits.
  - Calls `translateText($contents, $targetLang, $parent, $options)` with `sourceLanguageCode`.
  - If a glossary is mapped for the target **local** language, adds a
    `TranslateTextGlossaryConfig` (`glossaries/<id>`, `ignore_case = TRUE`) and prefers the
    glossary translation in the response.
  - Always `close()`s the client afterward.

## Error / quota handling

- On `ApiException` with code `RESOURCE_EXHAUSTED` for a **continuous** job, the job item is set
  `INACTIVE` ("Translation quota exhausted…") to retry later.
- Other API errors `reject` the job with the error message.

Language note: `language_to_local` (Drupal langcode) can differ from `language_to_remote`
(Google model code) — e.g. zh-hant variants — letting each local language carry its own glossary
while sharing a Google model.
