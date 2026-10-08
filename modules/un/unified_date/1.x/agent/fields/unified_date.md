<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `unified_date` base field, presave sync, token & alter hook

## The base field

Declared in `EntityHook::entityBaseFieldInfo()` (`src/Hook/EntityHook.php`) for the **node** entity
only:

- id `unified_date`, type **`timestamp`**, label "Unified date".
- `setRevisionable(TRUE)`, `setTranslatable(TRUE)`, settings `['max_length' => 11]`.

Because it is a base field, it lives on `node_field_data` (no separate field table) and is available
to Views, tokens, entity queries, and `$node->get('unified_date')->value`.

## Presave sync

`EntityHook::nodePresave()` (`hook_node_presave`) runs on every node save and sets
`unified_date` = `UnifiedDateManager::getUnifiedDate($node)`. It only `set()`s the value; the node is
saved by its normal lifecycle. `UnifiedDateManager::setNodeUnifiedDate()` (used by batch/Drush)
additionally calls `$node->save()` itself.

## Source resolution — `UnifiedDateManager::getUnifiedDate()`

`src/UnifiedDateManager.php`:

1. `$field = 'base-field:created'` unless `node_types.<bundle>` is configured.
2. Strip the `base-field:` prefix.
3. If the key contains `:`, split into `$field` and `$value_location` (e.g. `field_x:end_value`);
   else `$value_location = 'value'`.
4. If `$node->hasField($field)`, read `$node->get($field)->{$value_location}`. If it is a
   non-numeric, non-null string (ISO datetime), convert with `strtotime()`.
5. If still empty, fall back to `$node->getCreatedTime()`.
6. Invoke `hook_unified_date_alter($date, $node)` and return the (int) timestamp.

In tests it reloads config each call (guarded by `drupal_valid_test_ua()`).

## Alter hook

Other modules can adjust the computed value:

```php
/**
 * Implements hook_unified_date_alter().
 *
 * @param int|null $date        Unix timestamp being written (by reference).
 * @param \Drupal\node\NodeInterface $node
 */
function mymodule_unified_date_alter(&$date, $node) {
  // e.g. floor to midnight, or override for a bundle.
}
```

## Token

`unified_date.tokens.inc`:

- `hook_token_info_alter()` registers `[node:unified_date]` (type `date`).
- `hook_tokens()`: `[node:unified_date]` → `date.formatter->format($value, 'medium', …)`; sub-tokens
  under the `unified_date` prefix are delegated to the core `date` token generator (so
  `[node:unified_date:custom:Y-m-d]`, `:short`, `:long`, etc. work). Cache metadata for the `medium`
  date format is bubbled.

## Field-type support (from `getNodeDateFields()`)

Selectable sources per bundle: core `datetime` and `timestamp` fields; `daterange`,
`daterange_timezone`, `smartdate` (both start `value` and `end_value`); and base fields `created`,
`changed`, `published_at`. To support another field type, its value must be reachable as `->value`
(or a `:<location>`) and numeric-or-strtotime-parseable.
