Renders a multi-value entity reference field as an accessible tabbed interface or a details/summary accordion, with per-tab title and body mapping.

---

Entity Reference Tab Formatter ships one field formatter (`entity_reference_tab_formatter`) that applies to `entity_reference` and `entity_reference_revisions` fields. Instead of listing referenced entities one below another, it turns each referenced item into a tab (ARIA tablist, arrow-key navigation) or an accordion panel (native HTML5 `<details>`). Under Manage display you choose which field on the referenced bundle supplies the tab/header title (falling back to the entity label) and what fills each panel body: a single field on the referenced entity, the whole referenced entity rendered in a selected view mode, or a Views block display with optional contextual filter arguments. Accordion styling is tunable (single vs multiple panels open, header background color, full-width headers, icon on the left or right). The behaviors use Drupal core `once()` with no jQuery UI, and the first panel stays visible before JavaScript loads. It pairs especially well with Paragraphs but works with any referenced entity type.

---

- Display a Paragraphs reference field as a tabbed interface where each paragraph is one tab.
- Turn a multi-value node reference field into an accordion of expandable panels.
- Present FAQ paragraphs (question in the header, answer in the body) as an accordion.
- Build product spec sheets where each referenced spec entity becomes a tab.
- Show related content items as tabs without writing custom theme code.
- Map the tab header to a custom title field (e.g. `field_heading`) rather than the entity label.
- Let the tab header fall back automatically to the referenced entity's label when no title field is set.
- Render each panel body from a single field on the referenced entity (e.g. `field_body`).
- Render each panel as the full referenced entity in a chosen view mode (e.g. Teaser or a custom display).
- Embed a Views block display inside every tab body, optionally passing comma-separated contextual filter arguments.
- Switch a display between Tabs and Accordion styles without changing any stored data.
- Configure an accordion to keep only one panel open at a time, or allow multiple open simultaneously.
- Set the accordion header background color to match a theme via the settings form.
- Display accordion items at full width for full-bleed layouts.
- Move the accordion open/close indicator icon to the left or right side of the header.
- Provide keyboard-accessible tabbed content (arrow keys, Home/End) for WCAG-oriented sites.
- Keep the first tab/panel visible for no-JavaScript and progressive-enhancement scenarios.
- Organize long reference lists into compact tabs so the page stays short.
- Group alternative content (variations, translations of an idea, options) behind tabs.
- Show a fallback message per panel when a mapped body field is empty instead of a blank area.
- Combine with Paragraph types that each define their own view-mode layout via the Rendered entity option.
- Replace bespoke tab/accordion theming with a configurable, schema-backed formatter.
- Reuse an existing Views block (e.g. a filtered listing) as the body of each referenced-entity tab.
