# Configurable Views Filter Block — agent index

Provides one Block plugin, **"Views Exposed Filter Block (configurable form)"**
(`configurable_views_filter_block_block`), that extends core's `ViewsExposedFilterBlock` and lets
you pick, per block instance, which exposed filters / reset / sort / pager / groups are shown. No
settings route, permissions, services, or Drush — all state lives in each block's config entity
`settings`.

- **The block plugin: its id/deriver, the per-instance settings keys, and how to configure an instance** →
  [configure/block.md](configure/block.md)

Key facts:
- Requires a view **display with "Exposed form in block" enabled**; the derivative id is then
  `configurable_views_filter_block_block:<view_id>-<display_id>`.
- Block settings keys: `visible_filters` (list of exposed-filter identifiers to keep), and booleans
  `no_groups`, `no_reset`, `no_sort`, `no_pager`.
- Hidden fields are visually hidden (wrapped in `<div class="hidden-exposed-filter">`), not
  removed, so their values are preserved; each instance gets a fresh unique form `#id`.
