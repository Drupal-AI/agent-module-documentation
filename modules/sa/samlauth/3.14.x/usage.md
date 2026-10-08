SAML Authentication turns a Drupal site into a SAML 2.0 Service Provider (SP) so users can log in through an external SAML Identity Provider (IdP) such as ADFS, Azure AD/Entra, Okta or SimpleSAMLphp. It handles the SAML message exchange via the OneLogin/php-saml toolkit and logs the validated user in to Drupal.

---

The module wires the OneLogin SAML PHP Toolkit into Drupal and exposes a fixed set of `/saml/*` endpoints: `/saml/login` starts SP-initiated login, `/saml/acs` is the Assertion Consumer Service that receives and validates the IdP response, `/saml/sls` handles Single Logout, and `/saml/metadata` publishes the SP metadata XML for the IdP to consume. All SP/IdP settings live in one config object, `samlauth.authentication`, edited across two admin forms under `/admin/config/people/saml` (login/user behavior) and `/admin/config/people/saml/saml` (entity IDs, endpoint URLs, certificates, signing/validation). Each SAML login is keyed by a never-changing Unique ID (a NameID or a named SAML attribute); on first login the module either links an existing Drupal account or creates a new one, storing the link in externalauth's `authmap` table (provider `samlauth`). Username and email are synchronised from configured attributes; a `SamlService` performs the login/acs/logout/metadata work, and a `SamlauthUserSyncEvent` / `SamlauthUserLinkEvent` let custom code map extra attributes, link accounts, or veto a login. Two shipped submodules extend attribute handling: `samlauth_user_fields` maps arbitrary SAML attributes onto user fields, and `samlauth_user_roles` grants/revokes roles based on SAML attribute values. The module builds on and depends on the `externalauth` module, and supports storing the SP private key via the Key module for safer secret handling.

---

- Let employees sign in to Drupal through a corporate IdP (ADFS, Azure AD/Entra, Okta, OneLogin, Google, SimpleSAMLphp) using SAML 2.0 SSO.
- Make Drupal a SAML Service Provider without writing SAML/XML code (the php-saml toolkit does it).
- Publish SP metadata at `/saml/metadata` so the IdP can be configured automatically.
- Configure the SP Entity ID, ACS URL and SLS URL to hand to the IdP administrator.
- Start SP-initiated login by sending users to `/saml/login` (optionally `?destination=…`).
- Force a fresh IdP login screen (bypassing an existing IdP session) via `/saml/reauth`.
- Perform Single Logout so logging out of Drupal also logs the user out at the IdP.
- Auto-create Drupal accounts on first SAML login from IdP-supplied name/email attributes.
- Link an existing Drupal account to a SAML login on first sign-in (by name, email, or prepopulated authmap).
- Identify each login by a stable Unique ID (NameID or a named attribute like employee number).
- Synchronise username and/or email from SAML attributes on every login.
- Redirect the standard Drupal login form straight to SAML (`login_auto_redirect`).
- Force certain users to log in only through SAML (disable local login except for allowed roles).
- Send users to a fixed URL after login/logout via `login_redirect_url` / `logout_redirect_url`.
- Store the SP private key securely through the Key module instead of in config or on disk.
- Require SAML messages/assertions to be signed and/or encrypted for security.
- Sign outgoing authentication and logout requests with the SP certificate.
- Rotate the SP certificate using the "new certificate" field during a key roll-over.
- Map additional SAML attributes onto user profile fields (samlauth_user_fields submodule).
- Grant or revoke Drupal roles from SAML attribute/group values (samlauth_user_roles submodule).
- Assign default roles to every SAML user, or only on their first login (samlauth_user_roles).
- Manage the SAML-login↔user links (authmap) and delete wrong links at `/admin/people/authmap/samlauth`.
- Act on or veto a login in custom code via the `SamlauthEvents::USER_SYNC` event.
- Override advanced php-saml toolkit settings via the `LIBRARY_CONFIG_ALTER` event (e.g. per-environment IdP endpoints).
- Turn on debug logging of incoming SAML messages to discover attribute names in assertions.
- Support IdPs that use the SAML HTTP-Redirect binding for the SSO endpoint.
- Change the IdP password via `/saml/changepw` when the IdP exposes a change-password URL.
- Deploy all SAML settings as configuration between environments (config export/import).
