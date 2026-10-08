# Required by role — agent index

A single **Required API** plugin that sets a field's `#required` flag based on the current
user's roles. Validation/UX only — it does **not** control access or visibility. Hard
dependency on `required_api` (>3.0). No admin page (`configure` null), no permissions,
no Drush. Ships a config schema for the plugin options.

- **How to set per-role required on a field, where options are stored, and the runtime
  logic** → [configure/field.md](configure/field.md)

Key facts:
- Plugin: `RequiredByRole` (id `required_by_role`, `src/Plugin/Required/RequiredByRole.php`)
  extends `required_api\Plugin\Required\RequiredBase`.
- Options UI: a `tableselect` of roles (Authenticated pseudo-role removed).
- Storage: field `required_api` third-party settings — `required_plugin` =
  `required_by_role`, `required_plugin_options` = array of role IDs.
- Runtime: `isRequired()` = current user has ANY selected role → field required.
- NOT access control: a non-required field is still shown and editable to all roles.
