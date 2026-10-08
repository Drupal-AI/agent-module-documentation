<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Tabs (ept_tabs) — agent index

Ready-made **Tabs paragraph type** built on **jQuery UI Tabs**. Each tab holds one of: formatted
text, a referenced **page** (node), a placed **block**, or an embedded **view**. Requires `ept_core`,
`paragraphs`, core `views`, plus **`block_field`** and **`viewsreference`** — those last two are what
let a tab be a block or a view, making this a page-composition tool rather than a text-only tab set.
Version **2.0.1**. Core `^10.1 || ^11 || ^12`. No config page (`configure` null), no permissions, no
Drush, no own config schema — the two Paragraph types and their fields (default config) are the deliverable.

- **The two Paragraph types, all fields, the `ept_settings_tabs` widget options, the content-type selector, the front-end JS, and the render/template chain** → [configure/paragraph.md](configure/paragraph.md)

Key facts:
- Paragraph types: `ept_tabs` (wrapper) + `ept_tabs_item` (one tab).
- Wrapper fields: `field_ept_tabs` (unlimited `entity_reference_revisions` → `ept_tabs_item`),
  `field_ept_title`, `field_ept_settings` (the shared `ept_core` `ept_settings` field).
- Item fields: required `field_ept_tab_title` (formatted `text`), `field_ept_tab_content` selector
  (`text`/`page`/`block`/`views`), and four mutually-exclusive content fields
  `field_ept_tab_text` / `field_ept_tab_page` / `field_ept_tab_block` / `field_ept_tab_views`.
- Widget `ept_settings_tabs` (class `EptSettingsTabsWidget`, extends `ept_core`'s
  `EptSettingsDefaultWidget`) adds: `styles` preset, `active`, `collapsible`, `closed`, `disable`,
  `heightStyle`; sets `pass_options_to_javascript = TRUE`.
- `EptTabsHooks` drives editor `#states` (show only the selected content field) and a submit
  validator (`_ept_tabs_form_validation`) requiring the chosen field to be filled; also a
  `theme_registry_alter` registering the item + field templates.
- Front end: `ept_core` publishes options under `drupalSettings.eptTabs`;
  `js/jquery_ui_tabs/jquery_ui_tabs.js` builds the `<ul>`/panels from `.ept-tab-title`/`.ept-tab-content`
  and calls jQuery UI `.tabs()`. Style presets attach libraries (`without_header_background`,
  `minimalist_tabs`, `tabs_like_buttons`, `vertical_tabs`, `vertical_tabs_rotated`).
- Global colors/breakpoints/Design options come from EPT Core (`/admin/config/content/ept` →
  `ept_core.settings`); the `paragraph--ept-tabs--default` template emits per-paragraph CSS via
  ept_core's `GenerateCSS` service.
- `hook_requirements` blocks install unless a "Page" content type exists.
- **Deprecation to weigh:** `jquery_ui_tabs` is a contrib remnant of jQuery UI, removed from core,
  maintained best-effort. **Perf:** inactive tab panels are rendered in the DOM — an embedded view in
  an unopened tab still executes on page load.
