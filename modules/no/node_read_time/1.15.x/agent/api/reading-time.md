<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the ReadingTime service, computed field, Views field

## Service `node_read_time.reading_time` (`Calculate\ReadingTime`)

Fluent calculator. Typical use:

```php
$rt = \Drupal::service("node_read_time.reading_time")
  ->setWordsPerMinute(225)
  ->collectWords($node)        // gather words from the node (and referenced entities)
  ->calculateReadingTime()
  ->getReadingTime();          // string like "3 minutes" (per unit_of_time)
$rt_service->setWords(0);      // reset internal buffer before reuse
```

- `collectWords($entity)` scans field types `text`, `text_long`, `text_with_summary`,
  `string_long`, and `entity_reference_revisions` (recursing into Paragraphs/referenced
  revisions), skipping any field whose name contains `revision`.
- `calculateReadingTime()` strips `<script>`/`<iframe>` and tags, counts words, and formats
  per the `unit_of_time` config key. WPM comes from `setWordsPerMinute()` (the caller passes
  the config value, defaulting to 225 when empty).

## Computed base field `node_read_time`

`hook_entity_base_field_info_alter()` adds a computed string base field `node_read_time` to
**all** node bundles (`Plugin\Field\NodeReadTime`, `ComputedItemListTrait`). It returns the
reading time only for bundles activated in `node_read_time.settings`; otherwise NULL. It is
display-configurable. Read it like any field: `$node->get('node_read_time')->value`.

## Views field

`hook_views_data_alter()` registers `node_field_data.node_read_time` → a Views field titled
**"Node read time"** (`Plugin\views\field\NodeReadTime`) so you can add reading time as a
column to any node view.

## Rendering hook (automatic)

`hook_ENTITY_TYPE_view()` (`node_read_time_node_view`) adds the `reading_time` render element
when the `reading_time` extra field is placed on the active display and the node's type is
activated.
