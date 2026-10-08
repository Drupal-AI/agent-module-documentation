# TagClouds — agent index

Weighted tag clouds from taxonomy terms: dynamic pages, a per-vocabulary block, and one global
settings form. Depends only on `taxonomy`.

- **Global settings (`tagclouds.settings`), the admin form/route, the block, routes, permission** →
  [configure/settings.md](configure/settings.md)
- **The services (`tagclouds.tag`, `tagclouds.cloud_builder`) to build clouds in code** →
  [api/services.md](api/services.md)
- **Theme hooks, templates, level classes & the CSS library** →
  [theming/clouds.md](theming/clouds.md)

Key facts:
- Config object `tagclouds.settings`; configure route `tagclouds.admin_page`
  (`/admin/config/content/tagclouds`), guarded by permission `administer tagclouds settings`.
- Settings keys: `sort_order` (`title,asc` default), `display_type` (`style`|`count`),
  `display_node_link` (bool), `display_more_link` (bool), `page_amount` (string, `'60'`),
  `levels` (int, 6), `language_separation` (int), `language_separation_radios` (int).
- Block `tagclouds_block` (derived per vocabulary); routes `/tagclouds`,
  `/tagclouds/list/{voc}`, `/tagclouds/chunk/{voc}` (permission `access content`).
- Terms get CSS classes `level1`…`level{levels}` sized by usage.
