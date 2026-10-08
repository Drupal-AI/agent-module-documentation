<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Share Websub Hub — agent index

The **publisher** end of Entity Share Websub. Exposes `POST /subscribe`, stores subscriptions
in a DB table, and pushes signed update/cancel notifications to subscribers when content
changes. **No settings form / `configure` route** — behaviour is code + a permission + a View.

- **Services, the `/subscribe` endpoint, the notification/queue flow, the DB table** →
  [api/hub-and-publisher.md](api/hub-and-publisher.md)
- **The `see content subscriptions` permission and the Syndicated content View** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Depends on `entity_share_websub` (base) and `entity_share_server`.
- Reacts via `hook_entity_update` / `hook_entity_delete`; queues to the `entity_share_websub`
  queue; drains it on `kernel.terminate` (no cron).
- Constants (`Hub`): `QUEUE_NAME='entity_share_websub'`, `LEASE_SECONDS=1209600` (14 days),
  `PAUSE_DURATION=3`, `ACTION_CANCEL='cancel'`. Sends `PUT` for updates, `DELETE` for cancels,
  both with an `X-Hub-Signature` header.
- Table: `entity_share_websub_hub_subscription`. Services: `entity_share_websub_hub.hub`,
  `.publisher`, `.subscription`.
