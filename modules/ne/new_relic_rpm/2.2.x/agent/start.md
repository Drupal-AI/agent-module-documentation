<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# New Relic RPM — agent index

Connects Drupal to New Relic APM. Names/ignores/backgrounds transactions, forwards
errors and slow-view Insights events, and marks deployments. All settings live in the
`new_relic_rpm.settings` config object; UI at `/admin/config/development/new-relic`
(route `new_relic_rpm.settings`). No plugins. Works safely without the `newrelic` PHP
extension (a `NullAdapter` no-ops every call).

- **Every setting key, defaults, transaction-state values, `drush config:set` recipes** →
  [configure/settings.md](configure/settings.md)
- **Drush: mark deployments (`nrd`) + the per-command tracking hook** →
  [drush/deploy.md](drush/deploy.md)
- **Services to call from code: the adapter, the API client, the NullAdapter fallback** →
  [api/adapter.md](api/adapter.md)

Key facts:
- Config object: `new_relic_rpm.settings` (13 keys). No config entity.
- Two permissions: `administer new relic rpm`, `create new relic rpm deployments`.
- Transaction-state string values: `norm` (normal), `bg` (background), `ignore`.
- Deployment markers use REST API v2 + `api_key`; APM transaction control uses the PHP extension.
