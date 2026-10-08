# Webform Translation Permissions — agent index

Adds **two granular permissions** so users can translate webform config without the broad
`translate configuration` permission. No config UI (`configure: null`); you just grant the
permissions.

- **The permissions, the access check, and how the config-translation routes are rewired** →
  [permissions/webform-translation.md](permissions/webform-translation.md)

Key facts:
- Permissions: `translate any webform`, `translate own webform` (own = webform owner uid ==
  current user).
- Access check service `webform.translation_form_access` (id `_webform_translation_form_access`),
  extending core `ConfigTranslationFormAccess`.
- `hook_config_translation_info_alter()` replaces the webform mapper with `WebformMapper`;
  `hook_entity_operation()` adds a **Translate** link on webforms.
- Depends on `webform` and core `config_translation`. No config schema, no Drush, no plugins.
