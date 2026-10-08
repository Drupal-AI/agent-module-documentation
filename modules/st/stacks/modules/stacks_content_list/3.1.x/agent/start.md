<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stacks - Content List — agent index

Submodule of **Stacks** (read `../../../../3.1.x/agent/start.md` first). Adds a manual,
ordered list widget: rows are `widget_extend` sub-items (mixed bundles) edited inline.
Contrast Content Feed (dynamic query). Depends on `stacks` + `stacks_content_feed`.

- **The `contentlist` bundle, extend bundles, fields, template** →
  [configure/content-list.md](configure/content-list.md)

Key facts:
- `.module` is empty; this submodule is **config-only** (installed config + a theme template).
- Widget bundle `contentlist` (`stacks.widget_entity_type.contentlist`, `plugin:
  default_widget`); key field `field_clist_content` = entity reference to `widget_extend`,
  edited via Inline Entity Form.
- Ships two `widget_extend_type` bundles: `link` (`field_extend_link_url`) and
  `media_or_file` (`field_extend_description`, `field_extend_file_upload`).
- No permissions, no config schema, no Drush, no plugin types, no routes.
- Template (theme): `stacks/contentlist/templates/contentlist--default.html.twig`.
