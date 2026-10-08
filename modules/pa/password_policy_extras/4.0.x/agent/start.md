# Password Policy Extras — agent index

Enhances the **Password Policy** module's live validation UX (AJAX-refreshing status table, failed-only
messages, hidden core suggestions, accessibility) and adds an event system to control table visibility
and validation per route/user. Config UI: `/admin/config/security/password-policy/extras/settings`
(`configure` = `password_policy_extras.settings`, permission `administer site configuration`). Depends on
`password_policy` ^4.0. No permissions of its own, no Drush.

- **Settings keys, the config form, and the JS behavior toggles** →
  [configure/settings.md](configure/settings.md)
- **The two events, the decorated validation manager, and the reusable form helper functions** →
  [api/events.md](api/events.md)

Submodules (own docs) — integrate Password Policy with other contrib password forms:
- `password_policy_change_pwd_page` (Password Separate Form / change_pwd_page) →
  [../../modules/password_policy_change_pwd_page/4.0.x/agent/start.md](../../modules/password_policy_change_pwd_page/4.0.x/agent/start.md)
- `password_policy_prlp` (Password Reset Landing Page / prlp) →
  [../../modules/password_policy_prlp/4.0.x/agent/start.md](../../modules/password_policy_prlp/4.0.x/agent/start.md)
- `password_policy_user_registrationpassword` (User Registration Password) →
  [../../modules/password_policy_user_registrationpassword/4.0.x/agent/start.md](../../modules/password_policy_user_registrationpassword/4.0.x/agent/start.md)

Key facts:
- Config `password_policy_extras.settings`: `disable_ajax_progress`, `failed_messages_only`,
  `hide_password_suggestions`, `display_status_after_pass`, `display_status_on_focus`,
  `status_refresh_delay` (ms). All default on except delay (500).
- Decorates service `password_policy.validation_manager` → `PasswordPolicyExtrasValidationManager`.
- Events (`PasswordPolicyExtrasEvents`): `password_policy_extras.skip_visibility` (CHECK_VISIBILITY),
  `password_policy_extras.skip_validation` (CHECK_VALIDATION).
