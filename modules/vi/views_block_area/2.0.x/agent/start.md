<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Block Area — agent index

Exposes any (non-context-aware) block plugin as a **Views area** handler and a **Views field** handler,
so you can render a block in a view's header/footer/no-results, or as a field. Depends on `views`.
No settings form, no configure route, no permissions, no Drush, no plugin types of its own.

- **The two Views handlers, their options, and how to add them to a view** →
  [plugins/views-handlers.md](plugins/views-handlers.md)
- **The render helper service + block-support limitations** → [api/helper.md](api/helper.md)

Key facts:
- Area handler id `views_block_area` ("Global: Block area"); field handler id `views_block_field`
  ("Content block: Block field"). Registered via `hook_views_data()`.
- Options: `block_id`, `block_title`, `hide_label`, `empty` (show when the view has no results).
- Stored in the view's display config under `views.area.views_block_area` / `views.field.views_block_field`.
- **Context-aware blocks are excluded** from the selectable list; broken / missing block_content render as nothing.
