<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SAML Drupal Login builds on the saml_sp module to actually log Drupal users in via an external SAML Identity Provider, mapping SAML responses to Drupal accounts.

---

This submodule registers `saml_sp_drupal_login__saml_authenticate()` as the SAML callback so that, after saml_sp validates an IdP response, a Drupal user is matched (by NameID/email, via `saml_sp_drupal_login_get_user()`) and logged in with `user_login_finalize()`. Login is initiated at `/saml/drupal_login/{idp}`. Its behavior is controlled by the `saml_sp_drupal_login.config` object: which IdP(s) are enabled, whether to force IdP re-authentication (`force_authentication`), whether to bypass the Drupal login form entirely and redirect `/user` straight to the IdP (`force_saml_only`), where to send already-logged-in users (`logged_in_redirect`), single logout from the IdP (`logout`), and how to handle users with no matching account — deny, let them request an account (`account_request_request_account`), auto-create an account without admin approval (`account_request_create_account`), or log them into a shared authenticated-only account (`no_account_authenticated_user_role` / `no_account_authenticated_user_account`). It can also update a user's email/language from IdP attributes (`update_email`, `update_language`) and exposes `hook_saml_sp_drupal_login_user_attributes()` to sync additional attributes onto the account. Admin UI: `/admin/config/people/saml_sp/login` (route `saml_sp_drupal_login.config`, permission "configure saml sp"). Depends on `saml_sp`.

---

- Let staff log in to Drupal with their corporate SSO (Okta, Entra ID, OneLogin, ADFS) instead of a password.
- Initiate SAML login by linking to `/saml/drupal_login/{idp}`.
- Force SSO-only login by redirecting `/user` straight to the IdP (`force_saml_only`).
- Keep the normal Drupal login form but add a SAML option alongside it.
- Auto-provision a Drupal account the first time a user authenticates (`account_request_create_account`).
- Let unknown but authenticated users request an account instead of being denied.
- Log users with no account into a shared authenticated-only account for limited access.
- Match returning users by email (NameID = mail) or by a custom NameID field.
- Force re-authentication at the IdP even if an SSO session already exists (`force_authentication`).
- Log the user out of the IdP as well when they log out of Drupal (single logout).
- Redirect already-logged-in users to a specific page when they hit the login route.
- Update a user's email address from the IdP when it changes (`update_email`).
- Update a user's language preference from an IdP `language` attribute (`update_language`).
- Sync roles or profile fields from SAML attributes via `hook_saml_sp_drupal_login_user_attributes()`.
- Restrict which registered IdPs are usable for Drupal login.
- Provide a "Request an account" flow at `/user/saml_sp_drupal_login_register` for SSO users.
- Disable password-reset/email editing prompts that don't apply to SSO-managed accounts.
- Combine multiple IdPs so different user populations log in through different providers.
- Send a friendly message when authentication fails or no account matches.
- Enforce that email address is treated as the identity key between IdP and Drupal.
