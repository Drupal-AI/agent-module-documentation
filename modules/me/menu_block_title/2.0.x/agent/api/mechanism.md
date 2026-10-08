# How it works (mechanism)

No service you call — the module is three hooks plus one trusted pre-render callback. Everything is
triggered by the per-block third-party setting `menu_block_title.modify_title`.

## The pieces

1. `menu_block_title_form_block_form_alter()` (procedural, in `.module`) — adds the
   **"Block title as menu link parent"** checkbox under `third_party_settings[menu_block_title]
   [modify_title]`, but only when the block form has `settings[menu_levels]` (menu blocks). Block
   core saves it into the block entity's third-party settings automatically (`#tree` = TRUE).

2. `hook_block_view_alter()` → `MenuBlockTitleHooks::blockViewAlter()` (OOP `#[Hook('block_view_alter')]`,
   also bridged by a `#[LegacyHook]` wrapper in `.module`). It calls
   `_menu_block_title_needs_modifying($build, $block)` which loads `Block::load($build['#id'])` and
   returns the `modify_title` third-party setting. When TRUE it:
   - appends `MenuBlockTitle::preRender` to `$build['#pre_render']`, and
   - adds cache context `route.menu_active_trails:<menu>` (from `$block->getDerivativeId()`), so the
     altered title varies correctly per active trail.

3. `MenuBlockTitle::preRender()` (a `TrustedCallbackInterface` callback): reads
   `$build['#derivative_plugin_id']` as the menu name, loads that menu's tree for the **current
   route** (`getCurrentRouteMenuTreeParameters` + `load` + `build`), walks `#items`, and for the item
   with `in_active_trail` sets `$build['#configuration']['label']` to a render array
   `['#type' => 'link', '#url' => $item['url'], '#title' => $item['title']]`.

## Consequences an agent should know

- The title is replaced with a **link render array**, not plain text — themes must print it as markup.
- It relies on the block being a **menu block** (a `#derivative_plugin_id` = menu name) and on the
  block title being displayed; a hidden title yields nothing visible.
- The active-trail item chosen is the one in the current route's trail; on a page with no active
  trail in that menu the label is left unchanged.
- Cache correctness is handled via the added `route.menu_active_trails:<menu>` context — no manual
  cache tag work needed.
