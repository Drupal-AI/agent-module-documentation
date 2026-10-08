<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Communico Plus (communico_plus) — agent index

**Imports Communico library events into `event_page` nodes via a queue and renders event/reservation pages.**

- **Version:** 1.0.x (1.0.0-beta17)
- **Core:** ^10.3 || ^11 || ^12
- **Depends:** queue_ui.
- **Admin routes:** `/admin/config/communico_plus/api` and `/admin/config/communico_plus/import` (`administer communico_plus`).
- **Public routes:** `/event/{eventId}` and `/registration/{registrationId}` (`access content`).
- **Services:** `communico_plus.connector` (Communico v3 REST client, key/secret → OAuth token cached in state, Guzzle default TLS), `communico_plus.utilities`.
- **Queues:** `CommunicoEventSyncQueue`, `CommunicoEventDeleteQueue`. Installs the `event_page` node type + `field_communico_*` fields.
- **Security:** Guzzle verifies TLS by default; feed cache `unserialize()` uses `allowed_classes => FALSE`.

See [configure/setup.md](configure/setup.md).
