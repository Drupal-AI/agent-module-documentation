<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login flow, mapping, and the "configured" check

## SP-initiated login (`/samllogin`)

`MiniorangeSamlController::samlLogin($relay_state = '')`:
1. Reads `miniorange_saml_idp_login_url` (the IdP SSO URL) from `miniorange_saml.settings`.
2. Builds a SAML AuthnRequest (`MiniOrangeSamlAuthnRequest::initiateLogin($acs_url, $sso_url, $issuer, $nameid_format, $relay_state)`)
   using the SP ACS URL (`/samlassertion`), SP issuer, and `miniorange_saml_nameid_format`.
3. Returns a `RedirectResponse` to the IdP.

## Assertion consumer (`/samlassertion`)

`MiniorangeSamlController::samlResponse()` handles the IdP's POSTed SAML response: it parses/validates the
assertion (signature checked against `miniorange_saml_idp_x509_certificate`), extracts the NameID / mapped
attributes, then finds or creates the Drupal user and logs them in. `/saml_metadata` serves the SP metadata
(`SPSSODescriptor`, `WantAssertionsSigned="true"`).

## Attribute & role mapping

On the Mapping tab (`Form\Mapping`): `miniorange_saml_username_attribute` and
`miniorange_saml_email_attribute` name which SAML attribute becomes the Drupal username/email (both default
to `NameID`). `miniorange_saml_enable_rolemapping`, `miniorange_saml_default_role` /
`miniorange_saml_default_role_index`, and `miniorange_saml_roleN_name` / `miniorange_saml_idp_roleN_name`
pairs drive role mapping (role mapping/provisioning are licensed features).

## The "is configured?" check and login link

`miniorange_saml_is_module_configured()` returns TRUE only when **`miniorange_saml_enable_login`** is on
**AND** both `miniorange_saml_idp_name` and `miniorange_saml_idp_issuer` are non-empty. When TRUE,
`hook_form_alter()` injects a `Login using <idp_name>` link (to `/samllogin`) onto the core user login form
and login block, and disables the page cache for those forms. So a minimal working SP needs at least:
`miniorange_saml_idp_name`, `miniorange_saml_idp_issuer`, `miniorange_saml_idp_login_url`,
`miniorange_saml_idp_x509_certificate`, with `miniorange_saml_enable_login = true`.

## No Drush / services to call

Everything is driven by config + the controller endpoints; there is no public service API or Drush command.
Configure by writing `miniorange_saml.settings` (via the tabs or drush config).
