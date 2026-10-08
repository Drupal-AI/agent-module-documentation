<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JWT OAuth Client Credentials lets a Drupal user generate machine-to-machine client credentials (a client ID + one-time secret) that a script or service can exchange at a token endpoint for a short-lived signed JWT acting as that user.

---

Each account can hold one or more OAuth client credentials, managed at `/user/{user}/oauth-clients`: generating a credential creates a globally-unique `client_id`, hashes and stores a secret (auto-generated and shown once, or user-supplied), and streams a one-time plain-text credential file. Credentials live in the core `user.data` store under the module name `jwt_oauth_ccf`, keyed by `client_id`, as a `Drupal\jwt_oauth_ccf\ClientCredential` object with `{uid, clientId, label, secretHash, created}` — only the bcrypt hash is ever persisted. A machine client then `POST`s `grant_type=client_credentials` plus `client_id`/`client_secret` (as form fields or an HTTP Basic header) to `/oauth2/token`; the controller verifies the secret, throttles repeated failures per client+IP via Drupal's flood control, and — on success — builds a 1-hour JWT directly with `jwt.transcoder`, stamping `iat`, `exp`, and `drupal.uid` for the credential's owning account, rather than dispatching the generic JWT `GENERATE` event. The response is a standard RFC 6749 token payload (`access_token`, `token_type: Bearer`, `expires_in: 3600`) with `Cache-Control: no-store`. Two permissions gate the per-user management UI — `manage own oauth client credentials` and the restricted `administer oauth client credentials` — enforced by a dedicated access-check service, while the token endpoint itself is open to anonymous requests (the credentials in the POST body are the authentication). Deleting a credential stops it minting new tokens but does not revoke already-issued ones, since the tokens are stateless JWTs. The module depends on `jwt` (for the transcoder/signing) and core `user`, but not on `jwt_auth_issuer`.

---

- Let a machine/service (CI pipeline, cron job, external integration) obtain a signed JWT without a human logging in.
- Bind an M2M client to a real Drupal "service account" so the issued token inherits that account's roles and permissions.
- Generate client credentials (`client_id` + secret) for a user account from `/user/{user}/oauth-clients`.
- Auto-generate a strong, random client secret and download it exactly once, since only its hash is stored.
- Supply your own client secret instead of an auto-generated one, subject to a minimum length.
- As an administrator, choose a custom, human-readable `client_id` for a credential (regular users get an auto-generated one).
- Exchange `client_id`/`client_secret` for a short-lived (1 hour) JWT at `POST /oauth2/token` using `grant_type=client_credentials`.
- Authenticate to the token endpoint via an HTTP Basic `Authorization` header instead of form body fields.
- Rely on RFC 6749 §5.2-shaped error responses (`invalid_request`, `invalid_client`, `unsupported_grant_type`, `server_error`) for client-side error handling.
- Rate-limit brute-force secret guessing via built-in flood control, keyed per `client_id` + source IP.
- List all of a user's OAuth client credentials, with label, client ID, and creation date.
- Revoke a compromised or retired integration by deleting its credential — new tokens can no longer be minted with it.
- Rotate a credential by deleting the old one and generating a fresh client ID/secret pair.
- Grant `manage own oauth client credentials` so a user can self-service their own integrations without admin help.
- Grant the restricted `administer oauth client credentials` permission to let trusted admins manage credentials on any account.
- Scope a service account tightly (minimal roles) before issuing it client credentials, since the resulting token carries all of that account's permissions.
- Consume the issued token exactly like any other site JWT: `Authorization: Bearer <access_token>` against endpoints already using the `jwt_auth` provider.
- Set up an M2M integration without deploying the heavier `oauth2_server` contrib module and its stateful token storage.
- Programmatically create, look up, or delete credentials via `jwt_oauth_ccf.client_repository` instead of the UI (e.g. in a deployment script).
- Verify a presented secret against a stored credential's hash via `ClientCredentialRepository::verifySecret()`.
- Understand that deleting a credential does not revoke tokens already issued — they remain valid until their `exp` claim expires.
- Serve the token endpoint only over HTTPS, since the client secret and issued JWT are both bearer credentials.
