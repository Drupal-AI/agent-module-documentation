# Webform Deter — agent index

Client-side JS that tests admin-configured regexes against webform text fields on submit and shows a
`confirm()` warning when a pattern matches. Depends on `webform`. One permission, a config schema, no Drush.

- **Config keys, the settings form, permission, and how the JS behaves** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object `webform_deter.settings`: `warning_message` (string), `patterns` (sequence of regex strings).
- Settings form route `webform_deter.settings.form` at `/admin/config/system/webform_deter/settings`;
  permission `administer webform_deter` (`restrict access: true`).
- `hook_webform_submission_form_alter` attaches library `webform_deter/webform_deter` and injects
  `drupalSettings.webform_deter.{warning_message, patterns}`; logic in `js/webform_deter.js`.
- Soft deterrent only — Cancel blocks one submit then detaches; no server-side enforcement.
