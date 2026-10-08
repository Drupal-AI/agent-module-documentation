Meta Position moves the node edit form's "advanced" metadata panel (URL alias, authoring info, menu settings, promotion options, etc.) from the sidebar to below the main form, rendered as horizontal vertical-tabs, optionally only for selected content types.

---

This is a small UX module for the node add/edit form. It implements `hook_form_BASE_FORM_ID_alter()` on `node_form` and adds a `#process` callback that, when enabled, changes `$form['advanced']` from the default `vertical_tabs` sidebar group into a full-width `vertical_tabs` element under the main form and turns `$form['meta']` into a `details` group titled "Information", then attaches the `meta_position/node_meta` CSS library. Behavior is driven by config object `meta_position.settings` with two keys: `enabled` (0/1) and `node_types` (a list of content-type machine names; empty = all types). The settings form (`MetaPositionConfig`, route `meta_position.settings` at `/admin/config/content/meta`) exposes an "enable" checkbox and a per-content-type checkboxes element that is only visible when enabled. It is primarily useful with admin themes that extend Claro (Drupal 10/11) or Seven (older), and pairs well with Field Group / Paragraphs workflows where you want the full browser width for the node form. Note the settings route requires permission `administer site` (not the standard `administer site configuration`), which is not a permission core defines — in practice only user 1 will match unless a custom role provides it.

---

- Move the node form's advanced metadata panel from the right sidebar to below the main form.
- Render the metadata panel as full-width vertical tabs instead of a compact sidebar.
- Free up the full browser width for the main node form when using Paragraphs.
- Reorganize the node edit form when using Field Group to lay out fields as vertical tabs.
- Enable the repositioned layout only for specific content types (e.g. only "Article").
- Apply the layout to all content types by leaving the type selection empty.
- Turn the whole feature on or off site-wide with a single checkbox.
- Improve node-form ergonomics on admin themes that extend Claro.
- Keep similar behavior available on themes extending Seven / Adminimal.
- Rename the collected meta group to an "Information" details section under the form.
- Provide a lighter-weight alternative to fully custom node form templates.
- Ship the layout change as exportable config (`meta_position.settings`) across environments.
- Restrict the layout tweak to editors working on content-heavy types.
- Complement the Gin theme workflow where the sidebar can otherwise be hidden natively.
- Attach a small CSS-only adjustment (`node_meta` library) without JavaScript.
