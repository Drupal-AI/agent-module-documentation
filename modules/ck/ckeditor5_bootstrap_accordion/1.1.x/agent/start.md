# CKEditor 5 Bootstrap Accordion — agent index

A CKEditor 5 plugin (built from TypeScript) that inserts/edits Bootstrap 5 accordions, plus a
text-format filter that adds the runtime Bootstrap attributes. No config form, no permissions,
no schema, no Drush. Depends on core `ckeditor5`.

- **Enabling on a text format, the required filter, allowed markup, the render-time attribute
  filter, and the Bootstrap/theme requirement** → [configure/setup.md](configure/setup.md)

Key facts:
- Editor plugin declared in `ckeditor5_bootstrap_accordion.ckeditor5.yml`; JS at
  `js/build/bootstrapAccordion.js` (TS source under `ckeditor5_plugins/`).
- Filter `filter_bootstrap_accordion` ("Accordion enabler"),
  `src/Plugin/Filter/BootstrapAccordion.php` — MUST be enabled on the format or accordions
  won't work on the page.
- Front-end needs Bootstrap 5 CSS/JS from the theme; editing does not.
- Extend the toolbar via the `bootstrapAccordion.toolbarItems` CKEditor 5 config key.
