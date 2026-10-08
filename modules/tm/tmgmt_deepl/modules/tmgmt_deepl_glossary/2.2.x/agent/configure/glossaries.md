<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Glossaries: entities, field, admin, sync

## Entities

| Entity type id | Base table | What it is |
|---|---|---|
| `deepl_glossary` | `tmgmt_deepl_glossary` | A classic single-language-pair DeepL glossary. |
| `deepl_ml_glossary` | `tmgmt_deepl_ml_glossary` | A DeepL **multilingual** glossary (holds dictionaries). |
| `deepl_ml_glossary_dictionary` | — | One language-pair dictionary inside a multilingual glossary. |

### `deepl_glossary` base fields

`id`, `label` (string), `source_lang` (list_string), `target_lang` (list_string),
`tmgmt_translator` (list_string — which DeepL provider it belongs to), `glossary_id` (string —
the **remote** DeepL glossary id), `ready` (boolean — synced/usable), `created`,
`entry_count` (integer), `entries_format` (list_string), and `entries` — a multi-value field of
type **`deepl_glossary_item`** whose each item stores a `subject` and a `definition` (the
source term → target term pair; schema `field.value.deepl_glossary_item`).

Admin permission: `administer deepl_glossary entities`.

## Admin UI

- Overview: the **View** `view.tmgmt_deepl_glossary.page_1` (the submodule's `configure` route).
- Fetch existing multilingual glossaries from DeepL:
  `/admin/tmgmt/deepl_glossaries/fetch` (form `DeeplMultilingualGlossaryFetchForm`, route
  `tmgmt_deepl_glossary.fetch_form`, permission `administer deepl_glossary entities`).
- Add/edit/delete via the entity forms (`DeeplGlossaryForm`, `DeeplGlossaryDeleteForm`, and the
  multilingual + dictionary forms). A `DeeplGlossarySyncForm` pushes a glossary to DeepL.

## Create a glossary locally (scriptable — saving the entity does not call DeepL)

```php
$g = \Drupal::entityTypeManager()->getStorage('deepl_glossary')->create([
  'label' => 'Brand terms EN→DE',
  'source_lang' => 'en',
  'target_lang' => 'de',
  'tmgmt_translator' => 'deepl',        // a deepl_free/deepl_pro provider name (optional here)
  'glossary_id' => '',                   // filled in after syncing to DeepL
  'ready' => FALSE,
  'entries' => [
    ['subject' => 'dashboard', 'definition' => 'Übersicht'],
  ],
]);
$g->save();
```

```bash
drush php:eval '$g = \Drupal::entityTypeManager()->getStorage("deepl_glossary")->load(1); print $g->label();'
```

## Sync to DeepL

Creating/syncing/deleting the glossary **on DeepL** goes through the API service classes
(`tmgmt_deepl_glossary.api` / `.ml.api`, see [../api/services.md](../api/services.md)); those calls
need the parent module's DeepL auth key. After a successful create, the remote `glossary_id` is
written back to the entity and `ready` becomes TRUE.
