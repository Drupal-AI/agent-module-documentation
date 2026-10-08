<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Expose Status Report publishes whether a site's status report is OK or has issues as JSON at a secret token URL, so many sites can be watched from one dashboard.

---

Every Drupal site has `/admin/reports/status`; this module exposes a machine-readable summary of it at
`/admin/reports/status/expose/{token}`, returning e.g. `{"status":"issues found; please check",
"generated":"..."}` (status is `ok` unless any requirement has severity > 0). The URL is protected by a
per-site token — a strong random secret generated with `Crypt::hashBase64(random_bytes(128))`, stored in
state, and matched by a `_custom_access` callback; a wrong/absent token yields 403. Get the token with
`drush ev "expose_status_instructions()"` (or `expose_status_token()`). The status report itself is never
shown in the admin UI as plaintext (only `*****`), and by default **no details** are exposed — only the
overall ok/issues verdict — because status details can be sensitive.

Behaviour is extended through an `expose_status` plugin type and three optional submodules:
**expose_status_details** (include the full requirement details in the JSON — enable only when needed),
**expose_status_ignore** (skip named checks via `?ignore=...`, with `?ignore_negate=1` to invert), and
**expose_status_severity** (`?only_above_level=1` to fail on errors only, not warnings). Responses set
`max-age:0` with a `url` cache context and an `expose-status-security-token-has-changed` cache tag so a
rotated token cannot serve stale data. Security posture is sound: strong token, forbid-by-default access,
details opt-in; the only minor note is that the token comparison uses `==` rather than a constant-time
`hash_equals`, a negligible timing concern given the 128-byte random secret.

---

- Expose a site's health as JSON for an external monitor.
- Return 'ok' or 'issues found; please check' based on requirement severity.
- Protect the endpoint with a strong per-site random token.
- Fetch the token via drush ev "expose_status_instructions()".
- Print just the token via drush ev "expose_status_token()".
- Poll many Drupal sites from one Jenkins/dashboard job.
- Get a 403 for any request with a wrong or missing token.
- Rotate the token and invalidate cached responses automatically.
- Keep details hidden by default to avoid leaking sensitive info.
- Enable expose_status_details to include full requirement details.
- Ignore specific checks with ?ignore=file%20system,update_core.
- Invert the ignore list with ?ignore_negate=1.
- Fail only on errors (not warnings) with ?only_above_level=1.
- Combine ignore, severity and details submodules together.
- Write a custom ExposeStatusPlugin to alter the response.
- Add a health check to CI/CD or uptime tooling.
- Surface 'update available' / trusted-host warnings to ops.
- Serve an uncached (max-age 0) always-fresh status.
- Read hook_requirements results without loading the admin UI.
- Uninstall to delete the stored token from state.
