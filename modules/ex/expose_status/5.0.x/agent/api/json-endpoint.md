<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expose Status JSON endpoint

## URL
```
/admin/reports/status/expose/{token}
```
`{token}` must equal the site token (`ExposeStatusController::access` → `expose_status.token()`), else **403**.

Get the token (never shown in the UI, only `*****`):
```
drush ev "expose_status_instructions()"   # prints example URLs with the real token
drush ev "expose_status_token()"           # prints just the token
```

## Response
```json
{"status":"issues found; please check","generated":"2019-12-04 17:36:02"}
```
`status` is `ok` unless any `hook_requirements` line has `severity > 0`. Responses are `max-age:0` with a
`url` cache context and the `expose-status-security-token-has-changed` cache tag (so rotating the token
never serves stale data).

## Query parameters (require the matching submodule)
| Param | Submodule | Effect |
|-------|-----------|--------|
| `?ignore=key1,key2` | expose_status_ignore | Skip named checks (use the details submodule first to discover keys). |
| `?ignore_negate=1` | expose_status_ignore | Invert: ignore everything **except** the listed keys. |
| `?only_above_level=1` | expose_status_severity | Only errors (level 2) trigger issues, not warnings. |
| (details in body) | expose_status_details | Include full requirement details — enable only when needed; can leak sensitive data. |

Submodules can be combined. Extend further with an `ExposeStatusPlugin` plugin
(`plugin.manager.expose_status`); the three submodules are the reference implementations.
