# entity_form (Entity Browser IEF) — agent start

Machine name: **`entity_browser_entity_form`**. Glue submodule of
[entity_browser](../../../entity_browser/2.15.x/agent/start.md) + Inline Entity Form.
No config UI, no permissions. Two capabilities:

- **`entity_form` widget** (`src/Plugin/EntityBrowser/Widget/EntityForm.php`) — an
  Entity Browser widget that renders a full entity add form inside a browser to create
  new referenced entities. Configure its `entity_type`, `bundle`, `form_mode`,
  `submit_text` (schema `entity_browser.browser.widget.entity_form`). Add it as a widget
  when building a browser → parent's
  [configure/browsers.md](../../../entity_browser/2.15.x/agent/configure/browsers.md).

- **IEF complex widget integration** (`entity_browser_entity_form.module`) — implements
  `hook_field_widget_third_party_settings_form()` to add an `entity_browser_id` setting
  to Inline Entity Form (complex) widgets, and
  `hook_inline_entity_form_reference_form_alter()` to swap IEF's autocomplete "add
  existing" control for an `entity_browser` element (with custom validate/submit for
  multi-value handling). Set it on **Manage form display** for an IEF field.

Config is a third-party setting (`entity_browser_id`) on the field widget; no code to
call directly. See parent's [api/element.md](../../../entity_browser/2.15.x/agent/api/element.md)
for the `entity_browser` element this uses.
