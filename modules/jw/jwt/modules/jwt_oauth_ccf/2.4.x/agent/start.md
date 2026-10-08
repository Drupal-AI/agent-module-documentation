<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JWT OAuth Client Credentials — agent index

Implements the OAuth 2.0 **client credentials** grant (RFC 6749 §4.4) on top of `jwt`: a
Drupal user creates a client credential (client ID + one-time secret) representing a
"service account"; a machine `POST`s that credential to the token endpoint and gets back a
short-lived (1 hour) signed site JWT that authenticates as that user everywhere the `jwt`
stack is already trusted.

- **The credential repository (`jwt_oauth_ccf.client_repository`), the `ClientCredential`
  object, and how credentials live in `user.data`** →
  [api/client-repository.md](api/client-repository.md)
- **The `/oauth2/token` endpoint request/response shape, flood control, and the per-user
  management UI + access check** → [configure/endpoint-and-access.md](configure/endpoint-and-access.md)
- **The two permissions and what each gates** → [permissions/permissions.md](permissions/permissions.md)

Key facts an agent should not have to re-derive from source:

- Credentials are stored in the core `user.data` store, module name `jwt_oauth_ccf`, keyed
  by a globally-unique `client_id` — only a **hash** of the secret is ever persisted.
- The token endpoint (`jwt_oauth_ccf.token`, `POST /oauth2/token`) is anonymous-accessible
  by design — the client_id/client_secret in the request body *are* the authentication.
- Issued tokens are built directly with `jwt.transcoder` (not the JWT `GENERATE` event), so
  this module needs only `jwt` — not `jwt_auth_issuer` — as a dependency.
- Token lifetime is a hard-coded 3600 seconds (`TokenController::TOKEN_LIFETIME`); there is
  no config to change it.
- Deleting a credential stops new tokens; already-issued tokens remain valid until `exp`
  (stateless JWTs — no revocation list).
