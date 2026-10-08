<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expose Status Report (expose_status) — agent index

**Publishes the site status report as token-protected JSON at `/admin/reports/status/expose/{token}`.**

- **Version:** 5.0.x
- **Core:** ^10 || ^11 (php 8.x)
- **Route:** `expose_status.status` — `_custom_access` = `ExposeStatusController::access` (token match).
- **Token:** `Crypt::hashBase64(random_bytes(128))`, stored in state; obtain via `drush ev "expose_status_instructions()"`.
- **Service:** `expose_status`; plugin manager `plugin.manager.expose_status` (plugin type `ExposeStatusPlugin`).
- **Submodules:** expose_status_details (full details), expose_status_ignore (`?ignore=`,`?ignore_negate=1`), expose_status_severity (`?only_above_level=1`), expose_status_selftest.
- **Default:** exposes only ok/issues verdict; details are opt-in.

**Security:** forbid-by-default; access requires the strong random token, else 403. Details hidden unless the details submodule is enabled. Minor: token check uses `==` not `hash_equals` (negligible timing side-channel given 128-byte secret). No mutation endpoints.

See [api/json-endpoint.md](api/json-endpoint.md).
