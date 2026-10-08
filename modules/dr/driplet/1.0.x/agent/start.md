<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Driplet (driplet) — agent index

WebSocket-based real-time notifications. Drupal is a thin integration layer over the external
**Driplet** Go microservice and the `make0x20/driplet` PHP library (`composer require drupal/driplet`
pulls it in). Backend code builds+sends messages; the browser opens a WebSocket and receives them.
Package `Driplet`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2.

## What it provides

- **Config object** `driplet.settings` (no config schema shipped). Settings form
  `DripletSettingsForm` at **`/admin/config/services/driplet`** (route `driplet.settings`, menu under
  *Configuration → Web services*), permission **`administer driplet`** (the only permission,
  `restrict access: TRUE`).
- **Services** (`driplet.services.yml`): `driplet.service` (`DripletService`) and
  `driplet.jwt_manager` (`JWTManager`), both constructed from `@config.factory`.
- **Route** `driplet.jwt` → `DripletController::generateJwt` at **`/api/driplet/jwt`**
  (`_access: 'TRUE'`, `no_cache: TRUE`) — returns a short-lived HS256 JWT for the current user.
- **Library** `driplet/driplet` (`js/driplet-client.js` → `window.DripletClient`), attached by
  `hook_page_attachments()` only when `driplet_websocket_host` is set.
- **Submodules** `driplet_log` and `driplet_notify` (documented in their own nested trees under
  `modules/`).

## Solution docs

- **Settings form, `driplet.settings` config keys, routes, permission, menu, page attachments** →
  [config/settings.md](config/settings.md)
- **`driplet.service` (DripletService), the JWTManager + `/api/driplet/jwt` controller, the
  MessageBuilder targeting model, the vendor client, and the `DripletClient` JS** →
  [api/messaging.md](api/messaging.md)

## Submodules

- **driplet_log** — real-time dblog viewer at `/admin/reports/driplet-log`
  (`modules/driplet_log/1.0.x/`).
- **driplet_notify** — toast notifications on node CRUD + cache rebuild
  (`modules/driplet_notify/1.0.x/`).
