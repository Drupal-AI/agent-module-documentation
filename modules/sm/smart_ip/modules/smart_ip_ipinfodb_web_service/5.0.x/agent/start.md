<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart IP IPInfoDB web service — agent index

A Smart IP **data source** submodule. Geolocates a visitor's IP by calling the IPInfoDB.com web
service — no local database, one HTTP lookup per query, needs an API key. Depends on `smart_ip`.

- **Activate it, the settings keys, the source-selection config, endpoints & versions** →
  [configure/data-source.md](configure/data-source.md)

Key facts:
- Registers the Smart IP data source id **`ipinfodb_web_service`** via an event subscriber
  `Drupal\smart_ip_ipinfodb_web_service\EventSubscriber\SmartIpEventSubscriber` extending the
  parent's `SmartIpEventSubscriberBase` (`sourceId()` / `configName()`).
- **To make it the active source, set `smart_ip.settings:data_source` to `ipinfodb_web_service`.**
- Own settings live in config object **`smart_ip_ipinfodb_web_service.settings`**:
  `version` (integer `2` or `3`, default `3`) and `api_key` (required; validation blocks selecting
  the source without one).
- Endpoints: `IpinfodbWebService::V2_URL` (`.../v2/ip_query.php`) / `V3_URL` (`.../v3/ip-city`).
  Version 2 returns a region code; version 3 dropped it.
- No permissions, no Drush, no plugins. Provides config schema. `configure` route: `smart_ip.settings`.
- Shared machinery (the data-source interface, Smart IP settings) is in the parent:
  [../../../../5.0.x/agent/start.md](../../../../5.0.x/agent/start.md).
