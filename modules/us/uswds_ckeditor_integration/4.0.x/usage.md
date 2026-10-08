USWDS Ckeditor Integration brings U.S. Web Design System components — a responsive column grid, accordions, alerts, process lists, summary boxes, and USWDS table styling — into CKEditor 5 as toolbar buttons, embedded-content plugins, and text-format filters.

---

The module registers several CKEditor 5 plugins (`uswds_ckeditor_integration.ckeditor5.yml` → classes in `src/Plugin/CKEditor5Plugin/`): a **USWDS Grid** builder (multi-step modal dialog for choosing columns, per-breakpoint layouts, and advanced classes), a **USWDS Accordion** widget, USWDS **table toolbar items** (mark a table sortable/stacked), and default-overrides for links/lists/tables. It also provides four **EmbeddedContent** plugins (`src/Plugin/EmbeddedContent/`) — Accordion, Alerts, Process List, and Summary Box — surfaced through the `embedded_content` module's CKEditor button, each with a configuration form and a Twig template under `templates/embedded-content/`. Two **filter** plugins (`filter_uswds_table_sortable`, `filter_table_attributes`) post-process saved markup with `DOMDocument`/XPath to add the ARIA/scope/`data-*` attributes and wrapper markup that USWDS sortable and stacked responsive tables require (they only add attributes; they log accessibility warnings when a sortable table lacks a caption or a stacked table lacks headers). A grid settings form (`admin/config/content/ckeditor_uswds_ck_grid`, permission `administer uswds_ckeditor_integration_grid`) defines the available breakpoints, column counts, and layout presets; the shipped `config/install` seeds a large default breakpoint/layout matrix (card, mobile, tablet, desktop, and their large variants). You enable the plugins and filters per text format, and choose which columns/breakpoints are offered per format in the CKEditor plugin settings. Requires Drupal 11.3+ with `ckeditor5`, `media_library`, and `embedded_content`. Component output is rendered through Twig templates (which auto-escape), and USWDS front-end JS is attached for the accordion behavior. A submodule, `uswds_ckeditor_integration_embed`, ships a ready-made `uswds_paragraphs` text format wiring these together with paragraph embeds.

---

- Add a responsive USWDS grid (rows/columns) to rich-text content via a modal grid builder.
- Choose per-breakpoint column layouts (mobile, tablet, desktop, card, and large variants) for a grid.
- Restrict which column counts and breakpoints editors can pick, per text format.
- Add advanced utility classes to grid containers, rows, and individual columns.
- Insert a USWDS accordion (multiple heading/body panels) directly in CKEditor 5.
- Configure an accordion as bordered, multiselectable, or start-collapsed.
- Embed a USWDS alert (informative, warning, error, success) with a heading and body.
- Render a slim or no-icon alert variant.
- Insert a USWDS process list of numbered steps with rich-text bodies.
- Embed a USWDS summary box (key-information callout) with heading and body.
- Turn an editor table into a USWDS **sortable** table (adds scope/role/`data-sortable`/`data-sort-value` + a live region).
- Turn an editor table into a USWDS **stacked** responsive table (adds `data-label`/scope per cell).
- Get accessibility warnings logged when a sortable table has no caption or a stacked table has no header row.
- Provide U.S. government sites a compliant USWDS authoring experience inside core CKEditor 5.
- Override CKEditor 5 default link/list/table behavior to emit USWDS-friendly markup.
- Define custom breakpoint labels and layout presets in the grid settings form.
- Reorder layout presets by weight and set a default layout per column count.
- Attach USWDS accordion front-end JS automatically on all pages.
- Ship a preconfigured `uswds_paragraphs` text format via the embed submodule.
- Combine USWDS components with media/entity embeds in one editor toolbar.
- Author heading + rich body content for each accordion or process-list item using Full HTML.
- Keep component markup consistent across authors by rendering through fixed Twig templates.
- Style tables responsively for mobile without hand-writing USWDS classes/attributes.
- Build multi-column callout layouts (cards, feature rows) without leaving the WYSIWYG editor.
