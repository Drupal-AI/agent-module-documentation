<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks (`simplesamlphp_auth.api.php`)

All receive the SAML `$attributes` array (from the trusted, library-verified assertion).
Implement in `MODULE.module`.

- **`hook_simplesamlphp_auth_allow_login($attributes): bool`** — return FALSE to deny this SAML
  user's login. Any implementation returning FALSE blocks it. Implementations show their own
  error message. Use to restrict login by IdP-supplied role/group.
- **`hook_simplesamlphp_auth_existing_user($attributes): UserInterface|FALSE`** — map a SAML
  login to a pre-existing Drupal user when no authname/username match exists (e.g. match by
  email). Only consulted when `autoenablesaml` is on. Return the account to link, or FALSE.
- **`hook_simplesamlphp_auth_account_authname_alter(&$authname, UserInterface $account)`** —
  change the authname stored when an admin/user ticks "Enable this user to leverage SAML
  authentication" (default authname = Drupal username; e.g. set it to `$account->mail`).
- **`hook_simplesamlphp_auth_user_roles_alter(&$roles, $attributes)`** — add/replace the roles
  computed from `role.population` before they are applied.
- **`hook_simplesamlphp_auth_user_attributes(UserInterface $account, $attributes): UserInterface|FALSE`**
  — after login, copy extra SAML attributes onto the account (e.g. `field_first_name`); return
  the altered account to have it saved, or FALSE for no change.
