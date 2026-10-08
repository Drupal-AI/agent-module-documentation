<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — token access

## What enabling does
`EventSubscriber\RouteAlterSubscriber` rewrites the `prometheus_exporter.metrics` route requirements to
`{_prometheus_token_access: 'true'}`, **replacing** the original `_permission: access prometheus metrics`.
Access is then decided by `TokenAccessCheck::access()`:
1. If the current user has `access prometheus metrics` → allowed (no flood check).
2. Else read `access_token` from config. **If it is empty/NULL → `AccessResult::allowed()` for everyone.**
3. Else extract the request token; if present, apply flood control then compare to the configured token.
   Match → allowed; mismatch → register a flood event.

## Config object `prometheus_exporter_token_access.settings`
| Key | Default | Meaning |
|---|---|---|
| `access_token` | `''` (empty) | The accepted token. Empty means "no token configured" → open to every request. |
| `flood_limit` | `50` | Max failed token attempts per IP per window before 403. |
| `flood_window` | `3600` | Flood window in seconds. |

Set the token out of config (recommended, keeps it out of exports):
```php
// settings.php
$config['prometheus_exporter_token_access.settings']['access_token'] = 'a-long-random-secret';
```

## Token sources (checked in order, `extractToken()`)
1. Query string: `/metrics?token=<secret>`
2. `Authorization: Bearer <secret>` header

```bash
curl -s 'https://site/metrics?token=SECRET'
curl -s -H 'Authorization: Bearer SECRET' https://site/metrics
```

Always set a non-empty `access_token` before (or immediately after) enabling this submodule on a
production site, or `/metrics` is reachable by anyone.
