# Protected Forms — agent index

Lightweight spam filter: rejects node/comment/webform/user/contact/private-message submissions whose
text contains disallowed Unicode scripts or preset patterns. No CAPTCHA, no plugins, no Drush.

- **All settings keys, defaults, the admin route, permissions, and how validation works** →
  [configure/settings.md](configure/settings.md)

Key facts: config object `protected_forms.settings` with a nested `protected_forms` mapping
(`allowed_scripts`, `check_quantity`, `reject_message`, `reject_patterns`, `log_rejected`,
`allowed_patterns`, `excluded_forms`). Admin at `/admin/config/content/protected_forms`
(route `protected_forms.admin`). Permissions: `administer protected forms`,
`bypass protected forms validation`. Rejected count is in State `protected_forms.rejected`;
rejections log to the `protected forms` dblog channel. Validation is added in `hook_form_alter()`.
