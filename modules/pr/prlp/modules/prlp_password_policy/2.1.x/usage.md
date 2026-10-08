<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PRLP Password Policy makes the Password Policy module work on PRLP's password reset landing page — enforcing your password constraints and showing the live "policy status" table when a user sets a new password from a reset link.

---

The submodule bridges `prlp` and `password_policy`. It subscribes to PRLP's two events: on `prlp.password_validate` it runs the Password Policy validator against the submitted password (and the user's roles) and adds a form error if the policy fails; on `prlp.password_before_save` it resets the user's policy expiration fields (`field_last_password_reset` to now, `field_password_expiration` and `field_pending_expire_sent` to `0`) so a fresh reset counts as a compliant password change. It alters the `user_pass_reset` form (`hook_form_user_pass_reset_alter`) to attach the `password_policy_status` constraints table (with `#states` so it appears once the user types) and wires an AJAX callback that re-renders that table as the user types — but only when its overridden validation manager says the table should show. That override, `PrlpPasswordPolicyValidationManager` (replacing `password_policy.validation_manager` — actually registered as `prlp_password_policy.validation_manager`), extends Password Policy's manager so `tableShouldBeVisible()` / `validationShouldRun()` also return TRUE on the anonymous `user.reset` / `user.reset.form` routes (loading the user from the route `uid`), which the stock manager wouldn't do. It also replaces the `user.reset.form` route controller with `PrlpPasswordPolicyController` to carry the reset hash/timeout through AJAX requests, and disables Password Policy's default `password_confirm` process callback (which needs a user in form state that PRLP may not have) in favour of its own. It has no configuration, permissions or Drush of its own — enabling it is the whole setup; the actual rules come from your Password Policy entities (those with "Show policy table" enabled drive the table).

---

- Enforce site password-strength rules when users set a password from a reset link.
- Show the live password-policy constraints table on the PRLP reset landing page.
- Update the constraints table via AJAX as the user types their new password.
- Block a reset password that fails the configured Password Policy (form error on the reset page).
- Reset a user's password-expiration clock when they change password via a reset link.
- Set `field_last_password_reset` to now on a reset so expiry policies restart cleanly.
- Clear `field_password_expiration` / `field_pending_expire_sent` flags on a reset.
- Make Password Policy apply on the anonymous reset routes (which it normally skips).
- Combine forced periodic password changes with a friendly reset-and-set-password flow.
- Guide users to a compliant password before they finish logging in.
- Reduce failed logins caused by users choosing policy-violating passwords at reset.
- Keep AJAX validation working by carrying the reset hash/timeout across requests.
- Avoid Password Policy's default process callback erroring when no user is in form state.
- Only show the policy table for roles whose policy has "Show policy table" enabled.
- Support first-login password setup for new accounts under a password policy.
- Let admins rely on one Password Policy config across account edit and reset pages.
- Provide immediate, per-constraint feedback (met/unmet) during a reset.
- Integrate without writing custom event subscribers or form alters.
- Ensure expiry emails/pending flags don't misfire after a legitimate reset.
- Pair with PRLP's required-password setting to force a compliant new password at reset.
