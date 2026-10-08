# Service: `layoutbuilder_search_api.manager`

`Drupal\layoutbuilder_search_api\LayoutbuilderSearchApiManager` (registered in
`layoutbuilder_search_api.services.yml`, no constructor args).

One method:

```php
public function getContentBlocks(array $sections): array
```

- Input: an array of Layout Builder `Section` objects (as returned by `getEntitySections()`).
- Iterates every section's components and returns the components whose plugin is a
  `DerivativeInspectionInterface` with base id **`block_content`** — i.e. **placed reusable block
  content** (as opposed to inline blocks, whose base id is `inline_block`).
- The processor merges this with core's inline-block components so both kinds of blocks are indexed.

You would only call this service directly if writing your own indexing/processing logic over Layout
Builder placed blocks; for normal use the `layout_builder_references` processor already uses it.

The module defines no plugin types, hooks, permissions, Drush commands, or config schema — this
service plus the one processor plugin are its entire code surface.
