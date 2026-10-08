<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# New Relic RPM — agent index

Connects Drupal to New Relic APM. Names/ignores/backgrounds transactions, forwards
errors and slow-view Insights events, and marks deployments. All settings live in the
`new_relic_rpm.settings` config object; UI at `/admin/config/development/new-relic`
(route `new_relic_rpm.settings`). No plugins. Works safely without the `newrelic` PHP
extension (a `NullAdapter` no-ops every call).

- **Every setting key, defaults, transaction-state values, region, `drush config:set` recipes** →
  [configure/settings.md](configure/settings.md)
- **Drush: mark deployments (`nrd`) + the per-command tracking hook** →
  [drush/deploy.md](drush/deploy.md)
- **Services to call from code: the adapter, the API client, the NullAdapter fallback** →
  [api/adapter.md](api/adapter.md)

Key facts:
- Config object: `new_relic_rpm.settings` (15 keys). No config entity.
- Two permissions: `administer new relic rpm`, `create new relic rpm deployments`.
- Transaction-state string values: `norm` (normal), `bg` (background), `ignore`.
- Deployment markers use REST API v2 + `api_key`; APM transaction control uses the PHP extension.
- REST base URL is chosen by the `region` key (`us` → `https://api.newrelic.com/v2/`,
  `eu` → `https://api.eu.newrelic.com/v2/`); both endpoints are fixed and hard-coded.

## Diff 2.2.x → 2.3.x

- **New `region` config key** (`us` / `eu`, default `us`) and a **Region** select on the
  settings form. It selects which fixed New Relic data-center endpoint the REST client uses;
  EU accounts need `eu`. Added to `config/schema` with a `Choice` constraint (`us`, `eu`).
- **`NewRelicApiClient::getApiBaseUrl()` + static `getRegions()`** added; the base URL is now
  region-derived instead of the constant. The `API_URL` constant
  (`https://api.newrelic.com/v2`) is **deprecated in 2.3.0, removed in 3.0.0**.
- **New post-update** `new_relic_rpm_post_update_config_region()` backfills `region = 'us'`
  on existing sites.
- **Settings form** now injects `entity_type.manager` (used to build the *Ignore roles*
  options). No behavior change to existing keys.
- Config-object key count 14 → 15 (adds `region`).
