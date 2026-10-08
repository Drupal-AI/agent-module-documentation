<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SimpleSAMLphp Authentication lets Drupal users log in through a remote SAML identity provider (Azure AD, Okta, Shibboleth, a university federation) via a locally installed SimpleSAMLphp service point — enterprise single sign-on with no local passwords.

---

SAML is the enterprise SSO standard: users authenticate once at a central IdP and services trust its signed assertion instead of holding passwords. This module is the Drupal side, built on the `simplesamlphp/simplesamlphp` PHP library and Drupal's `externalauth` module. It delegates login to the configured IdP, and after the library reports the session authenticated it reads the configured SAML attributes to resolve or create a Drupal account keyed on the `unique_id` attribute (default `eduPersonPrincipalName`) via `externalauth`'s authmap. It can auto-provision users on first login (`register_users`), sync username/email on every login, and map SAML attribute values to Drupal roles through a rule string. Admin config lives at `/admin/config/people/simplesamlphp_auth` in three tabs — Basic, Local authentication, and User info and syncing — and nothing takes effect until the `activate` flag is turned on. Hooks let other modules veto a login, match a different existing user, alter the stored authname, remap roles, and copy extra attributes to profile fields.

Security lives in the assertion trust, which sits in the SimpleSAMLphp library configuration outside Drupal (SP metadata, IdP certificate, signature validation) — the module correctly delegates all crypto to the library's `isAuthenticated()` and never re-implements it. On the Drupal side the identity mapping is exact: the authname is the non-empty `unique_id` attribute (an empty attribute throws), an existing local username is linked only when the admin explicitly enables `autoenablesaml`, otherwise a username collision aborts the login. The two permissions (`administer simplesamlphp authentication`, `change saml authentication setting`) are high-privilege and marked restricted. Its companion `simplesamlphp_custom_attributes` maps additional SAML attributes to user fields.

For any site doing enterprise SSO this is the standard route. The module is sound; the real work is configuring the SimpleSAMLphp SP, the IdP certificate, and signature validation carefully.

---

- Authenticate Drupal users against a SAML IdP.
- Add enterprise single sign-on to a site.
- Delegate login to Azure AD, Okta, or ADFS.
- Join a university Shibboleth/SAML federation.
- Auto-provision Drupal accounts on first SAML login.
- Link SAML identities to pre-existing Drupal users.
- Map a SAML attribute (e.g. email) to the account.
- Sync username and email on every login.
- Populate Drupal roles from SAML attribute rules.
- Re-evaluate roles on every login.
- Restrict who may log in with a custom allow-login hook.
- Match an existing user by email instead of username.
- Store a non-default authname (e.g. email) per account.
- Copy extra SAML attributes to profile fields via a hook.
- Show a "Federated login" link on the user login form.
- Place a SAML auth-status block with login/logout links.
- Redirect the login page straight to the IdP.
- Keep certain local accounts (e.g. uid 1) able to log in locally.
- Set a post-logout redirect URL and trigger SAML single logout.
- Remove Drupal password fields for SAML-only users.
- Restrict high-privilege SAML settings to trusted admins.
- Migrate SimpleSAMLphp auth settings from Drupal 6/7.
