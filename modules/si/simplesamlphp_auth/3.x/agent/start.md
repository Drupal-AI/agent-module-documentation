<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# simpleSAMLphp Authentication (simplesamlphp_auth) — agent index

**SAML single sign-on** — authenticate against a remote IdP via a local simpleSAMLphp SP.
Version **3.x**. Core `^10 || ^11.3`. Companion: `simplesamlphp_custom_attributes` (extra attribute
mapping). Perms `administer simplesamlphp authentication`, `change saml authentication setting`
(**high-privilege — govern how everyone logs in; trusted admins only**).

Mature, standard SSO module. **Security is in the simpleSAMLphp config**, not the module: SP
metadata, IdP certificate, and **signature validation** must be correct — an SP that doesn't
validate assertion signatures is the classic SAML hole. Maps SAML attributes → accounts, can
auto-provision.