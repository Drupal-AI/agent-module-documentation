<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: tabs, routes, endpoints, and config keys

All settings persist in the **`miniorange_saml.settings`** config object (schema
`config/schema/miniorange_saml.schema.yml`). The admin tabs live under
`/admin/config/people/miniorange_saml/…` and all require core permission `administer site configuration`.

## Admin tabs (forms)

| Route | Path | Purpose |
|---|---|---|
| `miniorange_saml.sp_setup` (**configure**) | `/admin/config/people/miniorange_saml/sp_setup` | Service Provider Setup — enter the external IdP details. Stores `miniorange_saml_idp_name`, `miniorange_saml_idp_issuer`, `miniorange_saml_idp_login_url`, `miniorange_saml_idp_x509_certificate`. |
| `miniorange_saml.idp_setup` | `/admin/config/people/miniorange_saml/idp_setup` | Shows the SP metadata / SP entity id & base URL to hand to the IdP. |
| `miniorange_saml.login_options` | `/admin/config/people/miniorange_saml/signon_settings` | Sign-in settings (enable login, auto-redirect, force auth, backdoor, relay state, redirects). |
| `miniorange_saml.mapping` | `/admin/config/people/miniorange_saml/Mapping` | Attribute & role mapping (username/email attribute, role mapping). |
| `miniorange_saml.advance_settings` | `/admin/config/people/miniorange_saml/AdvanceSettings` | Advanced settings. |
| `miniorange_saml.bundle_plan` | `/admin/config/people/miniorange_saml/user_provisioning` | User provisioning (licensed). |
| `miniorange_saml.licensing` | `/admin/config/people/miniorange_saml/Licensing` | Upgrade plans. |
| `miniorange_saml.support` | `/admin/config/people/miniorange_saml/MiniorageSupport` | Contact/support. |

## SAML endpoints (controllers)

| Route | Path | Role |
|---|---|---|
| `miniorange_saml.saml_login` | `/samllogin` | **SP-initiated login** — builds an AuthnRequest and redirects to `miniorange_saml_idp_login_url`. `_access: TRUE`. |
| `miniorange_saml.saml_response` | `/samlassertion` | **ACS** — receives & validates the IdP's SAML assertion, logs the user in. `_access: TRUE`. |
| `miniorange_saml.saml_metadata` | `/saml_metadata` | Serves the SP metadata XML. `_access: TRUE`. |
| `miniorange_saml.test_configuration` | `/testSAMLConfig` | Test the configured SSO. |

## Key config values (`miniorange_saml.settings`)

| Key | Default | Meaning |
|---|---|---|
| `miniorange_saml_idp_name` | `''` | Display name of the IdP (used in the login link). |
| `miniorange_saml_idp_issuer` | `''` | IdP entity id / issuer. |
| `miniorange_saml_idp_login_url` | `''` | IdP SSO (login) URL the AuthnRequest is sent to. |
| `miniorange_saml_idp_x509_certificate` | `''` | IdP signing certificate (validates assertions). |
| `miniorange_saml_nameid_format` | `urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified` | NameID format requested. |
| `miniorange_saml_username_attribute` | `NameID` | SAML attribute mapped to the Drupal username. |
| `miniorange_saml_email_attribute` | `NameID` | SAML attribute mapped to the Drupal email. |
| `miniorange_saml_enable_login` | `true` | Whether SAML login is active. |
| `miniorange_saml_auto_redirect_to_idp` | `false` | Send visitors straight to the IdP. |
| `miniorange_saml_force_auth` | `false` | Force re-authentication at the IdP. |
| `miniorange_saml_enable_backdoor` | `false` | Keep a Drupal-native login available. |
| `miniorange_saml_default_relaystate` | `''` | Default post-login redirect. |

Read/set via drush:

```bash
drush config:get miniorange_saml.settings miniorange_saml_idp_login_url
drush config:set miniorange_saml.settings miniorange_saml_email_attribute 'EmailAddress' -y
```

Note: `config/schema` types `miniorange_saml_customer_admin_email`, `_license_key`, `_customer_admin_phone`
and `_tx_id` as `NULL`; leave them null unless registering a paid plan.
