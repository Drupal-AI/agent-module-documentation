<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Cheeseburger Menu — agent index

A configurable off-canvas "hamburger" menu built from menus and/or taxonomy vocabularies.
Two Block plugins: **`cheeseburger_menu`** (the panel) and **`cheeseburger_menu_trigger`**
(the button). No central admin page and no permissions — everything is block config
(`configure: null`). Depends on core `block`.

- **Place & configure the blocks; every settings key; taxonomy/menu aggregation** →
  [configure/block.md](configure/block.md)
- **The two Block plugins + language-switch menu link + cache context** →
  [plugins/blocks.md](plugins/blocks.md)
- **The three alter hooks (gated by the `invoke_hooks` setting)** →
  [hooks/alter.md](hooks/alter.md)
- **Templates, libraries, default CSS/JS** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Config lives on the `block.block.<id>` config entity under `settings` (schema
  `block.settings.cheeseburger_menu` / `block.settings.cheeseburger_menu_trigger`).
- The panel aggregates a `menus` list; each entry has `menu_type` (`menu` or
  `taxonomy_vocabulary`), `id`, `weight`, and a `settings` map (max_depth, icon, title…).
- The trigger references the panel via `block_to_trigger` and can be limited by
  `breakpoints` / `custom_media_query`.
