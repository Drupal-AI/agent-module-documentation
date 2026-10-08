Submodule of USWDS Paragraph Components that installs a USWDS **accordion** paragraph type — a collapsible set of titled sections rendered as `usa-accordion` markup.

---

Enabling this submodule imports (as `config/optional`) two main paragraph bundles plus a helper: `uswds_accordion` (the container) and `uswds_accordion_section` (one collapsible panel), and a `text_field` helper bundle. `uswds_accordion` holds `field_accordion_section` (a nested Paragraphs field of accordion sections), plus boolean options `field_bordered` (→ `usa-accordion--bordered`), `field_multiselect` (→ `usa-accordion--multiselectable` + `data-allow-multiple`) and `field_default_open` (a list selecting which section indexes start expanded). Each `uswds_accordion_section` has `field_accordion_section_title` and `field_accordion_section_body`. The template `paragraph--uswds-accordion.html.twig` loops the sections, emits `usa-accordion__heading`/`usa-accordion__button` with `aria-expanded`/`aria-controls`, and handles per-section translations. No CSS library is shipped — the accordion relies on the theme's USWDS CSS/JS. Expose only `uswds_accordion` on your Paragraphs field; `uswds_accordion_section` is a child bundle.

---

- Add an expandable/collapsible accordion of Q&A or documentation sections to a page.
- Build an FAQ where each question is an accordion section title and the answer is the body.
- Allow multiple panels open at once with the multiselect option.
- Render the accordion with USWDS borders via the bordered option.
- Pre-open specific sections on load using the default-open selection.
- Group long-form content into scannable collapsible chunks.
- Provide accessible disclosure widgets with correct `aria-expanded`/`aria-controls` wiring.
- Translate accordion section bodies (template resolves the section body translation per langcode).
- Nest rich text, media or other content inside each accordion section body.
- Reuse the accordion inside a page built from a single Paragraphs field.
- Override `paragraph--uswds-accordion.html.twig` in your theme to customize heading levels or markup.
- Provide a consistent USWDS accordion across a federal site without hand-building the bundle.
- Combine an accordion with alerts, cards or summary boxes on the same page.
- Add or reorder sections by editing the nested accordion-section paragraphs.
- Present terms, policies or help content as progressively disclosed panels.
- Keep a single-select accordion (only one panel open) by leaving multiselect off.
