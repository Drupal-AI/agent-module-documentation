<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Campaign Monitor REST Client (campaign_monitor_rest_client) — agent index

A developer-only module that provides **one container service**, `campaign_monitor_rest_client`,
a Guzzle-compatible HTTP client pre-configured for the **Campaign Monitor / createsend v3.2 REST
API**. Package `Development`. No dependent Drupal modules; requires the Composer library
`ilrwebservices/campaign-monitor-rest-api-client:^1.0.0`. Core `^8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.3 (doc dir `1.x`).

- **The service, factory, client config and how to call the API** → [api/service.md](api/service.md)
- **Settings form, config object and enable/disable behavior** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- **Service** `campaign_monitor_rest_client` (`*.services.yml`): class
  `CampaignMonitor\CampaignMonitorRestClient`, built by the factory method
  `campaign_monitor_rest_client_factory:fromOptions`.
- **Factory** `CampaignMonitorRestClientFactory` (`src/Http/CampaignMonitorRestClientFactory.php`),
  args `@http_handler_stack`, `@config.factory`. Reads config `campaign_monitor_rest_client.settings`.
- **Disabled stub** `CampaignMonitorRestClientDisabled` (`src/Http/CampaignMonitorRestClientDisabled.php`)
  extends the client and overrides `requestAsync()` to `throw new \Exception('… is disabled.')`.
- **Vendored client** `CampaignMonitor\CampaignMonitorRestClient` (in
  `vendor/ilrwebservices/campaign-monitor-rest-api-client/`) extends `GuzzleHttp\Client`; sets the
  `Authorization` header, defaults `base_uri` to `https://api.createsend.com/api/v3.2/`, and pushes
  a `Middleware::mapResponse` that wraps responses in `Psr7\DataAwareResponse` (auto JSON decode).
- **Settings form** `CampaignMonitorRestClientSettingsForm` (`src/Form/…`), form id
  `campaign_monitor_rest_client_settings`, editing config `campaign_monitor_rest_client.settings`.
- **Route** `campaign_monitor_rest_client.config` → `/admin/config/services/campaign_monitor_rest_client`,
  requirement `_permission: 'administer site configuration'`, `_admin_route: TRUE`. Menu link under
  *Configuration → Web services* (`*.links.menu.yml`, parent `system.admin_config_services`).

## Provides / does NOT provide

- Provides: 2 services (client + factory), 1 admin form/route, 1 menu link, 1 config object.
- No entities, no fields, no plugins, no permissions of its own, no Drush commands, no hooks,
  no `config/install` defaults and **no `config/schema`** (config object has no schema file on disk).
