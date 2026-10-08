# scanner — programmatic search & replace (service/plugin API)

The engine is the **Scanner plugin manager** service `plugin.manager.scanner`
(`\Drupal\scanner\Plugin\ScannerPluginManager`). Each supported entity type is a plugin whose
id is `scanner_<entity_type>` (e.g. `scanner_node`, `scanner_paragraph`,
`scanner_commerce_product`). Every plugin implements `\Drupal\scanner\Plugin\ScannerPluginInterface`:

- `search(string $field, array $values): array` — find matches. `$field` is
  `entity_type:bundle:field_name` (e.g. `node:article:body`; the entity-type segment is
  informational — the plugin uses its own `type`). Returns a results array (see shape below).
- `replace(array $results_data, array $values, array $undo_data): array` — apply the
  replacement to the entities found by `search()`; returns `$undo_data` (old/new revision ids).
- `undo(array $data): void` — restore a prior revision from one `replace()` undo entry.

`$values` is the search-form value array; keys used by the engine:

| Key | Type | Meaning |
|---|---|---|
| `search` | string | Term to find (a regex when `regex` is TRUE) |
| `replace` | string | Replacement string (used by `replace()`) |
| `mode` | bool | TRUE = case-sensitive |
| `wholeword` | bool | TRUE = match whole words only (`\b…\b`) |
| `regex` | bool | TRUE = treat `search` as a regular expression |
| `preceded` | string | Only match when preceded by this (lookbehind); `''` for none |
| `followed` | string | Only match when followed by this (lookahead); `''` for none |
| `published` | bool | TRUE = only published nodes |
| `language` | string | Langcode, or `all` |

Replacement uses PHP `preg_replace` over each field value on **text** (`text`, `text_long`,
`text_with_summary` incl. summary), **string** (`string`, `string_long`), and **link** (uri +
title) fields. On revisionable entities each changed entity gets a **new revision** with a log
message, so it can be reverted via the Undo tab or `undo()`.

## Full example — replace across Article bodies

```php
$manager = \Drupal::service('plugin.manager.scanner');
$plugin  = $manager->createInstance('scanner_node');   // plugin id = scanner_<entity_type>

$values = [
  'search'    => 'Acme Corporation',
  'replace'   => 'Globex Inc',
  'mode'      => FALSE,   // case-insensitive
  'wholeword' => FALSE,
  'regex'     => FALSE,
  'preceded'  => '',
  'followed'  => '',
  'published' => FALSE,
  'language'  => 'all',
];

$field   = 'node:article:body';           // entity_type:bundle:field_name
$results = $plugin->search($field, $values);   // find matches
$undo    = $plugin->replace($results, $values, []);  // apply; returns undo data
// entities are saved by replace(); reload with loadUnchanged() to see new values.
```

## Results shape (from `search()`, consumed by `replace()`)

```
[
  'type'   => 'node',
  'label'  => 'Content',
  'results' => [
    <entity_id> => [
      'title'  => '…', 'url' => '…', 'edit_url' => '…', 'bundle' => '…',
      'fields' => [ '<field_name>' => ['results' => [...highlighted snippets], 'label' => '…'] ],
    ],
  ],
]
```

Pass the whole `$results` array straight into `replace()`. No Drush command exists; this
service is the only programmatic entry point. (The UI wraps these same calls in a Batch API
job — see `ScannerForm::batchSearch()`.)
