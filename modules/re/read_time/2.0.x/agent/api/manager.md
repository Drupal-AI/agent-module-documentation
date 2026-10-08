<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Storage service, calculation & cache table

The computed read time is cached in a dedicated DB table and refreshed on node save. The
`read_time.manager` service handles writes/deletes; a procedural helper does the arithmetic.

## Service `read_time.manager` — `Drupal\read_time\ReadTimeManager`

Constructor args (from `read_time.services.yml`): `@entity_type.manager`, `@database`,
`@config.factory` (only the database connection is actually used).

| Method | Signature | Behavior |
|---|---|---|
| `updateReadTime` | `updateReadTime(NodeInterface $node, $read_time = NULL): bool` | Returns `FALSE` if the node has no id; otherwise `MERGE`s `$read_time` into the `read_time` table keyed by `nid` and returns `TRUE`. |
| `deleteReadTime` | `deleteReadTime($nid): int` | `DELETE`s the row for `$nid` (returns affected rows). |

```php
$manager = \Drupal::service('read_time.manager');
$minutes = read_time_calculate($node);      // float minutes
$manager->updateReadTime($node, $minutes);  // cache it
```

## Calculation helper — `read_time_calculate($entity)` (in `read_time.module`)

Returns estimated **minutes** as a float: `str_word_count($text) / read_time_wpm`. It reads the
bundle's `read_time_fields` and `read_time_wpm` third-party settings, then concatenates text from
each configured field:

- Plain text fields: `strip_tags($entity->{$field}->getString())`.
- `paragraph` reference fields (`entity_reference_revisions`): for each referenced paragraph it
  walks the paragraph's default form-display components and concatenates the string value of
  subfields of type `text`, `text_long`, `text_with_summary`, `string_long` (after `strip_tags`).

`read_time_defaults()` supplies the fallbacks used when a bundle has no saved settings:
`enable => FALSE`, `fields => ['body']`, `wpm => '225'`, `format => 'hour_short'`,
`display => 'Read time: :read_time'`.

## When the cache is written/cleared (hooks in `read_time.module`)

| Hook | Action |
|---|---|
| `hook_node_insert` / `hook_node_update` | `read_time_calculate()` then `ReadTimeManager::updateReadTime()`. |
| `hook_ENTITY_TYPE_predelete` (`read_time_node_predelete`) | `ReadTimeManager::deleteReadTime($node->id())`. |
| `hook_ENTITY_TYPE_view` (`read_time_node_view`) | Reads the cached value; if the row is empty, computes it, `MERGE`s it into the table, then formats and outputs the `read_time` pseudo-field. |

Because the value is cached, config changes (words-per-minute, chosen fields) take effect for an
existing node only after it is re-saved or its cached row is removed.

## Table schema — `read_time` (`hook_schema` in `read_time.install`)

| Column | Type | Notes |
|---|---|---|
| `nid` | int, unsigned, not null | `{node}.nid`; primary key. |
| `read_time` | varchar(255), not null, default `''` | The stored (computed) read time. |

`hook_uninstall` additionally unsets the five `read_time` third-party settings from every node type;
the table itself is dropped by core on uninstall.
