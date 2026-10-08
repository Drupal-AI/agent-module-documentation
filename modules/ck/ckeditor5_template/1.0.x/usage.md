CKEditor 5 Template adds a "Template" toolbar button to CKEditor 5 that lets content authors insert predefined blocks of ready-made HTML content (tables, links, callouts, layouts) chosen from a picker.

---

The module ships a single configurable CKEditor 5 plugin (Drupal plugin id `ckeditor5_template_template`, backed by the JavaScript plugin `template.Template`) that registers a `template` toolbar item. You enable it per text format on the CKEditor 5 toolbar configuration screen (`/admin/config/content/formats`) by dragging the Template button into the active toolbar, exactly like any other CKEditor 5 button. Each format that uses the button points at a JSON file (the `file_path` setting) describing the available templates; the module bundles an example at `template/ckeditor5_template.json.example`. Every template in that file has a `title`, an inline SVG `icon`, a `description`, and an `html` payload that is inserted at the cursor. The plugin has two extra options — `show_toolbar_text` to render a label next to the toolbar icon and `custom_toolbar_text` to set that label. It is the CKEditor 5 successor to the old CKEditor 4 `ckeditor_template` module and depends only on core's Text Editor / CKEditor 5. There is no site-wide settings form and no `configure` route: all configuration lives on the per-format editor config entity.

---

- Give authors a "Template" button to drop in ready-made content blocks
- Insert a predefined data table skeleton (headers + rows) with one click
- Provide boilerplate call-to-action or promo blocks for marketing pages
- Offer a standard "link to our project" or footer snippet
- Insert accessible, pre-styled layout markup that non-technical editors can reuse
- Standardize recurring content patterns (FAQ blocks, disclaimers, callouts)
- Seed new nodes with a starter document structure
- Give each text format its own template library via separate JSON files
- Add company-branded email or newsletter fragments in a webform rich-text field
- Insert two-column or card layout HTML without hand-writing markup
- Provide a template picker with descriptive icons and summaries for each option
- Show or hide a text label next to the toolbar icon per format
- Rename the toolbar button label (e.g. "Insert block", "Snippets") per format
- Maintain templates as a versioned JSON file in the codebase or a custom module
- Migrate CKEditor 4 `ckeditor_template` workflows to CKEditor 5
- Restrict template insertion to specific roles by scoping it to a text format they use
- Provide different template sets to Basic HTML vs Full HTML editors
- Give editors reusable table structures that already match your theme's styling
- Speed up authoring of repetitive structured content
- Insert legally-required notices or signposting blocks consistently
- Supply starter markup for embedded media galleries or figure captions
- Let a distribution/recipe ship default content templates for its editors

