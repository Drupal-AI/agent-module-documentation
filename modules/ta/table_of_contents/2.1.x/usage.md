Table of Contents auto-generates an in-page navigation block from the headings inside a long-text field, linking each heading via anchors.

---

Enable it per field: on a `text_long` or `text_with_summary` field's edit form (*Manage fields → your field → edit*), a "Flexible Table of Contents" section (a `third_party_settings.table_of_contents` group added by `hook_form_field_config_edit_form_alter`) lets you tick **Enable the TOC block** and set a **CSS selector** (default `h2`) for the heading elements. Enabling it makes a derived block available per entity-type/bundle/field (`text_long_field_toc_block` deriver, category "Table of Contents") which you place via *Structure → Block layout*. At render the block runs the field value through `check_markup`, loads the HTML, and uses `symfony/css-selector` to find matching heading elements, emitting an `item_list` of anchor links. Headings that already have an `id` are linked directly; those without get a generated id, and a small jQuery behaviour (`table_of_contents.js`) assigns matching ids to the real headings in the rendered field on the client side. Block access follows the host entity and field `view` access, and the block is hidden when the field is empty. Toggling the setting rebuilds blocks. There is no global admin/config page and no permissions.

---

- Add an auto-updating table of contents to long articles or documentation pages.
- Build in-page jump navigation from `h2` headings without editing markup.
- Target a different heading level (e.g. `h3`) or any CSS selector for TOC items.
- Provide a TOC block for a specific content type's body field.
- Generate anchors automatically for headings that lack an `id`.
- Give readers quick navigation on a long legal/terms page.
- Place the TOC in a sidebar region via Block layout.
- Create separate TOC blocks for different fields or bundles.
- Respect field and entity view access so the TOC only shows permitted content.
- Hide the TOC automatically when the field has no content.
- Support both `text_long` and `text_with_summary` fields.
- Link to existing heading ids when authors set them.
- Build a TOC from headings inside CKEditor-authored content.
- Add navigation to knowledge-base or FAQ pages.
- Keep the TOC in sync with content since it is generated at render time.
- Offer per-field TOC configuration without touching code.
- Use on any fieldable entity type that has a supported long-text field.
- Improve accessibility/navigation of long single-page content.
- Provide anchor deep-links that readers can copy and share.
- Combine multiple values of a multi-value long-text field into one TOC.
