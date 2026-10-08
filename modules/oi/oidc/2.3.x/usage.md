<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OpenID Connect Client turns Drupal into an OIDC relying party (client): users sign in through the Authorization Code flow against an external identity provider — Keycloak, Entra ID, Okta, Auth0, Google — instead of a local Drupal password. Each provider is a "realm", and the bundled generic realm discovers its endpoints from the provider's `.well-known/openid-configuration`.

---

Any organisation running more than a handful of internal systems runs an identity provider, and the expectation is that Drupal joins it rather than keeping a separate password store. OIDC is the current standard for that — an OAuth 2.0 flow with an identity layer — and this module implements the client side. It builds on `externalauth`, the shared contrib service that maps a remote identifier to a local Drupal account, so the account-linking semantics match the SAML and CAS modules. Providers are modelled as `OpenidConnectRealm` plugins: the generic realm is configured entirely through the admin UI (`/admin/config/people/oidc/realms`) with a client id/secret, requested scopes, and a claim-to-field mapping (id, username, e-mail, given/family name), while sites with unusual providers can ship their own realm plugin by extending `OpenidConnectRealmBase` and returning the endpoints. Multiple realms coexist because the login route is per realm (`/oidc/login/{realm}`), and the module can optionally replace `/user/login`, redirect anonymous 403s to the login page, and disable Drupal's own registration and password-reset routes so users are funnelled through SSO. On login it looks up the mapped account, links a matching existing account by e-mail, or registers a new one; on each visit it refreshes an expired access token from the refresh token or ends the Drupal session when the remote session is gone. Version 2.3.0 targets core `^10 || ^11`; the `sop/jwx` dependency (used to validate the ID token) pulls in `sop/crypto-types`, which needs the PHP `gmp` extension.

---

- Log in to Drupal with a corporate identity provider.
- Authenticate users against Keycloak.
- Use Entra ID (Azure AD) for staff login.
- Add single sign-on to an intranet site.
- Configure several OIDC providers side by side.
- Map provider claims to Drupal username, e-mail and name fields.
- Assign a default role to every new SSO user.
- Auto-link existing local accounts to an IdP by e-mail.
- Replace the /user/login page with a provider login.
- Redirect anonymous access-denied pages to the SSO login.
- Disable Drupal's registration and password-reset routes.
- Integrate with Okta or Auth0.
- Authenticate customers via a social identity provider.
- Support university federated login (eduGAIN-style IdP).
- Keep SSO alongside local login (append ?local to reach it).
- Log out through the provider (RP-initiated end-session).
- Refresh tokens transparently to keep sessions valid.
- Choose how the display name is built from claims.
- Request extra profile data from the userinfo endpoint.
- Use a realm purely for authentication and then forget the session.
- Centralise account deprovisioning at the IdP.
- Reduce password-reset support load.
- Add a custom realm plugin for a non-standard provider.
- Migrate an ageing SAML integration to OIDC.
