<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Communico Plus

1. Enable `communico_plus` (and its `queue_ui` dependency). Installing creates the `event_page` node type and `field_communico_*` fields.
2. **API config** — `/admin/config/communico_plus/api` (`CommunicoPlusConfigForm`): set the Communico API `url`, the public `linkurl`, `access_key` and `secret_key`. The connector builds a Basic auth header `base64(key:secret)` to request a client-credentials token from `/v3/token`, cached in state with its expiry.
3. **Import** — `/admin/config/communico_plus/import` (`CommunicoPlusImportConfigForm`) enqueues events; `CommunicoEventSyncQueue` creates/updates `event_page` nodes and `CommunicoEventDeleteQueue` removes stale ones. Run the queues on cron or through the Queue UI.
4. Place the events block and use `/event/{eventId}` for detail pages.

Connector methods (`ConnectorService`): `getEvent`, `getEventsFeed`/`getFeed` (5-minute state cache), `getReservation`, `getAllReservations`, `getAllRoomNames`, `getLibraryLocations`, `getEventTypes`, `getEventAgeGroups`. All use `http_client` with default TLS verification and bearer token from state.
