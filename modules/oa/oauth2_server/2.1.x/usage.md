OAuth2 Server turns a Drupal site into a full OAuth 2.0 / OpenID Connect authorization server — issuing access tokens, refresh tokens, authorization codes and ID tokens to registered clients — built on the `bshaffer/oauth2-server-php` library.

---

You define one or more **Server** config entities (each with a set of enabled grant types and advanced
lifetimes/settings), one or more **Scope** entities per server (one may be the default), and **Client**
entities (client_id/secret, redirect URIs, allowed grant-type overrides, automatic-authorization flag,
optional public key for JWT bearer). It exposes the standard endpoints as Drupal routes: `/oauth2/authorize`,
`/oauth2/token`, `/oauth2/tokens/{token}`, `/oauth2/UserInfo`, `/oauth2/revoke`, plus `/oauth2/certificates`
and `/oauth2/jwk` for public keys. Supported grant types are Authorization code, Client credentials, Refresh
token, User credentials (password), JWT bearer, and Implicit. Tokens and authorization codes are stored as
Drupal entities (`oauth2_server_token`, `oauth2_server_authorization_code`, `oauth2_server_jti`); the library
handles token/code generation, `redirect_uri` validation, `state`, and PKCE. Client secrets are stored hashed
via Drupal's password hasher (`checkClientCredentials` uses `PasswordInterface::check`). OpenID Connect ID
tokens are signed RS256 with an RSA keypair the module generates via OpenSSL, stores in `state`, publishes at
`/oauth2/jwk` + `/oauth2/certificates`, and rotates roughly daily on cron (cron also deletes expired tokens
and codes). A custom authentication provider (`oauth2` / `OAuth2DrupalAuthProvider`, priority 100) lets other
routes accept Bearer access tokens; `Utility::checkAccess($server, $scope)` verifies a token and scope for
custom endpoints. Two permissions gate everything: `administer oauth2 server` (manage servers/scopes/clients)
and `use oauth2 server` (reach the authorize/token endpoints). The module invites claims/scope customization
through five hooks (`hook_oauth2_server_claims`, `_user_claims_alter`, `_default_scope`,
`_scope_access_alter`, `_pre_authorize`). Config UI lives under
`/admin/structure/oauth2-servers`. No submodules.

---

- Act as the OAuth2 / OpenID Connect identity provider (IdP) for external apps or SPAs logging in with Drupal accounts.
- Issue access tokens via the Authorization code grant with a user-consent screen.
- Enable machine-to-machine API access with the Client credentials grant (no user).
- Support server-side apps that refresh access tokens via the Refresh token grant.
- Support the Implicit grant for legacy browser-based clients.
- Support the Resource Owner Password Credentials grant for trusted first-party apps.
- Support the JWT bearer grant using a client's registered public key.
- Provide OpenID Connect ID tokens (RS256) and a UserInfo endpoint for SSO.
- Publish signing keys as JWK (`/oauth2/jwk`) and X.509 certificates (`/oauth2/certificates`) for token verification.
- Protect a custom REST/JSON:API route by accepting `Authorization: Bearer <token>` via the `oauth2` auth provider.
- Enforce scope-based authorization on custom endpoints with `Utility::checkAccess($server, $scope)`.
- Register multiple OAuth clients (web app, mobile app, service) each with their own secret and redirect URIs.
- Skip the consent screen for fully trusted first-party clients (`automatic_authorization`).
- Require an exact `redirect_uri` match per server to harden against open-redirect/code interception.
- Enforce the OAuth `state` parameter to mitigate CSRF on the authorize endpoint.
- Define fine-grained scopes (e.g. `basic`, `email`, `profile`, `admin`) and a default scope per server.
- Add custom OpenID claims (phone, roles, org) via `hook_oauth2_server_claims()`.
- Alter or restrict available scopes per server/request via `hook_oauth2_server_scope_access_alter()`.
- Change the OpenID `sub` claim to a user property other than uid (`oauth2_server.oauth:user_sub_property`).
- Tune access-token, ID-token and refresh-token lifetimes per server.
- Choose JWT (crypto) access tokens instead of opaque database tokens per server.
- Revoke issued tokens through the `/oauth2/revoke` endpoint.
- Introspect an issued access token's data at `/oauth2/tokens/{token}`.
- Automatically expire and garbage-collect tokens and authorization codes on cron.
- Rotate ID-token signing keys automatically (~daily) following Google's practice.
- Provide OAuth login for a decoupled/headless front end backed by Drupal users.
