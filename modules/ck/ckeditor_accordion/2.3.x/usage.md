CKEditor Accordion adds a button to Drupal's CKEditor 5 that inserts collapsible accordion markup (`<dl class="ckeditor-accordion">` with `<dt>` title / `<dd>` content rows) into body content, and a frontend behavior that renders it as an interactive accordion.

---

The module registers a CKEditor 5 plugin (`accordion.Accordion`) whose toolbar button "Accordion" is enabled per text format by dragging it onto that format's CKEditor 5 toolbar at **Admin → Configuration → Content authoring → Text formats and editors**. When inserting or editing an accordion the editor shows a balloon content toolbar with "add row above", "add row below" and "remove row" items, and the model is serialized to a description list: `<dl class="ckeditor-accordion">` containing paired `<dt>` (title) and `<dd>` (content) elements, so the text format's allowed HTML must permit `<dl class>`, `<dt>` and `<dd>`. On the front end the module attaches its `accordion.frontend` library globally via `hook_page_attachments_alter()`, which finds every `.ckeditor-accordion`, rewrites titles into clickable togglers, opens the first row by default and wires click/hash handling. Global display behavior lives in a settings form at `/admin/config/content/ckeditor-accordion` (route `ckeditor_accordion.settings`, gated by the `administer ckeditor accordion` permission) and is passed to JavaScript via `drupalSettings.ckeditorAccordion`: `collapse_all`, `keep_rows_open`, `animate_accordion_toggle`, `open_tabs_with_hash` and `allow_html_in_titles`. Styling is minimal and easily overridden by themers through `css/accordion.frontend.css`; a `ckeditorAccordionAttached` DOM event fires on each accordion once initialized. A `CKEditor4To5Upgrade` plugin maps the legacy CKEditor 4 "Accordion" button to the CKEditor 5 item so old formats upgrade cleanly. The module has no config schema and no default config; keys are written only when the settings form is saved.

---

- Add a collapsible FAQ section inside a node's body field.
- Enable the Accordion button on the Basic HTML text format's CKEditor 5 toolbar.
- Insert multi-row accordions where each row has a title and rich content.
- Add a new accordion row above or below the current one from the balloon toolbar.
- Remove an accordion row from the balloon content toolbar.
- Collapse all rows by default so no row is open on page load.
- Keep already-open rows open when a visitor opens another row (multi-open accordion).
- Disable open/close animation for instant toggling.
- Deep-link to a specific row using a hash anchor derived from its title.
- Allow HTML (icons, markup) inside accordion row titles.
- Ensure a text format's allowed tags include `<dl class>`, `<dt>`, `<dd>` for accordions.
- Restrict who can change accordion display settings via the `administer ckeditor accordion` permission.
- Override the minimal blue styling with theme CSS on `.ckeditor-accordion-container`.
- Hook into the `ckeditorAccordionAttached` event to run custom JS after render.
- Build product spec sections as expand/collapse blocks.
- Present terms-and-conditions or legal text in collapsible rows.
- Organize documentation pages into scannable accordion sections.
- Migrate CKEditor 4 accordions to CKEditor 5 automatically via the upgrade plugin.
- Create "read more" style progressive disclosure inside articles.
- Make a support/help page where each question expands to its answer.
- Style the first row as open by default to preview the accordion's content.
- Serve accordions on any page since the frontend library is attached globally.
- Configure display globally at `/admin/config/content/ckeditor-accordion`.
- Link visitors straight to an open row with `href="#RowTitle"` anchors.
