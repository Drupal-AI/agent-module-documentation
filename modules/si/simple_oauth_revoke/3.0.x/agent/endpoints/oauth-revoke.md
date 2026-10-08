<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Endpoint: `POST /oauth/revoke` (RFC 7009)

Route `simple_oauth_revoke.revoke` → `Oauth2Revoke::revoke()`. `methods: [POST]`,
`_access: 'TRUE'`, `no_cache: TRUE`. Content type `application/x-www-form-urlencoded`.

## Request parameters

| Field           | Where                          | Required | Notes |
|-----------------|--------------------------------|----------|-------|
| `token`         | body                           | yes      | The access token OR refresh token string to revoke. |
| `client_id`     | body, or Basic-auth username   | see auth | Identifies the authenticating client (Consumer). |
| `client_secret` | body, or Basic-auth password   | see auth | Must match for confidential clients. |

Note: RFC 7009's optional `token_type_hint` is **not used** — the controller auto-detects the type
by trying the token as an access token first, then as a refresh token.

## Authentication (one of)

1. **HTTP Basic** — `client_id` as username, `client_secret` as password.
2. **Body credentials** — `client_id` / `client_secret` form fields. (Basic is tried first; if its
   username is empty or unknown, the body is used.)
3. **Bearer access token** — send a valid `Authorization: Bearer <access_token>` for the request
   itself; the endpoint uses that token's Consumer as the authenticating client, so no explicit
   `client_id`/`client_secret` is needed.

The authenticated client must be the client that issued the token in the body — the controller
compares the body token's `client_id` to the authenticating consumer's client id and rejects a
mismatch. A confidential client with a wrong/absent secret gets `invalid_client`.

## Responses

| Situation                                   | HTTP | Body |
|---------------------------------------------|------|------|
| Token revoked (access or refresh)           | 200  | empty |
| Unknown / already-revoked / malformed token | 200  | empty (deliberate — no existence oracle) |
| Missing `token` field                       | 400  | `invalid_request` OAuth error |
| Bad or unresolvable client credentials      | 401  | `invalid_client` OAuth error |
| Body token issued to a different client     | 400  | `invalid_request` ("Mismatched client ID") |

Revoking a **refresh** token also revokes its associated access token; revoking an **access** token
revokes only that access token.

## Examples

Revoke with client credentials in the body:

```bash
curl --location 'https://example.com/oauth/revoke' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'token=<access or refresh token>' \
  --data-urlencode 'client_id=<client id>' \
  --data-urlencode 'client_secret=<client secret>'
```

Revoke with HTTP Basic auth:

```bash
curl --location 'https://example.com/oauth/revoke' \
  --user '<client id>:<client secret>' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'token=<access or refresh token>'
```

Revoke authorizing with the caller's own bearer token (no explicit client credentials):

```bash
curl --location 'https://example.com/oauth/revoke' \
  --header 'Authorization: Bearer <a valid access token for the same client>' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'token=<access or refresh token to revoke>'
```
