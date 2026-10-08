<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze Search Console (analyze_search_console) — agent index

Google Search Console integration for the **Analyze** framework. Shows per-entity search
performance (clicks, impressions, CTR, average position, with prior-period change) on the Analyze
tab, plus a sitewide report and Drush commands. Package `Analyze`. Version **1.0.0-beta2**.
Core `^10.3 || ^11`. License GPL-2.0-or-later.

- **Depends on:** `analyze:analyze` (>=1.1.0), `key:key`, and the `google/apiclient` Composer
  package (`^2.19`, not auto-installed by every workflow — `composer require google/apiclient`
  if `Google\Client` is missing).
- Provides **1 permission**, **1 config object**, **4 Drush commands**, **1 Analyze plugin**, no
  entities/fields/plugin types of its own.

## Solution docs

- **Configuration, OAuth connect flow, Key credentials, config keys/schema, routes & permission** →
  [config/settings.md](config/settings.md)
- **The `search_console` Analyze plugin (per-entity summary + full report)** →
  [plugins/search_console.md](plugins/search_console.md)
- **`SearchConsoleClient` / `ReportBuilder` services, the sitewide report controller, and Drush
  commands** → [api/client.md](api/client.md)

## What it provides (from source)

- **Analyze plugin** `search_console` — `src/Plugin/Analyze/SearchConsole.php`, extends
  `Drupal\analyze\AnalyzePluginBase`. `renderSummary()` (KPI table) + `renderFullReport()`
  (filters, KPI, dimension table, pager). Access gated by permission
  `access search console reports`.
- **Services** (`analyze_search_console.services.yml`):
  `analyze_search_console.client` = `Service\SearchConsoleClient` (all Google API calls, caching,
  token refresh, property detection); `analyze_search_console.report_builder` =
  `Service\ReportBuilder` (shared render/table logic, no args).
- **Routes** (`analyze_search_console.routing.yml`): `.settings`
  (`/admin/config/analyze/search-console`, `administer analyze settings`), `.oauth_callback`
  (`/…/oauth-callback`, same perm), `.disconnect` (`/…/disconnect`, same perm + `_csrf_token`),
  `.report` (`/admin/reports/search-console`, `access search console reports`).
- **Controllers:** `Controller\OAuthCallbackController` (`callback`, `disconnect`);
  `Controller\ReportController` (sitewide report).
- **Forms:** `Form\SearchConsoleSettingsForm` (config + connect/disconnect UI);
  `Form\ReportFilterForm` (GET exposed-filter bar, reused by entity + sitewide reports).
- **Config object** `analyze_search_console.settings` (schema in `config/schema/`): `client_id`,
  `client_secret` (both **Key entity IDs**, not raw secrets), `property_url`, `base_url_override`,
  `date_range`, `search_type`, `cache_ttl`. The OAuth token lives in **state**
  `analyze_search_console.access_token`, not config.
- **Permission** `access search console reports`. **Drush** `analyze:search-console:status|query|report|cache-clear`
  (`src/Drush/Commands/SearchConsoleCommands.php`). **Library** `analyze_search_console/report`
  (one CSS file). **Menu links** under AI settings and Reports; **local tasks** Settings/Report.
- **Hooks:** `hook_help`, `hook_install` (config warning), `hook_uninstall` (deletes config +
  token state).
