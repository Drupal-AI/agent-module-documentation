# Password Policy for PRLP — agent index

Submodule integrating Password Policy with the **Password Reset Landing Page** (`prlp`) module's
one-time-login password form (`user.reset`). No config, permissions, or routes of its own. Depends on
`password_policy_extras` + `prlp` (8.x-1.11+).

- **The route override, session hash handling, event subscriptions, and expiration-field reset** →
  [api/integration.md](api/integration.md)

Key facts:
- `RouteSubscriber` overrides `user.reset.form` controller → `PasswordPolicyPrlpController::getResetPassForm`
  (keeps `pass_reset_hash`/`pass_reset_timeout` across AJAX via session + hidden fields).
- `hook_form_user_pass_reset_alter` injects the policy status table (`_password_policy_extras_status_item`).
- Event subscriber overrides parent CHECK_VISIBILITY/CHECK_VALIDATION for `user.reset.form`, and hooks
  PRLP's `PASSWORD_VALIDATE` (validate + error on `pass2`) and `PASSWORD_BEFORE_SAVE` (reset expiration
  fields).

Parent reference: [configure/settings.md](../../../../4.0.x/agent/configure/settings.md),
[api/events.md](../../../../4.0.x/agent/api/events.md).
