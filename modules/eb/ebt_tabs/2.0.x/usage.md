<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Block Types (EBT): Tabs adds a reusable "EBT Tabs" block content type whose tabs can each contain formatted text, a page (node reference), a placed block, or a View — rendered with the jQuery UI Tabs plugin and a set of visual styles.

---

Part of the EBT family (built on `ebt_core`), this module installs a `block_content` bundle
`ebt_tabs` and a Paragraph type `ebt_tab`. The block holds a multi-value paragraph field
(`field_ebt_tabs`) of `ebt_tab` paragraphs plus an EBT settings field (`field_ebt_settings`) using this
module's `ebt_settings_tabs` widget (extends `ebt_core`'s settings widget). Each `ebt_tab` paragraph has
a `field_ebt_tab_content` selector (text / page / block / views) and matching value fields:
`field_ebt_tab_text` (formatted text), `field_ebt_tab_page` (node reference), `field_ebt_tab_block`
(a `block_field` plugin), `field_ebt_tab_views` (a `viewsreference` field), plus `field_ebt_tab_title`.
Form-alter hooks (in `src/Hook/EbtTabsHooks.php` via the new `#[Hook]` attribute, with legacy `.module`
shims) show/hide the relevant value field based on the chosen content type and add a validation callback
that requires the selected content's value. The settings widget offers tab style presets
(`default`, `without_header_background`, `minimalist_tabs`, `tabs_like_buttons`, `vertical_tabs`,
`vertical_tabs_rotated`) and passes options to the jQuery UI Tabs JavaScript. Blocks are placed via
Layout Builder or the block UI like any EBT block. It has no admin settings page and no permissions of
its own (it relies on core block/paragraph permissions). Requires the Page content type and Media Image
type (from EBT Core) to be present at install.

---

- Add a tabbed-content block to a page via Layout Builder or block placement.
- Create tabs whose content is formatted (rich-text) body copy.
- Create a tab that embeds an existing node/page by reference.
- Create a tab that renders a placed block (via block_field).
- Create a tab that embeds a View (via viewsreference).
- Mix text, page, block and view tabs within one Tabs block.
- Choose a tab visual style (minimalist, buttons, vertical, rotated vertical, no header background).
- Build FAQ-style or product-detail tabbed sections without custom code.
- Reuse the same Tabs block across multiple pages as reusable content.
- Give each tab a custom title.
- Use jQuery UI Tabs behavior for accessible tab switching.
- Compose marketing landing pages with tabbed feature breakdowns.
- Organize long content into vertical tabs to save vertical space.
- Present multiple Views (e.g. filtered listings) side by side under tabs.
- Add tabbed navigation inside a block region rather than a full page.
- Standardize tab styling site-wide via the EBT settings presets.
- Combine with other EBT block types (accordion, carousel, columns) for a block-based page builder.
- Require tab content on save so empty tabs can't be published (built-in validation).
- Show/hide the correct tab value field automatically based on the selected content type.
- Pass jQuery UI Tabs options from the block settings to the front-end.
