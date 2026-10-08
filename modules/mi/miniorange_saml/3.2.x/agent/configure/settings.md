<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: tabs, routes, endpoints, and config keys

All settings persist in the **`miniorange_saml.settings`** config object (schema
`config/schema/miniorange_saml.schema.yml`). The admin tabs live under
`/admin/config/people/miniorange_saml/…` and all require core permission `administer site configuration`.

## Admin tabs & admin-only routes (forms/controllers)

| Route | Path | Purpose |
|---|---|---|
| `miniorange_saml.sp_setup` (**configure**) | `/admin/config/people/miniorange_saml/sp_setup` | Service Provider Setup — enter the external IdP details (`Form\MiniorangeSpInfo`). Stores `miniorange_saml_idp_name`, `miniorange_saml_idp_issuer`, `miniorange_saml_idp_login_url`, `miniorange_saml_idp_logout_url`, `miniorange_saml_idp_x509_certificate`. |
| `miniorange_saml.idp_setup` | `/admin/config/people/miniorange_saml/idp_setup` | Service Provider Metadata — shows the SP metadata / SP entity id & base URL to hand to the IdP. |
| `miniorange_saml.login_options` | `/admin/config/people/miniorange_saml/signon_settings` | Sign-in settings (enable login, auto-redirect, force auth, backdoor, relay state, redirects). |
| `miniorange_saml.mapping` | `/admin/config/people/miniorange_saml/Mapping` | Attribute & role mapping (username/email attribute, custom attributes, role mapping). |
| `miniorange_saml.advance_settings` | `/admin/config/people/miniorange_saml/AdvanceSettings` | Advanced settings. |
| `miniorange_saml.bundle_plan` | `/admin/config/people/miniorange_saml/user_provisioning` | User provisioning (licensed). |
| `miniorange_saml.licensing` | `/admin/config/people/miniorange_saml/Licensing` | Upgrade plans. |
| `miniorange_saml.support` | `/admin/config/people/miniorange_saml/MiniorageSupport` | Contact/support. |
| `miniorange_saml.trial` | `/admin/config/people/miniorange_saml/trial` | Request a full-feature trial (`Form\MiniorangeTrial`). |
| `miniorange_saml.add_new_idp` | `/admin/config/people/miniorange_saml/add_new_idp` | Modal explaining multi-IdP is licensed. |
| `miniorange_saml.generate_certificate` | `/admin/config/people/miniorange_saml/generate_certificate` | Generate custom X.509 certificates (Enterprise). |
| `miniorange_saml.confirm_delete_idp` | `/admin/config/people/miniorange_saml/confirm_delete_idp` | Delete the IdP configuration. |
| `miniorange_saml.modal_form` | `/removeLicenseKey` | Remove-license modal. |
| `miniorange_saml.miniorange_saml_close_register` | `/close_registration` | Reset customer/registration state. |

## SAML endpoints & diagnostics (controllers)

| Route | Path | Access | Role |
|---|---|---|---|
| `miniorange_saml.saml_login` | `/samllogin` | `_access: TRUE` (public) | **SP-initiated login** — builds an AuthnRequest and redirects to `miniorange_saml_idp_login_url`. |
| `miniorange_saml.saml_response` | `/samlassertion` | `_access: TRUE` (public) | **ACS** — receives & validates the IdP's SAML assertion, logs the user in. |
| `miniorange_saml.saml_metadata` | `/saml_metadata` | `_access: TRUE` (public) | Serves the SP metadata XML (`?download=1` to download). |
| `miniorange_saml.test_configuration` | `/testSAMLConfig` | `administer site configuration` | Test the configured SSO (relay state `testValidate`). |
| `miniorange_saml.saml_request` | `/showSAMLRequest` | `administer site configuration` | Pretty-print the generated AuthnRequest. |
| `miniorange_saml.saml_response_generator` | `/showSAMLResponse` | `administer site configuration` | Pretty-print the returned SAML response. |

## Key config values (`miniorange_saml.settings`)

| Key | Default | Meaning |
|---|---|---|
| `miniorange_saml_idp_name` | `''` | Display name of the IdP (used in the login link). |
| `miniorange_saml_idp_issuer` | `''` | IdP entity id / issuer (checked against the assertion Issuer). |
| `miniorange_saml_idp_login_url` | `''` | IdP SSO (login) URL the AuthnRequest is sent to. |
| `miniorange_saml_idp_logout_url` | `''` | IdP logout URL. |
| `miniorange_saml_idp_x509_certificate` | `''` | IdP signing certificate (validates assertions/responses). |
| `miniorange_saml_nameid_format` | `urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified` | NameID format requested. |
| `miniorange_saml_username_attribute` | `NameID` | SAML attribute mapped to the Drupal username. |
| `miniorange_saml_email_attribute` | `NameID` | SAML attribute mapped to the Drupal email. |
| `miniorange_saml_response_signed` / `miniorange_saml_assertion_signed` | `false` | Flags recording whether the IdP signs the response/assertion. |
| `miniorange_saml_enable_login` | `true` | Whether SAML login is active. |
| `miniorange_saml_auto_redirect_to_idp` | `false` | Send visitors straight to the IdP. |
| `miniorange_saml_force_auth` | `false` | Force re-authentication at the IdP (`ForceAuthn`). |
| `miniorange_saml_enable_backdoor` | `false` | Keep a Drupal-native login available. |
| `miniorange_saml_default_relaystate` | `''` | Default post-login redirect (local targets only). |
| `miniorange_saml_disable_autocreate_users` | `false` | Intended flag to disable auto-provisioning of new users. |
| `miniorange_saml_enable_rolemapping` | `false` | Enable role mapping / default-role assignment. |
| `miniorange_saml_default_role` / `_default_role_index` | `''` | Default role for provisioned users. |
| `miniorange_saml_roleN_name` / `_idp_roleN_name` (N=1..4) | `''` | Role-mapping pairs (licensed). |
| `miniorange_saml_attrN_name` / `_idp_attrN_name` (N=1..5) | `''` | Custom attribute-mapping pairs. |
| `miniorange_saml_base_url` / `miniorange_saml_entity_id` | `''` | Optional overrides for the SP base URL and entity id. |
| `miniorange_saml_character_encoding` | `true` | Apply CP1252 transcoding to the configured certificate fingerprint. |

## Custom login-link form keys

`miniorange_saml_sso_link_on_custom_form` (bool) and `miniorange_saml_custom_form_ids` (comma-separated
form ids) let the `Login using <IdP>` link be added to forms beyond the core `user_login_form` /
`user_login_block`. (Both are read by `hook_form_alter()` but are not declared in the config schema.)

Read/set via drush:

```bash
drush config:get miniorange_saml.settings miniorange_saml_idp_login_url
drush config:set miniorange_saml.settings miniorange_saml_email_attribute 'EmailAddress' -y
```

Note: `miniorange_saml_customer_admin_email`, `miniorange_saml_license_key`,
`miniorange_saml_customer_admin_phone` and `miniorange_saml_tx_id` default to `NULL`; leave them null
unless registering a paid plan.
