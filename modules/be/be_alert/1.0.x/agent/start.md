<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BE-Alert (be_alert) — agent index

Integrates the Belgian federal **BE-Alert** emergency service (publicalerts.be CapGateway CAP feed).
Fetches alerts over HTTPS with a per-environment API key and renders them in a block. Version
**1.0.0-alpha1**, core `^10 || ^11`, package `Custom`. No module dependencies (core `http_client`,
`config.factory`, `language_manager`, `logger.factory` only). Unsupported / obsolete on drupal.org.

## What it provides
- **Service** `be_alert.alerts_fetcher` → `Drupal\be_alert\AlertsFetcher::fetchAlerts($environment)`.
  Calls the sandbox or production feed and returns `['map_url' => …, 'alerts' => [items]]`, or `FALSE`
  when the feed has no items. Feed URLs and the `x-api-key` header value are chosen per environment.
- **Block plugin** `be_alert_live` (`Drupal\be_alert\Plugin\Block\LiveBlock`) — "BE-Alert Live". One
  block setting `use_sandbox` (bool) selects the environment. Cache max-age 0 (never cached).
- **Config form** `Drupal\be_alert\Form\GlobalSettingsForm` at route `be_alert.global_settings`
  (`/admin/config/system/be-alert-settings`), permission `administer site configuration`. Menu link
  under System config.
- **Config object** `be_alert.settings` (keys `sandbox.api_key`, `production.api_key`).
- **Theme hook** `be_alert_item` (template `templates/be-alert-item.html.twig`, vars `map_url`, `alert`).

## Solution docs
- [Configuration & API keys](config/settings.md) — settings form, `be_alert.settings`, schema, routes.
- [AlertsFetcher service & Live block](api/alerts-fetcher.md) — feed call, environments, rendering.
