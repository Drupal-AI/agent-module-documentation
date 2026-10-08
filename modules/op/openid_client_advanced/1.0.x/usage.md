<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OpenID Client Advanced provides an advanced OpenID Connect client plugin, adding JWT signature validation and nonce support.

---

OpenID Client Advanced provides an advanced OpenID Connect client plugin for the OpenID Connect module —
an OAuth 2.0 / OIDC client that adds **ID-token (JWT) signature validation** and **nonce** support on top of
the base client, for stricter, spec-compliant token verification against an OIDC provider. It depends on the
OpenID Connect module, in the OpenID Connect package.

Use it where a hardened OIDC client is needed (validating the provider's token signature and using a nonce).
It is security-enhancing and built on the correct foundation: it extends the OpenID Connect module's client
(which handles the OAuth **state** CSRF check via its state-token service) and **adds** JWT signature
validation (via a signature validator) and nonce support. When adopting: **enable the nonce option**
(`use_nonce`, which defaults to off) for replay protection, ensure the provider's signing keys/JWKS are
configured for signature validation, store the OIDC **client secret as a secret**, and operate over HTTPS. It
has no content-access role beyond authentication. Configure the OIDC client.

---

- Provide an advanced OIDC client.
- Validate the ID-token (JWT) signature.
- Support a nonce.
- Depend on the OpenID Connect module.
- Extend the base OIDC client.
- Rely on core's state (CSRF) check.
- Enable the nonce option for replay protection.
- Configure the provider's signing keys/JWKS.
- Store the OIDC client secret as a secret.
- Operate over HTTPS.
- Have no content-access role beyond auth.
- Configure the OIDC client.
- Harden token verification.
- Add signature validation.
- Use nonce support.
- Verify tokens strictly.
- Configure OIDC.
- Authenticate via OIDC.
- Handle the client secret securely.
- Validate tokens.
