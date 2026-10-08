<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SAML Auth Multi IdP provides multi IDP support for the SAML Authentication module.

---

SAML Auth Multi IdP adds **support for multiple identity providers (IdPs)** to the SAML Authentication
(samlauth) module — so a site can authenticate users against more than one SAML IdP (e.g. different
organizations/tenants), each with its own configuration. It depends on the samlauth module, provides its own
permissions, in the User Authentication package.

Use it for multi-IdP SAML SSO. It touches authentication; the actual SAML assertion validation (signatures,
conditions) is handled by **samlauth** (built on the OneLogin/SimpleSAML toolkit) — this module adds per-IdP
configuration and routing. Keep each IdP's certificate/metadata correct and ensure assertions are validated per
IdP, store any signing keys securely, and use HTTPS. It grants access via samlauth's provisioning + its
permissions. Configure the IdPs.

---

- Support multiple SAML IdPs.
- Authenticate against several IdPs.
- Serve multi-tenant/org SSO.
- Depend on the samlauth module.
- Add per-IdP configuration/routing.
- Let samlauth validate assertions.
- Keep each IdP's certificate/metadata correct.
- Ensure assertions are validated per IdP.
- Store signing keys securely + HTTPS.
- Provide its own permissions.
- Grant access via samlauth provisioning.
- Configure the IdPs.
- Handle multi-IdP SAML.
- Configure IdPs.
- Route SSO.
- Handle the integration.
- Authenticate via SAML.
- Add IdPs.
- Secure the keys.
- Provide multi-IdP SAML.
