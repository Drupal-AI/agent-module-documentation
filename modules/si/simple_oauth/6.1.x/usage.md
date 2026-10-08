Simple OAuth turns Drupal into an OAuth 2.0 authorization server (with OpenID Connect), issuing bearer access/refresh tokens so external apps and decoupled front ends can authenticate against the site's REST/JSON:API endpoints.

---

Built on the battle-tested `league/oauth2-server` library, Simple OAuth implements the OAuth 2.0 Authorization Framework and OpenID Connect on top of Drupal. It pairs with the **Consumers** module: each client application is a consumer, and the module issues signed access tokens (and optional refresh tokens) that grant that client — acting as a Drupal user — a set of scopes. Tokens are stored as `oauth2_token` content entities and are RSA-signed using a public/private key pair whose paths you configure (keys can be generated from the settings form or `drush simple-oauth:generate-keys`). It exposes the standard endpoints `/oauth/token`, `/oauth/authorize`, `/oauth/userinfo`, `/oauth/jwks` and `/oauth/debug`, and registers a global `oauth2` authentication provider so any route can accept `Authorization: Bearer …`. Access is defined by **scopes**, which can be dynamic config entities managed in the UI or, with the bundled `simple_oauth_static_scope` submodule, static YAML-defined plugins; each scope maps to Drupal permissions or roles via a granularity plugin. The module is extensible through three plugin types — grant types (`Oauth2Grant`), scope providers (`ScopeProvider`) and scope granularity (`ScopeGranularity`) — and alter hooks let you inject custom JWT/OIDC claims. It is the de-facto standard for securing JSON:API/REST APIs, mobile app backends, and single-page-app logins on Drupal.

---

- Secure a JSON:API backend so only authenticated clients can read/write content.
- Authenticate a decoupled React/Vue/Angular front end against Drupal.
- Issue tokens to a mobile app so it can call the site's REST API.
- Implement the Client Credentials grant for server-to-server API access.
- Implement the Authorization Code grant for third-party user login.
- Add "Login with Drupal" (OpenID Connect provider) to another application.
- Issue refresh tokens so clients can renew access without re-prompting.
- Expose OpenID Connect user claims at `/oauth/userinfo`.
- Publish JWKS public keys at `/oauth/jwks` for token verification.
- Define fine-grained scopes that map to specific Drupal permissions.
- Define scopes that map to Drupal roles for coarse access control.
- Create umbrella (parent) scopes that aggregate child scopes.
- Restrict which scopes a client may request per grant type.
- Generate RSA signing keys from the admin UI or Drush.
- Set per-consumer token expiration for access, refresh, and auth codes.
- Debug an incoming token's identity and granted access via `/oauth/debug`.
- Automatically purge expired tokens on cron in configurable batches.
- Inject custom private JWT claims via `hook_simple_oauth_private_claims_alter()`.
- Inject custom OIDC claims (e.g. phone number) via `hook_simple_oauth_oidc_claims_alter()`.
- Use static, deployable YAML scopes with the `simple_oauth_static_scope` submodule.
- Swap the scope provider (dynamic vs static) to fit your deployment workflow.
- Add a custom OAuth2 grant type via an `Oauth2Grant` plugin.
- Provide scopes from an external source with a custom `ScopeProvider` plugin.
- Create client-credentials tokens directly from the admin UI for testing.
- Let a partner integration call the API as a limited service account.
- Protect a headless commerce or content API for a native app.
- Enforce that tokens expire quickly to reduce the impact of leaks.
- Reference OAuth2 scopes from an entity field (`oauth2_scope_reference`).
