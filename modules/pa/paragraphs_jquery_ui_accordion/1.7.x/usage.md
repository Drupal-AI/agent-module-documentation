<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs jQuery UI Accordion adds a field formatter that renders a multi-value Paragraphs reference field as a jQuery UI accordion, using each referenced paragraph's chosen title field as the header and another field as the collapsible body.

---

The module provides a single field formatter, `paragraphs_jquery_ui_accordion_formatter`, applicable to multi-value `entity_reference_revisions` fields that target the `paragraph` entity type (its `isApplicable()` requires a multiple-cardinality paragraph reference field). On an entity's Manage display screen you choose the formatter and configure which paragraph bundle it reads, which of that bundle's fields supplies the accordion header (`title`) and which supplies the body (`content`), plus the view mode used to render the body. Additional options control interaction: `active` (open the first panel by default), `simple_id` (sequential numeric ids instead of transliterated title ids), and an auto-scroll group (`autoscroll`, `autoscroll_offset`, `autoscroll_offset_toolbar`) that scrolls the active item into view with an optional pixel offset (useful when a fixed admin toolbar overlaps). Rendering uses a Twig template (`paragraphs-jquery-ui-accordion-formatter.html.twig`) and attaches the module's `accordion` library, which depends on Drupal core's bundled jQuery UI Accordion (via the `jquery_ui_accordion` contrib module) — so no extra JavaScript libraries need to be downloaded. It has no admin settings page and no permissions of its own; all configuration lives in the field formatter settings of a view display.

---

- Turn a multi-value Paragraphs field into an accordion (collapsible sections) on a node.
- Build an FAQ where each paragraph is a question/answer pair shown as an accordion item.
- Display "features" or "services" paragraphs as expandable panels.
- Render product spec sections as collapsible accordion groups.
- Choose which paragraph field is the accordion header vs the body content.
- Open the first accordion panel by default with the `active` setting.
- Keep all panels closed initially by turning `active` off.
- Render the body via a specific paragraph view mode (e.g. teaser or a custom mode).
- Use sequential numeric ids (`simple_id`) for predictable accordion element ids.
- Auto-scroll the page to the opened accordion item for long pages.
- Add a scroll offset so a fixed admin toolbar doesn't cover the opened item.
- Apply the scroll offset only for users who see the admin toolbar.
- Present terms-and-conditions clauses as an accordion of collapsible sections.
- Show a "how it works" step list as an accordion.
- Group long-form content into digestible collapsible chunks without custom JS.
- Reuse an existing paragraph type (e.g. text) as accordion items just by picking a formatter.
- Provide editors a no-code way to make accordions by adding paragraphs.
- Build a documentation/help page from paragraphs rendered as an accordion.
- Display a list of team-member bios as expandable accordion entries.
- Convert an existing stacked-paragraph layout into an accordion by switching the display formatter.
- Render course-module outlines as collapsible accordion sections.
- Show pricing-tier details as accordion panels.
