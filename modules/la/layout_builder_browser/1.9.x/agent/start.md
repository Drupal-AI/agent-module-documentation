<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Browser — agent index

Replaces Layout Builder's "Choose a block" screen with a **curated** browser: only blocks you
register as `layout_builder_browser_block` config entities are offered, grouped into
`layout_builder_browser_blockcat` categories, optionally with preview images.

Takeover mechanism: `RouteSubscriber` (priority `-110`) repoints the **core** route
`layout_builder.choose_block` at `BrowserController::browse`. That controller falls back to
core's `ChooseBlockController` unless the section storage plugin id is listed in
`layout_builder_browser.settings:enabled_section_storages`.

- **Settings object, keys, defaults, modal + auto-added bundles** →
  [configure/settings.md](configure/settings.md)
- **Create/read categories and browser blocks (the two config entity types)** →
  [configure/block-catalog.md](configure/block-catalog.md)
- **`hook_layout_builder_browser_alter()` — rewrite the browser render array** →
  [hooks/browser-alter.md](hooks/browser-alter.md)

Key facts:

- Configure route: `layout_builder_browser.admin_blocklisting` → `/admin/config/content/layout-builder-browser`
  (tabs: Blocks, Block categories, Settings). Everything is gated by core's
  **`administer site configuration`** — the module ships **no `*.permissions.yml`**.
- Config entity ids are `layout_builder_browser_block` and `layout_builder_browser_blockcat`
  (note: **`blockcat`**, not `blockcategory`); config prefixes
  `layout_builder_browser.layout_builder_browser_block.*` and
  `layout_builder_browser.layout_builder_browser_blockcat.*`.
- Only entities with `status: true` are rendered; a category whose blocks all resolve to
  nothing is removed from the output entirely.
- No plugin types, no services beyond the route subscriber, no Drush commands.
