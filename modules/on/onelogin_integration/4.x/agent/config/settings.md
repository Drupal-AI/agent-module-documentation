<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — onelogin_integration.settings

Single config object `onelogin_integration.settings`. Edited at
**`/admin/config/system/onelogin_integration`** (`OneLoginIntegrationAdminForm`, form id
`onelogin_admin_form`, route `onelogin_integration.admin_form`, permission
`administer site configuration`). Schema: `config/schema/onelogin_integration.schema.yml`
(a `config_object`; note the schema only declares a subset of the keys the form actually writes).
Install defaults: `config/install/onelogin_integration.settings.yml`.

`submitForm()` writes **every** `$form_state` value straight into config
(`foreach getValues() … $config->set($key, $value)`), so the config keys equal the form element
keys below. `getEditableConfigNames()` returns just this object.

## Keys the form writes

Identity Provider (IdP):
- `entityid` (required) — IdP entity ID / Issuer URL. Also used as the fetch URL when
  `x509cert_onthefly` is on.
- `sso` (required) — IdP SSO endpoint (HTTP-Redirect binding).
- `slo_option` (bool) — enable Single Log Out.
- `slo` — IdP SLO endpoint URL.
- `logout_link` — post-logout redirect for SAML users when SLO is not used.
- `x509cert_onthefly` (bool) — if set, the module HTTP-GETs `entityid` and scrapes
  `ds:X509Certificate` out of the returned metadata (via EasyRdf `XMLParser`) instead of using
  `x509cert`.
- `x509cert` — IdP public X.509 certificate (required unless on-the-fly).

Options:
- `username_from_email` (bool) — derive username as `str_replace('@','.',$email)`.
- `saml_link` (bool, default TRUE) — show "Log in using SAML" on the login form.
- `account_matcher` — `username` or `email`. **Unset/anything-but-`username` ⇒ match by e-mail**
  (the `else` branch in `AuthenticationService::processLoginRequest()`).

Attribute mapping (names of IdP attributes to read from the assertion):
- `username` (required), `email` (required), `role`, `onelogin_role_delimiter` (fallback `;`).

Role mapping: one key per site role, `role_<machine_name>` — a comma-separated list of IdP role
groups; within a group, `|` means all values must be present (AND). Empty ⇒ that Drupal role is
never assigned. Anonymous/authenticated are excluded.

User experience:
- `current_pass_disabled`, `password_tab_disabled`, `email_field_disabled` (bools) — hide those
  fields/tabs for SAML-logged-in users.
- `create_new_account`, `request_new_password` — replacement URLs on the login form.

Advanced:
- `debug` (bool) — surfaces `getLastErrorReason()` on ACS errors.
- `strict_mode` (bool) — passed to php-saml as `strict`; turns on php-saml's full response
  validation in `Response::isValid()`. Enable it in production and configure the signing/encryption
  options below to match your IdP.
- `sp_entity_id` (default `php-saml` from install) — SP entity ID.
- `nameid_format` (default `urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress`).

Signing / encryption (configure to match your IdP; enable message/assertion signing in production):
- `nameid_encrypted`, `authn_request_signed`, `logout_request_signed`, `logout_response_signed`,
  `want_message_signed`, `want_assertion_signed`, `want_assertion_encrypted`.
- `sp_x509cert`, `sp_privatekey` — SP key pair (textareas), needed when any signing/encryption is
  on. **Stored as plain config values** in `onelogin_integration.settings` (i.e. exportable config).

## How the Auth instance is built

`SAMLAuthenticatorFactory::getAuth()` assembles the php-saml settings array and caches the `Auth`
object on the service (so repeated `createFromSettings()` calls in one request return the same
validated instance). It maps config → php-saml as:

- `sp.assertionConsumerService.url` = `Url::fromRoute('onelogin_integration.acs', absolute)`,
  `sp.singleLogoutService.url` = the `.slo` route, `sp.entityId` = `sp_entity_id`,
  `sp.NameIDFormat` = `nameid_format`, `sp.x509cert`/`sp.privateKey` = the SP pair.
- `idp.entityId` = `entityid`, `idp.singleSignOnService.url` = `sso`,
  `idp.singleLogoutService.url` = `slo`, `idp.x509cert` = configured or on-the-fly cert.
- `security.wantMessagesSigned`/`wantAssertionsSigned`/`wantAssertionsEncrypted`/`nameIdEncrypted`/
  `authnRequestsSigned`/`logoutRequestSigned`/`logoutResponseSigned` from the matching config keys.
  `signMetadata` is passed as FALSE.
- top-level `strict` = `strict_mode`, `debug` = `debug`.

Custom settings can be merged in by passing an array to `createFromSettings()`
(`NestedArray::mergeDeep($default_settings, $settings)`).

## Enable / operate

1. `composer require drupal/onelogin_integration` (pulls php-saml + easyrdf),
   `drush en onelogin_integration`. `hook_install` revokes *change own username* from authenticated
   users.
2. Give the IdP your SP metadata from `/onelogin_saml/metadata`
   (`Auth::getSettings()->getSPMetadata()`).
3. Fill IdP entity ID, SSO URL, X.509 cert, attribute mapping and role mapping; set the SAML
   validation options appropriate for your IdP; save and clear cache.
