# Bootstrap Utilities — agent index

Four text-format **filters** that auto-add Bootstrap CSS classes to editor HTML on output. Depends
on core `filter` only. No UI page of its own (`configure: null`), no permissions, services, or
Drush — you configure the filters per text format.

- **The four filters, the classes they add, enabling them, and the Table filter's settings** →
  [configure/filters.md](configure/filters.md)

Key facts (filter plugin ids → class added):
- `bootstrap_utilities_table_filter` → `table` (+ optional `table-striped`/`table-bordered`/
  `table-hover`/`table-sm`; can strip `width`/`height` on `<tbody>` cells). **Only filter with
  settings.**
- `bootstrap_utilities_image_filter` → `img-fluid` on `<img>`.
- `bootstrap_utilities_blockquote_filter` → `blockquote` on `<blockquote>`.
- `bootstrap_utilities_figure_filter` → `figure` on `<figure>`, `figure-caption` on `<figcaption>`.

Filters use xPath (not regex), merge classes (preserving existing ones), and are
`TYPE_TRANSFORM_IRREVERSIBLE`. Configured in `filter.format.<id>` config.
