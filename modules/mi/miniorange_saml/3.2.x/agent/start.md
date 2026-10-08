<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# miniOrange SAML Service Provider (SP) (miniorange_saml) 3.2.x

Makes Drupal a SAML 2.0 **Service Provider** so users log in through an external IdP. All state lives in
the `miniorange_saml.settings` config object. No Drush, no plugin types, no own permissions (every admin
tab and diagnostic route uses core `administer site configuration`; only `/samllogin`, `/samlassertion`
and `/saml_metadata` are public). `configure` route: `miniorange_saml.sp_setup`.

- **IdP/SP config keys, tabs, routes, endpoints (`/samllogin`, `/samlassertion`, `/saml_metadata`)** →
  [configure/settings.md](configure/settings.md)
- **Login flow, assertion validation, attribute/role mapping, and the "is configured?" check** →
  [api/flow.md](api/flow.md)

Key facts: IdP details are stored as `miniorange_saml_idp_name` / `miniorange_saml_idp_issuer` /
`miniorange_saml_idp_login_url` / `miniorange_saml_idp_logout_url` / `miniorange_saml_idp_x509_certificate`.
SP-initiated login `/samllogin`; ACS `/samlassertion`; metadata `/saml_metadata` (`?download=1` to
download). Username/email attributes default to `NameID`. The ACS validates the assertion/response
signature against the configured certificate and checks Destination, the assertion validity window
(NotBefore/NotOnOrAfter with 120s skew), a one-time-use replay store, and the IdP issuer + SP audience.
First-time SSO users are auto-created; a default role is added when role mapping is enabled. Encrypted
assertions, custom certificate generation, multiple IdPs and provisioning are licensed features.
