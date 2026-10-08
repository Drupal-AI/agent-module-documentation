<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JWT Authentication Issuer exposes an endpoint that mints a signed JWT for the currently logged-in user, and can optionally attach a token to every user-login response.

---

This submodule is the token *issuer* half of the JWT stack. It registers the route `jwt/token` (`jwt_auth_issuer.jwt_auth_issuer_controller_generateToken`), which requires a logged-in user and accepts `jwt_auth`, `basic_auth` or `cookie` authentication; a `GET` there returns a freshly signed token for that user. It provides an event subscriber (`JwtAuthIssuerSubscriber`, on the base module's `GENERATE` event) that stamps the current user's id into the token as the nested `drupal.uid` claim, so tokens it mints are directly consumable by `jwt_auth_consumer`. A second subscriber (`JwtLoginSubscriber`) can add a `jwt` token to the JSON body of the core user-login REST response; this is toggled by the boolean `jwt_auth_issuer.config` `jwt_in_login_response` (shipped default `true`), which is surfaced as an extra checkbox on the base module's JWT config form (`/admin/config/system/jwt`) via a form alter. The module has config schema for that one setting but no dedicated settings route of its own — its `configure` link points at the base module's form. It depends on `jwt`, and to be useful a signing key must be configured there first.

---

- Give a logged-in user a JWT by calling the `jwt/token` endpoint.
- Bootstrap a decoupled login: authenticate once with basic auth to `jwt/token`, then use the returned Bearer token.
- Include a JWT automatically in the core user-login response body for SPA/mobile clients.
- Toggle that login-response behaviour with the `jwt_in_login_response` setting on the JWT config form.
- Mint tokens that already carry the `drupal.uid` claim so `jwt_auth_consumer` authenticates them.
- Exchange a session cookie for a stateless Bearer token to call REST endpoints.
- Issue tokens from server-side code with `JwtAuth::generateToken()` (dispatches the GENERATE event first).
- Let a mobile app obtain a token via cookie auth after a web login.
- Provide the standard token shape (iat/exp/drupal.uid) expected across the JWT modules.
- Disable the login-response token when only the explicit `jwt/token` endpoint should hand out tokens.
- Pair with `jwt_auth_consumer` for a complete issue-then-authenticate round trip.
- Re-issue a token on demand when a client's previous token has expired.
- Add extra claims to issued tokens by adding another `GENERATE` event subscriber.
- Secure the endpoint behind existing authentication providers (jwt_auth / basic_auth / cookie).
- Serve as a reference implementation of subscribing to `JwtAuthEvents::GENERATE`.
