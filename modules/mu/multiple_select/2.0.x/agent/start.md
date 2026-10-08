# Multiple Select — agent index

Adds a **"Select All / Uncheck All"** master checkbox above configured multi-value
**checkboxes** fields on node / media / taxonomy_term / site_setting_entity edit forms.
No field type or widget of its own; a JS helper toggles the child boxes.

Key facts:
- Configure route: `multiple_select.admin_form` → `/admin/config/content/multiple-config`.
- Permission: `access multiple select config page` gates that page.
- All persistent state is one config object `multiple_select.settings`, key **`table`** = a
  **JSON-encoded string** mapping `"<entity_type>-<bundle>"` → array of field machine names,
  e.g. `{"node-article":["field_tags"]}`.
- Only fields whose form-display widget renders as `checkboxes` (core `options_buttons` on a
  multi-value `list_string` / `entity_reference` field) actually get the helper.

Docs:
- **Register fields / where the config lives / drush** → [configure/select-all.md](configure/select-all.md)
- **How the form alter + JS works (mechanism)** → [api/mechanism.md](api/mechanism.md)
