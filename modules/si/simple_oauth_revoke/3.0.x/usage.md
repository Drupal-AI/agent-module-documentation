<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple OAuth Revoke adds the `/oauth/revoke` endpoint defined by RFC 7009 to `simple_oauth`, so an OAuth client can tell the server that one of its access or refresh tokens is no longer valid.

---

Revocation is the part of OAuth that is easy to skip and matters most when something has gone wrong. Without it a token stays valid until it expires: logging out of a mobile app invalidates nothing, uninstalling it leaves a working credential behind, and a token discovered in a log or crash report cannot be turned off. Access tokens are often short-lived enough that this is tolerable; **refresh tokens are not**, since they exist to be long-lived, so a leaked refresh token with no way to revoke it is a standing grant. This module supplies the missing endpoint for `simple_oauth` (version 3.0.0, core `^10 || ^11`, requiring `drupal/simple_oauth:^6`). A client sends a `POST` to `/oauth/revoke` in `application/x-www-form-urlencoded` form with a `token` field, and authenticates either with its `client_id`/`client_secret` (in the body or via HTTP Basic auth) or with a valid bearer access token. The controller figures out on its own whether the supplied token is an access token (it replays it against the resource server) or a refresh token (it decrypts it with the site hash-salt-derived key), and in **both cases it checks that the token's `client_id` matches the authenticating client before deleting it** — a caller cannot revoke another client's tokens. Revoking a refresh token also revokes the access token issued alongside it, so logout is complete rather than partial. The route is declared `_access: 'TRUE'` because RFC 7009 requires the endpoint to be publicly reachable — authentication is the controller's job, not the router's — and the endpoint deliberately returns **HTTP 200 even for an unknown or already-revoked token**, so it cannot be used as an oracle to test whether a token exists. The module has no configuration, no permissions, no services file, and no admin UI; enabling it is the entire setup. It also cleans up: a `hook_user_predelete` implementation collects and expires all of a user's tokens when that user account is deleted.

---

- Give a decoupled front end a real logout that invalidates the session server-side.
- Revoke a mobile app's tokens when the user signs out.
- Invalidate a long-lived refresh token that is no longer needed.
- Revoke a token that leaked into a log file or crash report.
- Kill access for a device the user removed from their account.
- Support incident response by revoking a specific compromised token.
- Revoke a partner or third-party integration's access on offboarding.
- Meet an OAuth 2.0 / RFC 7009 conformance requirement for an API program.
- Let a native app end its session cleanly on uninstall.
- Revoke tokens as part of a password-change or credential-rotation flow.
- Cascade-revoke the access token when revoking its parent refresh token.
- Provide the revocation half of a token-lifecycle policy.
- Allow a confidential client to authenticate with Basic auth and revoke its own tokens.
- Allow a client already holding a valid bearer token to revoke tokens without resending credentials.
- Complete a `simple_oauth` provider deployment with the standard revoke endpoint.
- Ensure no token-existence oracle by always returning 200.
- Automatically expire a user's tokens when the user account is deleted.
- Support standards-compliant OAuth clients that call `/oauth/revoke` by default.
- Reduce the blast radius of a stolen credential to the time until revocation, not the time until expiry.
- Revoke access after a user changes or loses trust in a connected application.
