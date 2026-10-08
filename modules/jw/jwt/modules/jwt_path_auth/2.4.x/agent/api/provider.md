<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The path-auth provider & token contract

Service `jwt_path_auth.authentication.jwt` (`JwtPathAuth`), tagged `authentication_provider`
with `provider_id: jwt_path_auth`, `global: TRUE`, `priority: 50`.

## When it applies

`applies()` returns TRUE only when **both**:
1. the request has a non-empty `jwt` query parameter (`?jwt=<token>`), and
2. the request path starts with one of `jwt_path_auth.config` `allowed_path_prefixes`.

Otherwise the provider is skipped entirely.

## What the token must contain

The token is decoded/verified with the site-wide key via `jwt.transcoder` (same key as the
header-based `jwt_auth`). It must carry these nested claims:

| Claim | Purpose |
|---|---|
| `drupal.path_auth.uid` | The user id to authenticate as. |
| `drupal.path_auth.path` | A path prefix the request path must start with. Binds the token to a URL. |

`authenticate()` succeeds only if `uid` and `path` are present **and** the request path
(base URL + path info) begins with the token's `path` claim, and the user exists and is not
blocked. On success it loads that user and calls the page-cache kill switch so the response is
not cached. Any decode failure or mismatch returns NULL (falls through to other providers /
anonymous).

## Building a link

Mint a token (site key) whose payload includes `{"drupal":{"path_auth":{"uid":42,"path":"/system/files/private/report.pdf"}}}`,
add the usual `iat`/`exp`, then link to
`/system/files/private/report.pdf?jwt=<token>`. Because `path` is inside the signed token, a
recipient cannot repoint the link at a different file.
