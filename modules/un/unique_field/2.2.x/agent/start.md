# Unique Field — agent index

Form-submission validation that forces chosen fields on **nodes, taxonomy terms and users**
to be unique. No settings route (`configure` null); rules are edited inside each entity's
config form and stored in `unique_field.settings`. No dependencies. Pure procedural
(`unique_field.module`), no services/plugins/Drush.

- **Where the settings UI appears, the config structure, scope/comparison options, the
  override/bypass flow, and the two permissions** → [configure/unique.md](configure/unique.md)

Key facts:
- Permissions (`unique_field.permissions.yml`, both `restrict access: TRUE`):
  `unique_field_perm_admin` (configure rules), `unique_field_perm_bypass` (skip a duplicate error).
- Config object `unique_field.settings`: `unique_field_settings.<node_type>`,
  `unique_field_taxonomy.<vocabulary>`, `unique_field_user` — each with `fields`, `scope`
  (not for user), `comp` (`each`|`all`).
- Validation added via `hook_form_alter` `#validate` callbacks; builds a parameterised
  `SELECT` on the field's data table excluding the current entity; skips AJAX requests and
  submissions with hidden `unique_field_override == 1`.
- Only fields actually present in the submitted form are checked (hidden form-display fields
  are skipped).
