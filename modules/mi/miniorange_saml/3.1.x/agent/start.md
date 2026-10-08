<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# miniOrange SAML SP — agent index

Makes Drupal a SAML 2.0 **Service Provider** so users log in through an external IdP. All state lives in
the `miniorange_saml.settings` config object. No Drush, no plugin types, no own permissions (admin tabs use
core `administer site configuration`). `configure` route: `miniorange_saml.sp_setup`.

- **IdP/SP config keys, tabs, routes, endpoints (`/samllogin`, `/samlassertion`, `/saml_metadata`)** →
  [configure/settings.md](configure/settings.md)
- **Login flow, attribute/role mapping, and the "is configured?" check** → [api/flow.md](api/flow.md)

Key facts: IdP details are stored as `miniorange_saml_idp_name` / `miniorange_saml_idp_issuer` /
`miniorange_saml_idp_login_url` / `miniorange_saml_idp_x509_certificate`. SP-initiated login `/samllogin`;
ACS `/samlassertion`; metadata `/saml_metadata`. Username/email attributes default to `NameID`.
