<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login flow, assertion validation, mapping, and the "configured" check

## SP-initiated login (`/samllogin`)

`MiniorangeSamlController::samlLogin($relay_state = '')`:
1. Confirms the SP is configured (`Utilities::isSpConfigured()` requires idp_name + idp_issuer +
   idp_login_url) and resolves the SP issuer/entity id (`Utilities::getIssuer()`, defaults to base URL)
   and ACS URL (`Utilities::getAcsUrl()` = `<base>/samlassertion`).
2. Builds a deflated+base64+urlencoded SAML AuthnRequest via
   `Utilities::createAuthnRequest($acs_url, $issuer, $nameid_format, $force_authn, $rawXml)` using
   `miniorange_saml_nameid_format`. `ForceAuthn="true"` is added when force-auth is on.
3. Appends `SAMLRequest` + `RelayState` to `miniorange_saml_idp_login_url` and returns a
   `RedirectResponse` to the IdP. RelayState defaults to the base URL and is only kept if local.

Special relay-state values route to diagnostics instead of a normal login: `displaySAMLRequest`
(`/showSAMLRequest`) pretty-prints the AuthnRequest; `testValidate` (`/testSAMLConfig`) runs the test
flow; `showSamlResponse` (`/showSAMLResponse`) prints the returned response.

## Assertion consumer (`/samlassertion`)

`MiniorangeSamlController::samlResponse()` reads the configured certificate, IdP issuer, SP entity id and
attribute config, then delegates parsing/validation to `MiniOrangeSamlAcs::processSamlResponse()`. That
method, in order:
1. base64-decodes `SAMLResponse`, blocks `<!DOCTYPE>` and disables the libxml external-entity loader
   before `DOMDocument::loadXML(..., LIBXML_NONET)`.
2. Reads the `samlp:StatusCode`; anything other than `Success` shows an error and exits.
3. Requires that the response and/or the assertion carries an XML-DSig signature (rejects when neither is
   signed). Each present signature is verified by `Utilities::processResponse()` →
   `Utilities::checkSign()`: the response `Destination` (if any) must equal the ACS URL, the signing
   certificate embedded in the message must match the configured
   `miniorange_saml_idp_x509_certificate` fingerprint (`findCertificate` by SHA-1), and the signature is
   verified with an allow-listed RSA-SHA1/256/384/512 algorithm. `Utilities::validateElement()` enforces
   that the validated node is actually the signed element.
4. Checks the assertion validity window: `NotOnOrAfter` and `NotBefore` against `time()` with a 120s
   allowance (`MiniorangeSamlConstant::ASSERTION_ALLOWANCE_SECONDS`).
5. Replay protection: rejects a response ID or assertion ID already seen, using the
   `keyvalue.expirable` stores `miniorange_saml.used_responses` / `miniorange_saml.used_assertions`
   (TTL derived from NotOnOrAfter, else 300s).
6. `Utilities::validateIssuerAndAudience()` requires the assertion Issuer to equal
   `miniorange_saml_idp_issuer` and an audience to equal the SP entity id.
7. Extracts the username (from `miniorange_saml_username_attribute`, else NameID), email (from
   `miniorange_saml_email_attribute`, else NameID), NameID and session index.

The controller then loads the user by name; if absent it creates an enabled account with a random
password and, when `miniorange_saml_enable_rolemapping` is on, adds the configured default role. Blocked
accounts are rejected. On success it stores `sessionIndex`/`NameID` in the session, invokes the
`invoke_miniorange_2fa_before_login` hook, calls `user_login_finalize()`, and redirects to the (local)
RelayState or base URL.

## SP metadata (`/saml_metadata`)

`MiniorangeSamlController::samlMetadata()` echoes an `EntityDescriptor` / `SPSSODescriptor` with
`AuthnRequestsSigned="false"`, `WantAssertionsSigned="true"`, the ACS (HTTP-POST) location and the SP
entity id. `?download=1` sends it as a file attachment.

## Attribute & role mapping

On the Mapping tab (`Form\Mapping`): `miniorange_saml_username_attribute` and
`miniorange_saml_email_attribute` name which SAML attribute becomes the Drupal username/email (both
default to `NameID`). `miniorange_saml_attrN_name` / `miniorange_saml_idp_attrN_name` (N=1..5) drive
custom attribute mapping; `miniorange_saml_enable_rolemapping`, `miniorange_saml_default_role` /
`miniorange_saml_default_role_index`, and `miniorange_saml_roleN_name` / `miniorange_saml_idp_roleN_name`
pairs drive role mapping (role/attribute mapping and provisioning are licensed features).

## The "is configured?" check and login link

`miniorange_saml_is_module_configured()` returns TRUE only when **`miniorange_saml_enable_login`** is on
**AND** both `miniorange_saml_idp_name` and `miniorange_saml_idp_issuer` are non-empty. When TRUE,
`hook_form_alter()` injects a `Login using <idp_name>` link (to `/samllogin`) onto the core user login
form and login block — and, if `miniorange_saml_sso_link_on_custom_form` is set, onto any form id listed
in `miniorange_saml_custom_form_ids` — and disables the page cache for those forms. So a minimal working
SP needs at least: `miniorange_saml_idp_name`, `miniorange_saml_idp_issuer`,
`miniorange_saml_idp_login_url`, `miniorange_saml_idp_x509_certificate`, with
`miniorange_saml_enable_login = true`.

## No Drush / services to call

Everything is driven by config + the controller endpoints; there is no public service API or Drush
command. Configure by writing `miniorange_saml.settings` (via the tabs or drush config).
