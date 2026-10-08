<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Query Auth Params (query_auth_params) — agent index

**Soft-gates specific pages behind a required `?name=value` query parameter, redirecting requests that lack the correct value.**

- **Version:** 1.2.x
- **Core:** ^9 || ^10 || ^11
- **Config route:** `query_auth_params.settings` → `/admin/config/development/query_auth_params` (permission `administer site configuration`)
- **Mechanism:** `QueryAuthParamsSubscriber` on `KernelEvents::CONTROLLER`; matches path/alias, kill-switches page cache, strict-compares the query value, else returns `TrustedRedirectResponse`.
- **Modes:** forever / once (sets a `shown` flag) / datetime_period.

**Security:** admin config route is permission-gated. This is obscurity-based gating, not authorization — the secret rides in the URL query string (exposed in logs, `Referer`, and browser history) and is capped at ≤10 alphanumeric characters (low entropy). Do not use for protecting sensitive content; real access is still governed by the underlying route/entity permissions.

See [configure/query_auth_params.md](configure/query_auth_params.md)
