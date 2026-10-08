<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lawwwing (project lawwwinginsert; module machine name `lawwwing`) — agent index

**Attaches the Lawwwing cookie-consent CDN script to `<head>`, with per-role and admin-page targeting.**

- **Version:** 1.0.x (1.0.1) · **Core:** ^10 || ^11 || ^12
- **Enable name:** `drush en lawwwing` (module machine name is `lawwwing`, not the project/dir name `lawwwinginsert`).
- **Configure:** route `lawwwings.settings` → `/admin/config/lawwwing` (perm `administer lawwwing settings`, `restrict access: true`).
- **Mechanism:** `Drupal\lawwwing\Hook\Hooks::insertScript()` on `hook_page_attachments` adds `<script src="https://cdn.lawwwing.com/widgets/current/{script_id}/cookie-widget.min.js">`.
- **Settings:** `script_id`, `active_in_admin`, `allowed_roles`. Cache tag `config:lawwwing.settings`.
- **Security:** admin route permission-gated; no server-side external calls (widget is client-side CDN JS). CSP: allow `cdn.lawwwing.com`. No code findings.

See [configure/settings.md](configure/settings.md)
