<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drulma Companion Menu Item Fields (drulma_menu_item_fields) — agent index

Submodule of **drulma_companion**. Bridges the contrib **Menu Item Fields** module with the
Drulma theme's **Bulma navbar** so field-bearing menu links get the right Bulma classes. Package
**Bulma**. Version **2.2.0** (dir `2.2.x`). Core `^11.1`. License GPL-2.0-or-later.

- **Depends on:** `menu_item_fields` (info.yml `menu_item_fields:menu_item_fields`).
- No config, no schema, no permissions, no routes, no blocks.
- Provides one `.module` preprocess hook, one CSS library, and one trusted `#pre_render` callback.

## What it does (from source)

- `drulma_menu_item_fields.module` implements `hook_preprocess_menu__bulma_navbar()`: it calls
  `menu_item_fields_preprocess_menu__field_content($variables)` (the parent module's preprocessor),
  then for each `variables['items']` with a `content` element it appends the pre-render callback
  `[Callback::class, 'preRenderMenuLinkContent']` and attaches library
  `drulma_menu_item_fields/navbar-adjust`.
- `src/Render/Callback.php` — `Callback` implements `TrustedCallbackInterface` and registers
  `preRenderMenuLinkContent` in `trustedCallbacks()`. The callback adds `navbar-item` and
  `navbar-drulma-adjust` classes to the link's URL attributes and `navbar-drulma-adjust` to the
  link element attributes. → [api/render-callback.md](api/render-callback.md).
- `drulma_menu_item_fields.libraries.yml` defines library **`navbar-adjust`** →
  `css/navbar-adjust.css` (theme CSS).
