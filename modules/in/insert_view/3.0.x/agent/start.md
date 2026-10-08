<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Insert View — agent index

One text-format filter plugin (`insert_view`) that expands `[view:…]` tags into rendered views.
No settings form (`configure: null`), no permissions, no services, no Drush, no config schema.

- **Enable the filter on a text format, filter weight, security notes** →
  [configure/enable-filter.md](configure/enable-filter.md)
- **Exact tag syntax, argument/limit rules, and the render/cache mechanics** →
  [api/tag-syntax.md](api/tag-syntax.md)

Key facts:
- Plugin id `insert_view`, class `Drupal\insert_view\Plugin\Filter\InsertView`,
  type `TYPE_TRANSFORM_IRREVERSIBLE`.
- Tag: `[view:name=display=args=limit:number]`; display defaults to `default`;
  args are slash-separated; `limit:0` = all results.
- Enabled per text format: `filter.format.<id>` → `filters.insert_view.status: true`.
- Output is a lazy-builder placeholder calling `InsertView::build()` (a trusted callback);
  result carries cache tag `insert_view` and cache contexts `url`, `user.permissions`.
- Requires `views`. Depends on `$view->access($display_id)` for security — see the warning in
  [configure/enable-filter.md](configure/enable-filter.md).
