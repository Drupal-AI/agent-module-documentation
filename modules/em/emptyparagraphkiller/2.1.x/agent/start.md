# Empty Paragraph Killer (emptyparagraphkiller) — agent index

A single text-format **filter plugin** that strips empty `<p>` tags (whitespace / `&nbsp;`
only) from rendered output, non-destructively. No settings form, no config schema, no
permissions, no Drush, no plugin types (`configure` = null). Its only state is whether the
filter is enabled (and its weight) on a text format.

- **Enabling the filter on a text format, ordering, the plugin internals** →
  [configure/filter.md](configure/filter.md)

Key facts (grounded in `src/Plugin/Filter/EmptyParagraphKiller.php`):
- Filter id: **`emptyparagraphkiller`** ("Empty Paragraph filter"), extends `FilterBase`,
  type `TYPE_TRANSFORM_REVERSIBLE`.
- Regex used in `prepare()`: `#<p[^>]*>(\s|&nbsp;?)*</p>#` → `[empty-para]`, then `process()`
  strips the placeholder.
- Enable it at `/admin/config/content/formats`; stored in `filter.format.<id>` under
  `filters.emptyparagraphkiller` (`status`, `weight`). Recommended weight: last.
