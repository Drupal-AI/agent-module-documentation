<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Glossaries: entities, field, admin, CSV, matching

## Entities

| Entity type id | Base table | What it is |
|---|---|---|
| `deepl_ml_glossary` | `tmgmt_deepl_ml_glossary` | A DeepL **multilingual glossary** (holds dictionaries). |
| `deepl_ml_glossary_dictionary` | `tmgmt_deepl_ml_glossary_dictionary` | One language-pair dictionary inside a glossary. |

Both are `ContentEntityType`s with `AccessControlHandler`, `AdminHtmlRouteProvider`,
`admin_permission: 'administer deepl_glossary entities'`, and `EntityOwnerTrait` (`uid` set on
`preSave`). The classic `deepl_glossary` single-pair entity from 2.2.x has been removed.

### `deepl_ml_glossary` base fields (`Entity/DeeplMultilingualGlossary`)

`id`, `label` (string, required, `UniqueField`), `tmgmt_translator` (list_string; allowed values
from `DeeplTranslator::getTranslators`), `uid` (author, read-only), `glossary_id` (string — the
**remote** DeepL glossary id), `created`, `changed`. Links: add
`/admin/tmgmt/deepl_glossaries/add`, edit/delete `/admin/tmgmt/deepl_glossaries/manage/{id}/…`,
collection `/admin/tmgmt/deepl_glossaries`. Deleting a glossary cascades to its dictionaries
(`::delete()` loads `deepl_ml_glossary_dictionary` by `glossary_id`).

### `deepl_ml_glossary_dictionary` base fields (`Entity/DeeplMultilingualGlossaryDictionary`)

`id`, `label` (read-only; set on `preSave` to `"<source> -> <target>"`), `uid`, `created`,
`glossary_id` (entity_reference → `deepl_ml_glossary`, read-only), `source_lang` / `target_lang`
(list_string, required; allowed values from `DeeplMultilingualGlossaryDictionary::getAllowedLanguages()`
→ the helper), `entry_count` (int, read-only), `entries_format` (list_string, `tsv` only, default
`tsv`), and `entries` — an unlimited-cardinality field of type **`deepl_glossary_item`**.
`getEntries()` returns `[subject => definition]`.

### `deepl_glossary_item` field type (`Plugin/Field/FieldType/DeeplGlossaryItem`)

Two `text` columns `subject` (source text) and `definition` (target text); item is empty unless both
are set. Widget `deepl_glossary_item_widget`, formatter `deepl_glossary_item_formatter`. Config
schema `field.value.deepl_glossary_item` (`subject`/`definition` strings).

## Admin UI

- Overview: View `tmgmt_deepl_ml_glossary` at the collection route
  `entity.deepl_ml_glossary.collection` (`/admin/tmgmt/deepl_glossaries`) — the submodule's
  `configure` route. Dictionaries are listed on the glossary edit form by the
  `tmgmt_deepl_ml_glossary_dictionary` View.
- **Fetch** existing multilingual glossaries from DeepL: `/admin/tmgmt/deepl_glossaries/fetch`
  (`DeeplMultilingualGlossaryFetchForm`, route `tmgmt_deepl_glossary.fetch_form`, permission
  `administer deepl_glossary entities`).
- **CSV upload** dictionary entries: `/admin/tmgmt/deepl_glossaries/{deepl_ml_glossary}/csv-upload`
  (`DeeplMultilingualGlossaryCsvUploadForm`, permission `edit deepl_glossary glossary entries`).
- **CSV download** a dictionary: `/admin/tmgmt/deepl_glossaries/dictionary/{dictionary}/csv`
  (`GlossaryDictionaryCsvController::download`, permission `edit deepl_glossary glossary entries`);
  also offered as an `entity_operation` on each dictionary.
- Add/edit/delete via the entity forms (`DeeplMultilingualGlossary*Form`).

## How a glossary reaches a translation job

`TmgmtDeeplGlossaryHooks` implements the parent's alter hooks:

- `hook_tmgmt_deepl_has_checkout_settings_alter` / `..._checkout_settings_form_alter` add a
  "Select DeepL glossary" field when more than one glossary matches the job's translator + remote
  source/target language (`DeeplMultilingualGlossaryHelper::getMatchingGlossaries()`).
- `hook_tmgmt_deepl_translate_options_alter` sets `$options['glossary']` to the selected glossary's
  remote `glossary_id`, or auto-selects the first matching glossary when none was chosen.

## Create a glossary locally (scriptable — saving the entity does not call DeepL)

```php
$g = \Drupal::entityTypeManager()->getStorage('deepl_ml_glossary')->create([
  'label' => 'Brand terms',
  'tmgmt_translator' => 'deepl',   // a deepl_api provider name
  'glossary_id' => '',             // filled after creating it on DeepL
]);
$g->save();

$d = \Drupal::entityTypeManager()->getStorage('deepl_ml_glossary_dictionary')->create([
  'glossary_id' => $g->id(),
  'source_lang' => 'EN',
  'target_lang' => 'DE',
  'entries' => [['subject' => 'dashboard', 'definition' => 'Übersicht']],
]);
$d->save();
```

Creating/updating/deleting the glossary **on DeepL** goes through
`DeeplMultilingualGlossaryApi` / the helper (see [../api/services.md](../api/services.md)); those
calls use the parent module's Key. The remote `glossary_id` is stored back on the entity.
