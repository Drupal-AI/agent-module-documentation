<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Tabs adds a ready-made "Tabs" Paragraph type where each tab can hold rich text, a referenced page, a placed block, or an embedded view — a jQuery UI Tabs component editors configure without code.

---

Part of the Extra Paragraph Types (EPT) family, this module installs two Paragraph types as default config: `ept_tabs` (the wrapper) and `ept_tabs_item` (one tab). The wrapper carries `field_ept_tabs` (an unlimited-cardinality `entity_reference_revisions` field to `ept_tabs_item`), an optional `field_ept_title`, and `field_ept_settings` (the shared `ept_settings` field from `ept_core`) rendered by this module's `ept_settings_tabs` widget (class `EptSettingsTabsWidget`, extending `ept_core`'s `EptSettingsDefaultWidget`). That widget adds tab-specific options — a `styles` preset (default / without header background / minimalist tabs / tabs like buttons / vertical tabs / vertical tabs rotated), `active` (zero-based open panel index), `collapsible`, `closed` (all closed), `disable`, and jQuery UI `heightStyle` (auto/fill/content) — and forces `pass_options_to_javascript = TRUE` so `ept_core` publishes them under `drupalSettings.eptTabs`. Each `ept_tabs_item` has a required `field_ept_tab_title` (a formatted `text` field — the README notes this is deliberate so titles can carry `<i>` icons or Bootstrap visibility classes) and a `field_ept_tab_content` list_string selector whose value (`text` / `page` / `block` / `views`) decides which of four mutually exclusive content fields is used: `field_ept_tab_text` (`text_long`), `field_ept_tab_page` (entity reference to `node`, restricted to the `page` bundle by default), `field_ept_tab_block` (a `block_field`), or `field_ept_tab_views` (a `viewsreference`). Hook implementations in `EptTabsHooks` drive `#states` to show only the selected field in the editor, and a submit validator (`_ept_tabs_form_validation`) enforces that the chosen field is filled. On the front end the tab set is assembled entirely in the browser: `js/jquery_ui_tabs/jquery_ui_tabs.js` reads `drupalSettings.eptTabs`, builds a `<ul>` from each item's `.ept-tab-title`, moves each `.ept-tab-content` into a panel, then calls jQuery UI `.tabs(options)`. Because it requires `block_field` and `viewsreference` — not only `ept_core` and `paragraphs` — it is a genuine page-composition tool rather than a text-only tab set. Two dependencies are worth weighing: `jquery_ui_tabs` is a contrib remnant of the jQuery UI that was removed from Drupal core (maintained best-effort, a direction the project is moving away from); and, as with any tab set, inactive panels are still rendered in the DOM, so an embedded view in a tab nobody opens is still executed on page load. There is no config page, no permissions, no Drush, and no config schema of its own; the Paragraph types and their fields are the deliverable. Requires content type "Page" to exist at install (`hook_requirements`).

---

- Put an embedded view inside a tab (product reviews, a filtered listing, related content).
- Show Description / Specifications / Reviews as tabs on a product page.
- Add a tabbed section to any content type that has a Paragraphs reference field.
- Place a reusable block (contact form, CTA, custom block) inside a tab.
- Build a department page with Overview / Staff listing / Contact tabs.
- Reference an existing "Page" node as the body of a tab.
- Organise long content into tabs to reduce page length.
- Mix content kinds across tabs — text in one, a view in another, a block in a third.
- Choose a visual preset (minimalist, buttons-like, vertical, vertical rotated) per tab set.
- Start with a specific tab open using the zero-based `active` index.
- Make the tab set collapsible, or start with all panels closed.
- Set jQuery UI `heightStyle` to equalise panel heights (`fill`) or fit content.
- Render the tab set as static (disable the jQuery UI interaction).
- Add Font Awesome icons or Bootstrap visibility classes into tab titles via the formatted title field.
- Inherit global EPT colors, container widths and responsive breakpoints from EPT Core.
- Apply per-paragraph Design options (margins, padding, borders, background image/video, edge-to-edge).
- Give non-developers a click-to-configure tab component with no theming.
- Combine with sibling EPT paragraph types (accordion, tiles, columns) to build a landing page.
- Override the tabs Twig templates (`paragraph--ept-tabs*`) for custom markup.
- Translate tab titles and bodies through the standard Paragraph translation flow.
- Present documentation or FAQs as tabbed sections instead of one long page.
- Reuse the same tab component consistently across a site without custom front-end code.
