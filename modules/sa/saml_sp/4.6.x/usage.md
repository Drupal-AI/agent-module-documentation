<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SAML Service Provider (saml_sp) is an API module that turns a Drupal site into a SAML 2.0 Service Provider, validating authentication responses from external SAML Identity Providers using the OneLogin PHP SAML toolkit.

---

The module lets you register one or more SAML **Identity Providers** as `idp` config entities (each with its entityID, login/logout URLs, X.509 certificate and requested authn context) and exposes the standard SP endpoints: an assertion consumer service at `/saml/consume`, SP metadata at `/saml/metadata.xml`, and a logout callback at `/saml/logout`. Site-wide SP settings live in `saml_sp.settings` — technical/support contacts, organization info, security flags (message/assertion signing, NameID encryption, signature algorithm), the SP `entity_id`, and server file paths to the SP's X.509 `cert_location`/`key_location` used to sign requests and metadata. It is deliberately an **API/toolkit module**: it does not log anyone in by itself. Instead other code calls `saml_sp_start($idp, $callback)` to begin an AuthnRequest, and on return the `SamlSPController` consumes and validates the response before invoking the registered callback. The bundled `saml_sp_drupal_login` submodule provides that callback to actually authenticate Drupal users. It builds settings via `saml_sp__get_settings()`, generates metadata via `saml_sp__get_metadata()`, and offers `hook_saml_sp_settings_alter()` and `hook_saml_sp_authn_context_class_refs_alter()` for customization. An event subscriber warns admins when the SP certificate is close to expiry. Requires the `onelogin/php-saml` library (^3.8.2 | ^4.3.2). Admin UI: `/admin/config/people/saml_sp` (permission "configure saml sp").

---

- Turn a Drupal site into a SAML 2.0 Service Provider that trusts an external IdP.
- Integrate with enterprise IdPs like Okta, Azure AD / Entra ID, OneLogin, ADFS, Ping or Shibboleth.
- Register multiple Identity Providers and let code choose which one to authenticate against.
- Expose SP metadata at `/saml/metadata.xml` to hand to an IdP administrator.
- Publish the assertion consumer service (ACS) endpoint at `/saml/consume` for IdP responses.
- Sign AuthnRequests, logout requests/responses and metadata with the SP's X.509 key.
- Require signed assertions and signed messages from the IdP for stronger security.
- Configure the SP `entityId` presented to the IdP for the relying-party trust.
- Set technical and support contact people, and organization details, in SP metadata.
- Choose the requested authentication context (password, TLS client, X.509, Kerberos, Windows, etc.).
- Encrypt or require encryption of the SAML NameID.
- Pick the XML signature algorithm (e.g. RSA-SHA256) used for signing.
- Paste an IdP's XML metadata into the IdP form to auto-populate its configuration.
- Point the SP at server-side certificate/key files (`cert_location`/`key_location`) PHP can read.
- Rotate the SP certificate by staging a `new_cert_location` that is advertised in metadata.
- Get an admin warning when the SP certificate is near its expiration date.
- Programmatically start SAML authentication from custom code via `saml_sp_start()`.
- Provide your own post-authentication callback to map IdP responses onto your app's logic.
- Alter generated SAML settings per IdP with `hook_saml_sp_settings_alter()` (e.g. relax strict mode).
- Add custom authn context class refs via `hook_saml_sp_authn_context_class_refs_alter()`.
- Enable strict SAML 2.0 protocol processing for spec-compliant validation.
- Toggle debug mode to inspect NameIDs and responses during IdP integration.
- Set a `valid_until` expiry on the published SP metadata.
- Combine with `saml_sp_drupal_login` to log Drupal users in via the IdP.
