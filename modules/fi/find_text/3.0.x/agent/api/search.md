# TextSearchService (`find_text.search`)

Programmatic entry point for the search. Constructor args: `@database`, `@entity_field.manager`,
`@entity_type.manager`, `@config.factory`, `@module_handler`.

## `searchFields(string $needle, bool $regexed = FALSE, bool $render = FALSE, ?string $langcode = NULL): array`
Runs the full search and returns results grouped as `$results[<type>][<id>][<langcode>] = [rows…]`
(paragraphs/blocks are folded under their host `node`). Invokes `hook_find_text_results(&$results)`
before returning.

```php
$svc = \Drupal::service('find_text.search');
$results = $svc->searchFields('old-brand', regexed: FALSE, render: FALSE, langcode: 'en');
```

## How it works
- `getTextFieldTables()` — for each `allowed` field type in `find_text.settings`, uses
  `EntityFieldManager::getFieldMapByFieldType()` to find fields, honors `allow_all_entities` /
  `entity_types`, then maps each field to its storage table + value columns
  (`processContentEntityFields()` for node/paragraph/block_content via the table mapping; hard-coded
  tables for `menu_link_content` and `taxonomy_term`). `rh_*` fields are skipped.
- `searchTable()` — for each value column builds a `select`:
  - plain: `->condition($col, '%'.$db->escapeLike($needle).'%', 'LIKE')` (so `_`/`%` in the needle are
    wildcards),
  - regexp: `->condition($col, $needle, 'REGEXP')`,
  - optional `langcode` condition.
- `formatResultValue()` — highlights the match. In non-render mode the surrounding text is passed through
  `FormattableMarkup` placeholders (escaped) with only the match wrapped in `<span class="find-text-match">`;
  in **render** mode the field HTML is emitted and the match wrapped in place (readable but renders content HTML).
- `fetchParent()` resolves paragraph parents (via `getParentEntity()` / `entity_usage`) and Layout Builder
  block hosts (`node__layout_builder__layout`).

Note: this tool is gated behind `access find text` (`restrict access: true`) — a trusted content-manager
capability, not a public search.
