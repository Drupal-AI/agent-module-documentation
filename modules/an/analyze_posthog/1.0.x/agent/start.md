<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze PostHog (analyze_posthog) — agent index

An **Analyze provider plugin** that shows **PostHog** web analytics (pageviews, visitors,
sessions, bounce rate, avg time, optional conversions) on each entity's Analyze tab and in a
sitewide report, pulled live from PostHog's **HogQL query API**. Package `Analyze`. Core
`^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.0-beta2.

- **Config object, settings form, keys & permissions, conversion goals** →
  [config/settings.md](config/settings.md)
- **The `posthog_analytics` Analyze plugin, the sitewide report, filter form & rendering** →
  [plugins/analyze.md](plugins/analyze.md)
- **The `PostHogClient` HogQL service (metrics, dimensions, conversions, cache)** →
  [api/client.md](api/client.md)
- **Drush commands** → [api/drush.md](api/drush.md)

## Dependencies

- Requires contrib **`analyze`** (`>=1.1.0`) and **`key`** (Key module, for the API key). No
  other Composer requirements; **`drush/drush`** `^12 || ^13` is only *suggested* (commands work
  without it, but the class needs Drush loaded).

## What it provides (from source)

- **One Analyze plugin**: `Drupal\analyze_posthog\Plugin\Analyze\PostHog` (id
  **`posthog_analytics`**, label *"PostHog Analytics"*), extends `analyze\AnalyzePluginBase`.
  Renders `renderSummary()` (KPI rows) and `renderFullReport()` (filters + KPI + dimension table)
  for any entity whose `toUrl()` resolves. Access gated by permission `access posthog analytics`.
- **Two routes** (`analyze_posthog.routing.yml`):
  - `analyze_posthog.settings` → `/admin/config/analyze/posthog` (form
    `PostHogSettingsForm`, permission **`administer analyze settings`**) — the `configure` route.
  - `analyze_posthog.report` → `/admin/reports/posthog` (controller
    `ReportController::report`, permission **`access posthog analytics`**).
- **One permission** (`analyze_posthog.permissions.yml`): `access posthog analytics`.
  (`administer analyze settings` is defined by the **analyze** module, not here.)
- **Two services** (`analyze_posthog.services.yml`): `analyze_posthog.client`
  (`Service\PostHogClient`) and `analyze_posthog.report_builder` (`Service\ReportBuilder`).
- **Two forms**: `PostHogSettingsForm` (ConfigForm) and `ReportFilterForm` (GET exposed-filter
  bar, reused by both the sitewide and entity reports).
- **Five Drush commands** (`Drush\Commands\PostHogCommands`): `analyze:posthog:status`,
  `:query`, `:report`, `:cache-clear`, `:goals`.
- **Config**: object `analyze_posthog.settings` (schema in `config/schema/`, install defaults in
  `config/install/`). One library `analyze_posthog/report` (CSS only). Menu links under
  *Reports* and *AI → settings*; local tasks on the settings page. `hook_install` warns to
  configure; `hook_uninstall` deletes the config object.

## Not present

No entities, no field types/widgets/formatters, no new plugin type, no submodules, no JS, no
cron. All data is read-only from PostHog; the module never writes to PostHog or to Drupal
content.
