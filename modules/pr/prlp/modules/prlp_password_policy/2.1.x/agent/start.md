<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PRLP Password Policy — agent index

Integration glue between **`prlp`** and **`password_policy`**: enforces password-policy
constraints and shows the live constraints table on PRLP's password reset landing page. No
config, permissions, or Drush of its own — enabling it is the setup; the rules come from your
Password Policy entities. See the parent's
[../../../../2.1.x/agent/api/behavior.md](../../../../2.1.x/agent/api/behavior.md) for the PRLP
events this listens to.

## What it does

- **Event subscriber** (`PrlpPasswordPolicyEventSubscriber`, priority 800):
  - `prlp.password_validate` → runs `password_policy.validator->validatePassword()`; on failure
    calls `$form_state->setErrorByName('pass2', …)`.
  - `prlp.password_before_save` → sets `field_last_password_reset` = now,
    `field_password_expiration` = `0`, `field_pending_expire_sent` = `0` on the user.
- **Form alter** (`hook_form_user_pass_reset_alter`) → attaches the `password_policy_status`
  constraints table (themed `password_policy_status`, `#states` show-on-type) + an AJAX callback
  (`_prlp_password_policy_check_constraints`) that re-renders it as the user types.
- **Validation manager override** (`PrlpPasswordPolicyValidationManager`, service
  `prlp_password_policy.validation_manager`, extends `password_policy`'s) → `tableShouldBeVisible()`
  / `validationShouldRun()` also return TRUE on the `user.reset` / `user.reset.form` routes,
  loading the user from the route `uid`. The table shows only when a policy targeting the user's
  roles has **`show_policy_table = TRUE`**.
- **Route override** (`RouteSubscriber`) → `user.reset.form` controller becomes
  `PrlpPasswordPolicyController::prlpPasswordPolicyGetResetPassForm`, injecting hidden
  `pass_reset_hash` / `pass_reset_timeout` fields so AJAX re-validation keeps the one-time token.
- **`hook_element_info_alter`** → removes Password Policy's (and password_policy_extras') default
  `password_confirm` process callbacks (they need a user in form state PRLP may lack) and adds its
  own AJAX process callback.

## Key facts

- Requires `prlp` + `password_policy`. Whether the constraints table appears is driven by
  `password_policy` entities with `show_policy_table: true` for the user's roles.
- Config prefix for policies: `password_policy.password_policy.<id>`.
