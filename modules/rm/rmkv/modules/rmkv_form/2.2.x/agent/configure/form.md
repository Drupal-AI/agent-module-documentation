# Removal form

The submodule's entire UI is one form.

- **Route:** `rmkv_form.form` at `/admin/config/development/rmkv` (`_admin_route: TRUE`,
  `_title: "Remove system.schema key/value storage"`). This is the module's `configure` route.
- **Form class:** `Drupal\rmkv_form\Form\RemoveKeyValueForm` (extends `ConfigFormBase`),
  form id `rmkv_form`.
- **Menu link:** `rmkv_form.form` under `system.admin_config_development` (Configuration ▸
  Development), defined in `rmkv_form.links.menu.yml`.
- **Access:** permission `access to rmkv form` — see [../permissions/access.md](../permissions/access.md).

Form fields:

| Field label | Machine key | Type | Notes |
|---|---|---|---|
| Machine name of the system.schema key/value storage for remove | `system_schema_key_value_machine_name` | `machine_name` | The extension machine name whose `system.schema` record you want to delete. |

Behavior:
- `buildForm()` renders the single `machine_name` element; its `#machine_name.exists` callback is
  `validateMachineName()`.
- `validateMachineName()` sets a form error if the name is **not** present in `system.schema`, or if
  it **is** an installed profile/module/theme (you may only remove orphaned records).
- `submitForm()` re-checks the same guards and, when safe, calls
  `$keyValueStore->delete($machine_name)` on the `system.schema` store and shows a success message;
  otherwise it shows an error/warning. The user-supplied name is only echoed back through `t()` with
  the `@machine_name` placeholder (auto-escaped).
- Constructor injects `extension.list.profile`, `module_handler`, `theme_handler`, and the
  `keyvalue` factory (`->get('system.schema')`) via `create()`.

Config note: the form extends `ConfigFormBase` and lists `rmkv_form.form` in
`getEditableConfigNames()`, but `submitForm()` never writes config — no settings are persisted, and
the module ships no `config/` or `config/schema/` files. The only effect is the key/value deletion.
Back up the database before removing a record; deleting a schema record is equivalent to telling
Drupal that extension was uninstalled.
