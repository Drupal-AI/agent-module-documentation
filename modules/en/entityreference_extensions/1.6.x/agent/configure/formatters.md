# The three "PLUS" formatters and their settings

Choose one on an entity's **Manage display** tab for a multi-value entity-reference field (cardinality
must not be 1). Settings persist in `core.entity_view_display.<entity>.<bundle>.<mode>` under
`content.<field>.settings`.

| Formatter id | Extends (core) | Output | Extra "display" option |
|---|---|---|---|
| `entity_reference_entity_view_delta` | `entity_reference_entity_view` | rendered entities | yes |
| `entity_reference_entity_id_delta` | `entity_reference_entity_id` | entity IDs | no |
| `entity_reference_label_delta` | `entity_reference_entity_label` | labels (optionally linked) | no |

## Settings (schema in `config/schema/entityreference_extensions.schema.yml`)

`limit` (`entityreference_extensions_limit`):
- `number` (string) — how many items to show; empty = "All".
- `offset` (int) — items to skip; empty = 0.
- `reverse` (bool) — limit from the end of the list instead of the start (order unaffected).
- `limit_before_sort` (bool) — TRUE: slice first, then sort; FALSE: sort first, then slice.

`sort` (`entityreference_extensions_sort`):
- `field` (string) — a field/property machine name on the referenced entities; empty = sort by delta.
- `asc` (bool) — TRUE ascending, FALSE descending.
- Ties always break by delta (lower delta first). Entities missing the sort field sort to the end,
  regardless of direction.

`display` (`entityreference_extensions_display`, rendered formatter only):
- `enable` (bool) — render the first N in a different view mode (applied AFTER sorting + limiting).
- `number` (int) — how many leading items to switch.
- `view_mode` (string) — the alternate view mode.

## Behaviour reference (`EntityReferenceDeltaFilterTrait`)

- `getEntitiesToView()` order of operations: optional slice (if `limit_before_sort`) → sort
  (`uasort` with `entitySort`, or `array_reverse` when sorting by delta descending) → optional slice.
- `deltaFilter()` implements offset/number/reverse via `array_slice` (preserving keys).
- `isApplicable()` returns FALSE for cardinality-1 fields, so these formatters won't appear there.
- The limit/offset `#options` run `1 .. getCardinalityCounter()-1`. For unlimited cardinality (-1),
  `getCardinalityCounter()` returns `entityreference_extensions.settings:unlimitedcounter` (default 10).

## Set the unlimited counter (no UI)

```bash
ddev drush config:set entityreference_extensions.settings unlimitedcounter 25 -y
```

## Set a formatter with Drush (example)

```php
// drush php:eval — show first 3 referenced nodes, sorted by field_weight ascending, first one featured.
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_related', [
  'type' => 'entity_reference_entity_view_delta',
  'settings' => [
    'limit' => ['number' => '3', 'offset' => '', 'reverse' => FALSE, 'limit_before_sort' => FALSE],
    'sort'  => ['field' => 'field_weight', 'asc' => TRUE],
    'display' => ['enable' => TRUE, 'number' => 1, 'view_mode' => 'featured'],
    'view_mode' => 'teaser',
  ],
])->save();
```
