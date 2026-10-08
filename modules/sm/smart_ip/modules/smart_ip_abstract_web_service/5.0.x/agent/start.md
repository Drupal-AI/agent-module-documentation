<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart IP Abstract IP Geolocation web service — agent index

A Smart IP **data source** submodule. Geolocates a visitor's IP by calling Abstract's hosted
IP Geolocation API (abstractapi.com) — no local database, one HTTPS lookup per query, needs an
API key. "Abstract" is the vendor name, not an abstract base class. Depends on `smart_ip`.

- **Activate it, the settings keys, the source-selection config, endpoint & response mapping** →
  [configure/data-source.md](configure/data-source.md)

Key facts:
- Registers the Smart IP data source id **`abstract_web_service`** via an event subscriber
  `Drupal\smart_ip_abstract_web_service\EventSubscriber\SmartIpEventSubscriber` extending the
  parent's `SmartIpEventSubscriberBase` (`sourceId()` / `configName()`).
- **To make it the active source, set `smart_ip.settings:data_source` to `abstract_web_service`.**
- Own settings live in config object **`smart_ip_abstract_web_service.settings`**:
  `version` (integer, only `1`) and `api_key` (required; validation blocks selecting the source
  without one).
- Endpoint: `AbstractWebService::V1_URL` = `https://ipgeolocation.abstractapi.com/v1/`.
- No permissions, no Drush, no plugins. Provides config schema. `configure` route: `smart_ip.settings`.
- Shared machinery (the data-source interface every source implements, Smart IP settings) is in the
  parent: [../../../../5.0.x/agent/start.md](../../../../5.0.x/agent/start.md).
