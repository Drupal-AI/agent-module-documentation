<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service: custom_entity_pager.main_service

Class `Drupal\custom_entity_pager\Services\CustomEntityPager`
(file `src/Services/CustomEntityPager.php`). Constructed with `@database`
(`\Drupal\Core\Database\Connection`) and `@language_manager`
(`\Drupal\Core\Language\LanguageManagerInterface`). Reusable directly, not only via Twig.

## Public methods

### `getPaginator($content_type, $current_nid, $field_order = '')`
Convenience wrapper: calls `getElements()` then `getNextAndPrev()`. Returns
`['prev' => <node row|NULL>, 'next' => <node row|NULL>]`.

### `getElements($content_type, $field_order)`
Builds and runs one query on `node_field_data` (alias `nfd`):
- Selects fields `nid`, `title`, `status`.
- If `$field_order` is non-empty, sets `$table_name = 'node__' . $field_order` and
  `$value_field = $field_order . '_value'`, then `JOIN`s that table on `entity_id = nfd.nid`.
- Conditions: `nfd.type = $content_type`, `nfd.langcode = <current language id>`
  (from `languageManager->getCurrentLanguage()->getId()`), and `nfd.status = TRUE` — so only
  **published** nodes in the current language are listed.
- Order: `<table>.<field>_value ASC` when a field is given, else `nfd.nid ASC`.
- Returns `$result->fetchAllAssoc('nid')` — an associative array of row objects keyed by nid.

### `getNextAndPrev($result_assoc, $current_nid)`
- Takes the ordered keys, `array_search()`es `$current_nid`.
- If found: `prev` = the row at position−1 (NULL if at the start), `next` = the row at position+1
  (NULL if at the end).
- If the current nid is **not** in the list (e.g. the pager is rendered on an unrelated node, or the
  node is unpublished): `prev` = NULL, `next` = the first row. This is the `#3469019` behaviour.
- Returns `['prev' => ..., 'next' => ...]`.

## Notes
- Ordering is ascending only; "previous" means lower in the sort, "next" means higher.
- `$field_order` must map to a real `node__<field>` field table with a `<field>_value` column;
  base-table properties will not resolve.
- The whole content type's published node set is loaded per render to compute neighbours (the
  module trades memory for avoiding Views); heaviest on very large content types.
