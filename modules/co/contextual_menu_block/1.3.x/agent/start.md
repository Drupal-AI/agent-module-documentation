<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contextual menu block (contextual_menu_block) — agent index

Provides a single Block plugin that renders only the slice of a chosen menu around the
**active menu item** — the item's children if it has any, otherwise the item's parent and
siblings. No dependencies, no permissions, no services, no submodules. Version **1.3.0**,
core `^9 || ^10 || ^11`.

## The one thing it ships

- **Block plugin `contextual_menu_block`** — class
  `Drupal\contextual_menu_block\Plugin\Block\ContextualMenuBlock` (extends `BlockBase`), admin
  label "Contextual menu", block category **Navigation**. Full mechanism, settings, and the
  exact tree-filtering rule are in [blocks/contextual_menu_block.md](blocks/contextual_menu_block.md).

## Mechanism in one paragraph

`build()` gets the active link for the configured menu from core's `menu.active_trail`, loads the
current-route tree (`getCurrentRouteMenuTreeParameters()` + `onlyEnabledLinks()`), and transforms it
through a custom `filterTree` manipulator plus core's `checkAccess` and `generateIndexAndSort`.
`filterTree` collapses the tree to exactly one level of context: active item **with children** →
root = active item, listing its immediate children (grandchildren stripped); active item **without
children** → root = active item's parent, listing that parent's children (active item + siblings).
The active item is re-rendered as an unlinked `<nolink>` with an `is-active` class.

## Settings (block placement form only)

There is **no** global config route (`configure: null`). Two settings live on the block form:

- `menu_id` — select of every menu entity; which menu to read the active trail from.
- `render_on_top_level_items` ("Enable on top-level pages") — checkbox, default off. When off, the
  block returns empty on pages whose active item has no parent (top level).

Config schema: `block.settings.contextual_menu_block` types both keys (`provides_config_schema: true`).

## Correctness facts an agent must know

1. **Active trail must resolve.** Works for pages that are real menu links; renders nothing on
   pages with no active link (a view, a taxonomy page, a node with no menu entry). Decide what
   those pages show rather than discovering it.
2. **Access is enforced.** The `checkAccess` manipulator filters links the current user cannot
   view; an empty block for a low-privilege role is legitimate, not a bug.
3. **Cached by route.** `build()` adds the `route` cache context + a cacheable dependency on the
   menu entity; per-user contexts from `checkAccess` bubble up via `menuTree->build()`. Correct —
   no cross-page bleed.

## Recommended companion

Pair with the **Menu Breadcrumb** module: this block deliberately omits an "up the hierarchy" link
when the active item has children, and Menu Breadcrumb supplies it.
