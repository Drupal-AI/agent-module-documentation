<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `/oauth2/token` endpoint and the per-user management UI

## Token endpoint

Route `jwt_oauth_ccf.token` — `POST /oauth2/token`, `_access: 'TRUE'` (anonymous; the
credentials in the request body are the auth), `options.no_cache: TRUE`.

Request (form-encoded body, or an HTTP Basic `Authorization` header carrying
`client_id:client_secret` instead of body fields):

```
POST /oauth2/token
Content-Type: application/x-www-form-urlencoded

grant_type=client_credentials&client_id=<id>&client_secret=<secret>
```

Success response (`Cache-Control: no-store`, `Pragma: no-cache`):

```json
{ "access_token": "<jwt>", "token_type": "Bearer", "expires_in": 3600 }
```

Error response, RFC 6749 §5.2 shape:

```json
{ "error": "invalid_client", "error_description": "Client authentication failed." }
```

| `error` | Cause | HTTP status |
|---|---|---|
| `unsupported_grant_type` | `grant_type` isn't `client_credentials` | 400 |
| `invalid_request` | missing `client_id`/`client_secret` | 400 |
| `invalid_client` | too many failed attempts (flood), unknown client/bad secret, or blocked user | 429 / 401 |
| `server_error` | no JWT signing key configured (`jwt.transcoder` returned empty) | 500 |

**Flood control**: keyed by `client_id . '::' . <source IP>`, `jwt_oauth_ccf.failed_token`
bucket, threshold **20 failed attempts / 3600 seconds** (`TokenController::FLOOD_THRESHOLD` /
`FLOOD_WINDOW`); a successful auth clears the bucket for that identifier.

**Token contents**: built directly, not via the JWT `GENERATE` event —
`iat`, `exp = iat + 3600` (`TokenController::TOKEN_LIFETIME`, not configurable), and
`drupal.uid` set to the credential owner's uid. It validates via the same global `jwt_auth`
provider (from the main `jwt`/`jwt_auth_consumer` modules) as any other site JWT.

## Per-user management UI

| Route | Path | Form/Controller |
|---|---|---|
| `jwt_oauth_ccf.client_list` | `/user/{user}/oauth-clients` | `ClientListController::listClients` |
| `jwt_oauth_ccf.client_generate` | `/user/{user}/oauth-clients/generate` | `GenerateClientForm` |
| `jwt_oauth_ccf.client_delete` | `/user/{user}/oauth-clients/{client_id}/delete` | `ClientDeleteForm` |

All three routes require `_jwt_oauth_ccf_manage_access: 'TRUE'`, checked by service
`jwt_oauth_ccf.access_checker` (class `Drupal\jwt_oauth_ccf\Access\ManageClientsAccessCheck`,
tagged `access_check` / `applies_to: _jwt_oauth_ccf_manage_access`). See
[permissions/permissions.md](../permissions/permissions.md) for what grants access.

Generating a credential: non-admins get an auto-generated `client_id` and may optionally
supply their own secret (≥ 16 chars) or accept an auto-generated one; only holders of
`administer oauth client credentials` may set a custom `client_id`. When a secret is
auto-generated, the response streams a one-time `.txt` file containing the client_id,
secret, the token endpoint URL, and a ready-to-run `curl` example — it cannot be retrieved
again afterward.

## Scriptable equivalent (bypassing the UI)

```php
// Create a credential the same way GenerateClientForm does, without the HTTP round-trip:
\Drupal::service('jwt_oauth_ccf.client_repository')->createClient(1, 'my label', NULL, 'my_client_id');
```

Actually exchanging that credential for a token still goes through the real
`POST /oauth2/token` endpoint (it depends on the site's `jwt` signing-key configuration,
which this document intentionally does not cover — see the main `jwt` module's own docs).
