<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SSO Connector OAuth makes Drupal an OAuth 2.0 / OIDC identity provider with PKCE and RS256.

---

SSO Connector – OAuth 2.0 turns Drupal into an OAuth 2.0 / OpenID Connect identity provider (IdP) for the SSO Connector suite — implementing the Authorization Code flow with PKCE and OIDC ID tokens signed with RS256, so other sites/apps can authenticate their users against this Drupal.

Security: the authorize endpoint validates the client and `redirect_uri` (rejecting unregistered URIs), **enforces PKCE**, bounds `state`/`nonce` length, and issues RS256-signed ID tokens — a defensively-correct OAuth IdP implementation. The `/oauth/token` endpoint is public by design (gated by client credentials/PKCE). Depends on `sso_connector`, core `user`, and `help`; requires Drupal 11.2+.

---

- Act as an OAuth 2.0 / OIDC IdP.
- Implement the Authorization Code flow.
- Enforce PKCE.
- Issue RS256-signed ID tokens.
- Validate client and redirect_uri.
- Reject unregistered redirect URIs.
- Bound state/nonce length.
- Expose a public token endpoint (client-gated).
- Depend on `sso_connector` and core `user`.
- Depend on core `help`.
- Require Drupal 11.2+.
- Authenticate other sites' users.
- Support OpenID Connect
- Follow OAuth security best practices
- Provide federated login.
- Configure OAuth clients.
- Support single sign-on.
- Secure the authorize flow
