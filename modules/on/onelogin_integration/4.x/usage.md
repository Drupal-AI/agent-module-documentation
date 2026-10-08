<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OneLogin Integration makes Drupal a SAML 2.0 Service Provider so users can sign in with OneLogin (or any SAML Identity Provider) instead of a local Drupal password.

---

The module wraps the official `onelogin/php-saml` v3 toolkit and wires it into Drupal's authentication flow. It publishes the standard SP endpoints under `/onelogin_saml/*` — SP-initiated SSO (`/sso`), the Assertion Consumer Service (`/acs`), Single Log Out (`/slo`) plus its service callback (`/sls`), and SP metadata (`/metadata`) — and an admin form at `/admin/config/system/onelogin_integration` where you enter the IdP entity ID, SSO/SLO URLs and X.509 certificate (or fetch the certificate on the fly from the IdP metadata URL), map SAML attributes to the Drupal username / e-mail / role fields, map IdP roles to Drupal roles, and toggle SAML behaviour (strict mode, request/response signing and encryption, SP entity ID, NameID format, SP key pair). On a valid response the `AuthenticationService` matches an existing Drupal user by e-mail (default) or username, or auto-provisions a new blocked account via `UserService`, syncs roles from the IdP role attribute, records the account in the `onelogin_authmap` table, and finalises the login. Optional touches include a "Log in using SAML" link on the core login form, forcing `/user` to the IdP, and hiding the local password / e-mail fields for SAML users. It provides one permission (`administer onelogin integration settings`), a config object with schema, an install-time schema table, and several form/login hooks; it does not provide plugins or Drush commands.

---

- Add SAML single sign-on to a Drupal 11 site.
- Authenticate Drupal users against OneLogin.
- Authenticate against any third-party SAML 2.0 IdP (Azure AD, Okta, Keycloak, ADFS, etc.).
- Run Drupal as a SAML Service Provider using the php-saml toolkit.
- Expose SP metadata at `/onelogin_saml/metadata` for IdP configuration.
- Handle SP-initiated SSO from a "Log in using SAML" link on the login form.
- Consume SAML assertions at the Assertion Consumer Service endpoint.
- Support SAML Single Log Out (front-channel) when enabled.
- Map the SAML username attribute to the Drupal account name.
- Map the SAML e-mail attribute to the Drupal account mail.
- Match Drupal accounts by e-mail or by username.
- Derive a username from the e-mail address for attribute-sparse IdPs.
- Auto-provision Drupal accounts on first SAML login.
- Synchronise Drupal roles from an IdP role attribute on every login.
- Map multiple IdP role values to a single Drupal role with delimiter/AND-group rules.
- Block accounts whose IdP roles do not map to any Drupal role.
- Configure a custom SP entity ID and NameID format.
- Encrypt the NameID and require signed/encrypted requests and responses.
- Supply an SP certificate and private key for signing or encryption.
- Force all logins through the IdP by redirecting `/user`.
- Redirect SAML users to a custom logout landing page.
- Hide the current-password, password, and e-mail fields for SAML users.
- Customise the "create account" and "request new password" links for SSO users.
- Detach an account from SAML from the user edit form to re-enable password login.
- Enable debug mode to surface SAML processing errors during setup.
