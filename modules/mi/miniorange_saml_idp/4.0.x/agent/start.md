<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# miniOrange SAML Identity Provider — agent index

Makes **Drupal a SAML 2.0 IdP** — external SAML Service Providers trust Drupal for auth, and Drupal
users SSO into them via signed assertions. Inverse of a SAML SP module (Drupal is the authority).
Version **4.0.0**. Core `^9.3||^10||^11`. Configure at `miniorange_saml_idp.idp_setup`.

**Security:** protect the assertion-signing private key (its holder can forge assertions); register
only intended SPs with correct ACS URLs; release minimum attributes. Checked — does **not** disable
TLS verification (unlike the sibling `security_login_secure`). Vendor promotes paid tiers in the UI.
