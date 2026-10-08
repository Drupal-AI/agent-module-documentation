<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JWT Authentication Issuer — agent index

Mints signed JWTs for the logged-in user at `jwt/token`, and can attach a token to the
user-login response. Depends on `jwt`; a signing key must be configured there.

- **The one setting (`jwt_in_login_response`), where it lives and how to read/set it** →
  [configure/settings.md](configure/settings.md)
- **The `jwt/token` endpoint, the GENERATE subscriber, issuing tokens in code** →
  [api/issue.md](api/issue.md)

Key facts:
- Route `jwt_auth_issuer.jwt_auth_issuer_controller_generateToken` at path `jwt/token`
  (`_user_is_logged_in: TRUE`, `_auth: [jwt_auth, basic_auth, cookie]`).
- Config object `jwt_auth_issuer.config` with boolean `jwt_in_login_response` (ships `true`),
  edited on the base module's form `/admin/config/system/jwt` (this module has no own route;
  its `configure` = `jwt.jwt_config_form`).
- Subscriber `jwt_auth_issuer.subscriber` adds the current user's `drupal.uid` claim on
  `JwtAuthEvents::GENERATE`; `jwt_auth_issuer.login_listener` handles the login-response token.
