A submodule of Password Policy Extras that makes Password Policy enforce and display on the Password Reset Landing Page (PRLP) module's one-time-login password form, and resets password-expiration fields when a user sets a new password there.

---

PRLP lets a user set a new password directly on the one-time-login (`user.reset`) landing page. This submodule integrates Password Policy with that flow through several mechanisms. It adds the policy status table to the reset form via `hook_form_user_pass_reset_alter()` (using the parent's `_password_policy_extras_status_item()` and `_password_policy_extras_add_libraries_and_settings_to_form()` helpers). Its `RouteSubscriber` overrides the `user.reset.form` route's controller with `PasswordPolicyPrlpController`, which preserves the `pass_reset_hash`/`pass_reset_timeout` across AJAX requests (storing them in the session and re-injecting them as hidden fields) so the AJAX status refresh doesn't lose the one-time-login token. Its event subscriber (extending the parent's `PasswordPolicyExtrasEventSubscriber`) overrides `CHECK_VISIBILITY`/`CHECK_VALIDATION` for the `user.reset.form` route (loading the target user by `uid` route param and respecting PRLP's `password_required` setting), subscribes to PRLP's `PASSWORD_VALIDATE` event to validate the entered password against the policy (`password_policy.validator`) and set a form error on `pass2` if it fails, and subscribes to `PASSWORD_BEFORE_SAVE` to reset the user's `field_last_password_reset`, `field_password_expiration`, and `field_pending_expire_sent` fields. Requires prlp 8.x-1.11+. No config, permissions, or routes of its own.

---

- Show the password policy status table on the PRLP one-time-login password-reset form.
- Validate a new password set via the reset landing page against the active password policies.
- Block a password reset that fails policy, with an inline error on the confirm-password field.
- Provide live AJAX policy feedback while typing a new password during account recovery.
- Preserve the one-time-login hash/timeout across AJAX status refreshes on the reset form.
- Reset the user's last-password-reset date when they set a new password via PRLP.
- Clear password-expiration and pending-expire flags on a successful reset-page password change.
- Respect PRLP's `password_required` setting when deciding whether to validate.
- Load and apply policies for the correct target user on the reset route (by `uid`).
- Keep password expiration policy accurate for users who recover access via the landing page.
- Integrate Password Policy with account recovery without a separate edit-profile step.
- Enforce strong passwords at the exact moment users are most likely to pick a weak one (recovery).
- Override the core reset-form controller cleanly via a route subscriber.
- Reuse Password Policy Extras' visibility/validation event system for the reset route.
- Support sites that combine forced password expiration with self-service reset.
