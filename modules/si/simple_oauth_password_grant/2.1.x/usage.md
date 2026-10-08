Simple OAuth Password Grant adds the OAuth2 **password grant** (resource-owner password credentials) to the Simple OAuth module, so a trusted first-party client can exchange a Drupal username/email + password for an access token.

---

The module registers a single `Oauth2Grant` plugin with id `password` (class
`Drupal\simple_oauth_password_grant\Plugin\Oauth2Grant\Password`) that wraps the PHP League
OAuth2 server's `PasswordGrant`. Once the module is enabled, the **Password** grant becomes
selectable on each Simple OAuth **Consumer** (a `consumer` entity's `grant_types` field). A
client then POSTs `grant_type=password` with `client_id`, `client_secret`, `username` and
`password` to Simple OAuth's token endpoint (`/oauth/token`) and receives an access token (and,
per the consumer's `refresh_token_expiration`, a refresh token). The `username` may be either the
Drupal username **or** the account's email address. Credential checking is done by the module's
own `UserRepository` (`simple_oauth_password_grant.repositories.user`), which reuses Drupal's
`user.auth` service and applies core-style **flood protection**: it enforces `user.flood`
IP-based (`oauth2_password_grant.failed_login_ip`) and per-user (`oauth2_password_grant.failed_login_user`)
limits and throws an `OAuthServerException` (`flood_ip_blocked` / `flood_user_blocked`, HTTP 403)
when a limit is hit. The module also alters the consumer form to move the scopes selector into a
"Default scopes" section. It has no admin settings page of its own (`configure: null`); its only
config schema is `grant_type.password`. The password grant is explicitly discouraged by OAuth2
Best Practices — the README warns it MUST be used only for trusted, secure, first-party apps, and
Authorization Code should be preferred where possible.

---

- Let a trusted first-party SPA or mobile app log a user in with their Drupal username/password and get an OAuth2 access token.
- Enable the OAuth2 `password` grant on a specific Simple OAuth Consumer.
- Obtain a bearer access token via `POST /oauth/token` with `grant_type=password`.
- Authenticate with either the Drupal username or the user's email address in the `username` field.
- Issue refresh tokens alongside access tokens for a decoupled front end (TTL from the consumer's `refresh_token_expiration`).
- Provide a "log in" endpoint for a headless Drupal + JS front end without redirect-based OAuth flows.
- Reuse Drupal's account credentials for API auth instead of a separate identity provider.
- Apply Drupal core flood protection to token requests (IP and per-user failed-login limits).
- Return standardized OAuth error responses when the login floods (403 `flood_ip_blocked` / `flood_user_blocked`).
- Restrict a consumer's default scopes via the relocated "Default scopes" section on the consumer form.
- Migrate a legacy password-based login to OAuth2 tokens for trusted clients.
- Power a native mobile app's sign-in screen against a Drupal backend.
- Combine with Simple OAuth scopes/roles to gate API access after password login.
- Grant tokens for automated first-party integrations that hold a user's credentials securely.
- Support username-or-email login UX in a decoupled app through one token request.
- Test token issuance locally by requesting a password-grant token with curl/Postman.
- Rotate access by relying on short-lived access tokens plus refresh tokens for the client.
- Provide a fallback auth mechanism for trusted clients that cannot use the Authorization Code + PKCE flow.
- Enforce that only active (status = 1) accounts can obtain tokens (inactive users are rejected).
- Keep credential verification server-side using Drupal's `user.auth` service.
