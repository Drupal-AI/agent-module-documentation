<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views exposed filter blocks — agent index

Renders a view display's **exposed filter form as a standalone block** you can place in any
region, decoupled from the view results. One Block plugin, no settings form
(`configure: null`), no permissions, no Drush, no plugin types. All persistent state is
per-block config in each `block.block.<id>` config entity.

- **Place & configure a filter block; the two settings (`view_display`, `form_state_always_process`); where it is stored** →
  [configure/place-block.md](configure/place-block.md)
- **The `views_exposed_filter_blocks_block` Block plugin — how it builds the exposed form, caching, when to use it vs `views_block_filter_block`** →
  [plugins/exposed-filter-block.md](plugins/exposed-filter-block.md)

Key facts:
- Block plugin id: `views_exposed_filter_blocks_block` (category "Views Exposed Filter Blocks").
- Settings: `view_display` = `"<view_id>:<display_id>"` (e.g. `content:page_1`); `form_state_always_process` = bool, default `true`.
- Read a placed block: `drush cget block.block.<id>` → `settings.view_display`, `settings.form_state_always_process`.
- Block is never cached (`getCacheMaxAge() == 0`). Disable AJAX on the target view; keep block + results on the same page.
