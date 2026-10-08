<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tether Stats (tether_stats) — agent index

Self-hosted site statistics for **hits, clicks and impressions**, stored in local Drupal tables (no
third-party analytics). A page-request event subscriber maps each front-end request to a **stats
element** (a row in `tether_stats_element` keyed by URL, entity, or a custom name), creating the row
on the fly and attaching the element id to `drupalSettings`. The bundled JS (`js/tether_stats.js`)
then fires an AJAX "hit" to the tracking route `/tether-stats/track`, which writes an activity row
and increments per-hour counters. Admins view the data as **overview pages** with Google-Charts combo
and pie charts (iterated over time via a private-tempstore chart schema and an AJAX chart-data
route), a top-hits table, an element finder, and a Views integration. **Derivatives** (a config
entity) let you attach several independent counters to one entity or page.

Data model: `tether_stats_element` (one per tracked thing) → `tether_stats_activity_log` (one per
hit/click/impression) → `tether_stats_impression_log` (impressions tied to an activity), with
`tether_stats_hour_count` holding pre-aggregated per-hour/day/month/year counts for fast reporting.
Collection is **off by default** (`active: false`); an admin turns it on at the settings page.

- Depends on: nothing beyond core (`test_dependencies: php`). Integrates with `views` (optional) and
  `node` (special-cased in the request→element subscriber).
- Core: `^10 || ^11`. Package: `Statistics`.
- Settings page / `configure`: **yes** — route `tether_stats.settings_form`
  (`/admin/config/system/tether-stats`).
- Permissions: **yes** — `administer tether stats`, `view tether stats chart data`.
- Drush: none. Config schema: yes. Config entity: `tether_stats_derivative`.
- Plugin type: **`TetherStatsChartRenderer`** (manager `plugin.manager.tether_stats.chart_renderer`);
  one bundled plugin, `tether_stats_google_charts`.
- Events: `TetherStatsEvents::REQUEST_TO_ELEMENT` (`tether_stats.request_to_element`).
- Hook: `hook_tether_stats_track_custom_data()`.

## What you'd do → where

- **Turn tracking on, filter which pages/roles are tracked, set element TTL / alternate DB** →
  [configure/settings.md](configure/settings.md)
- **Understand the end-to-end tracking flow, the `/tether-stats/track` query params, identity sets,
  the DB tables, and the custom-data hook** → [api/tracking.md](api/tracking.md)
- **Call the manager / storage / analytics services from code; build/iterate charts** →
  [api/services.md](api/services.md)
- **Add a chart renderer for another chart library (plugin type)** →
  [plugins/chart-renderer.md](plugins/chart-renderer.md)
- **Grant/limit who can administer or view chart data (route gating)** →
  [permissions/permissions.md](permissions/permissions.md)
- **Report on the raw stats tables in Views** → [views/views.md](views/views.md)

## Key facts (real machine names)

- Routes: `tether_stats.settings_form` (`/admin/config/system/tether-stats`), `tether_stats.overview`
  (`.../overview`), `tether_stats.overview.element` (`.../overview/element`),
  `tether_stats.element_finder_form` (`.../elements`), `tether_stats.activity_purge_form`
  (`.../purge`), `tether_stats.activity_purge_confirm_form` (`.../purge-before/{purge_before_date}`),
  `entity.tether_stats_derivative.{collection,add_form,delete_form,enable,disable}` (`.../derivatives…`),
  `tether_stats.derivative.autocomplete` (`/tether_stats/autocomplete`), `tether_stats.track`
  (`/tether-stats/track`), `tether_stats.chart.data` (`/tether-stats/chart-data`).
- Services: `tether_stats.manager` (`TetherStatsManager`), `plugin.manager.tether_stats.chart_renderer`,
  `logger.channel.tether_stats`, `tether_stats.request_subscriber` (`TetherStatsRequestSubscriber`),
  `tether_stats.request_to_element_subscriber` (`TetherStatsRequestToElementSubscriber`).
- Controllers: `TetherStatsTrackController::track`, `TetherStatsChartController::iterate`,
  `TetherStatsOverviewController::{overviewPage,elementOverviewPage}`,
  `TetherStatsAutocompleteController::derivativeAutocomplete`.
- Config object: `tether_stats.settings` (keys: `active`, `allow_query_string_elements`,
  `filter.mode`, `filter.rules.route`, `filter.rules.url`, `exclude_roles`, `database`,
  `chart_plugin`, `advanced.element_ttl`, `advanced.first_activation_time`).
- Config entity: `tether_stats_derivative` (config prefix `tether_stats.derivative.*`; keys `name`,
  `status`, `description`, `derivativeEntityType`, `derivativeBundle`).
- Tables: `tether_stats_element`, `tether_stats_activity_log`, `tether_stats_hour_count`,
  `tether_stats_impression_log`.
- Activity types: `hit`, `click`, `impression` (`TetherStatsAnalytics::ACTIVITY_*`); domain steps
  `hour`/`day`/`month`/`year` (`STEP_*`).
- Plugin type: annotation `Drupal\tether_stats\Annotation\TetherStatsChartRenderer`, interface
  `TetherStatsChartRendererInterface`, dir `Plugin/tether_stats/Chart`, bundled id
  `tether_stats_google_charts`.
- Libraries: `tether_stats/tether_stats.corescripts`, `…/tether_stats.chart`,
  `…/tether_stats.chart.google`, `…/tether_stats.chart.google.api`.
- Theme hooks: `tether_stats_overview_page`, `tether_stats_element_overview_page`,
  `tether_stats_chart_google`. Hooks implemented: `hook_help`, `hook_theme`,
  `hook_page_attachments`, `hook_views_data`, `hook_views_data_alter`, `hook_requirements`,
  `hook_schema`.
