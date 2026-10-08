<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeepL glossary API services

The submodule wraps DeepL's **multilingual** glossary endpoints through the deepl-php SDK. All calls
use the parent module's DeepL client (resolved from the translator's Key entity), so they need a
valid DeepL API key.

## Services (`tmgmt_deepl_glossary.services.yml`)

| Service id | Class | Role |
|---|---|---|
| `tmgmt_deepl_glossary.ml.api` | `DeeplMultilingualGlossaryApi` | Multilingual glossary API: create / update / replace-dictionary / get-metadata / list / delete glossary + dictionary, read entries. |
| `tmgmt_deepl_glossary.ml.helper` | `DeeplMultilingualGlossaryHelper` | Allowed languages, valid language pairs, matching glossaries for a job, CSV parse/validate, save a dictionary from entries. |
| `tmgmt_deepl_glossary.ml.batch` | `DeeplMultilingualGlossaryBatch` | Batch helpers for bulk glossary/dictionary operations. |

`DeeplMultilingualGlossaryApi` is constructed with `entity_type.manager`, the parent's
`tmgmt_deepl.client_factory`, a logger channel and `messenger`; the helper adds `module_handler` and
the parent's `tmgmt_deepl.language_support`. Public interfaces:
`DeeplMultilingualGlossaryApiInterface`, `DeeplMultilingualGlossaryHelperInterface`.

## `DeeplMultilingualGlossaryApi` methods

- `setTranslator(TranslatorInterface)` — select the DeepL provider whose key/client is used.
- `getDeeplClient(): DeepLClient` — build the client via the factory (throws if no translator set).
- `isFreeAccount(): bool` — `DeepLClient::isAuthKeyFreeAccount()` on the resolved key.
- `createMultilingualGlossary(string $name, array $dictionaries): ?MultilingualGlossaryInfo`
  — each dictionary is `['source_lang','target_lang','entries']`; entries become
  `GlossaryEntries` / `MultilingualGlossaryDictionaryEntries`.
- `updateMultilingualGlossary($glossary_id, $name, $dictionaries)`,
  `replaceMultilingualGlossaryDictionary($glossary_id, $source, $target, $entries, $name='')`.
- `getMultilingualGlossaryMetadata($glossary_id)`, `getMultilingualGlossaries()`,
  `getMultilingualGlossaryEntries($glossary_id, $source, $target)` (returns
  `[['subject'=>…, 'definition'=>…], …]`).
- `deleteMultilingualGlossary($glossary_id)`,
  `deleteMultilingualGlossaryDictionary($glossary_id, $source, $target)`.

Every method catches `DeepLException`, shows it via `messenger`, logs it, and returns a null/empty/
false fallback — so a failed remote call never throws out of the service.

```php
$api = \Drupal::service('tmgmt_deepl_glossary.ml.api');
$api->setTranslator(\Drupal\tmgmt\Entity\Translator::load('deepl'));
$info = $api->createMultilingualGlossary('Brand terms', [
  ['source_lang' => 'EN', 'target_lang' => 'DE', 'entries' => ['dashboard' => 'Übersicht']],
]);
```

## `DeeplMultilingualGlossaryHelper` (selected methods)

- `getAllowedLanguages(?TranslatorInterface): array` — uppercase DeepL glossary languages from the
  API's glossary language resource (cached), filtered by
  `hook_tmgmt_deepl_glossary_allowed_languages_alter`; falls back to a static list when no
  translator/API data is available.
- `getAllowedTranslators()`, `isValidLanguagePair($source, $target, ?$translator)`,
  `fixLanguageMappings($langcode)` (normalize e.g. `ZH-HANS` → generic `ZH`).
- `getMatchingGlossaries($translator, $source_lang, $target_lang): array` — glossaries whose
  dictionary matches, keyed by entity id (drives the checkout selector and auto-selection).
- `hasMultilingualGlossaryDictionary(...)`, `validateSourceTargetLanguage(&$form, $form_state)`.
- CSV: `parseCsvContent($csv)`, `validateCsvEntries($entries, $form_state, $prefix='entries')`.
- `saveGlossaryDictionary(MultilingualGlossaryInfo, $dictionary, $translator)` and
  `createOrUpdateDictionaryFromEntries($glossary, $source, $target, $entries)` — reconcile the local
  `deepl_ml_glossary_dictionary` entity with the remote glossary.

## Typical flow

1. Create a `deepl_ml_glossary` + dictionaries locally (see
   [../configure/glossaries.md](../configure/glossaries.md)) — no API call yet.
2. Create/update on DeepL through the API service; DeepL returns a glossary id stored on the entity.
3. The parent `tmgmt_deepl` translator references that glossary id (`$options['glossary']`) when
   translating a matching job. Deleting the entity removes the remote glossary + dictionaries.
