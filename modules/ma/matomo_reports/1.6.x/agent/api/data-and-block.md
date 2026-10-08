<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Report routes, the MatomoData helper & the page-statistics block

## Report pages

Every report page routes to `MatomoReportsController::reports($request, $report)` and each
carries a fixed `report` id in its route defaults. Base path:
`/admin/reports/matomo-reports` (route `matomo_reports.reports`, default
`report: visitors_overview`), permission **`access matomo reports`**. The controller:

1. Gets the token (`MatomoData::getToken()`); warns and bails if none.
2. Lists accessible sites (`MatomoData::getSites()`); warns if none.
3. Builds a filter form (`ReportsForm`) for site + period/date-range (kept in the session:
   `matomo_reports_site`, `matomo_reports_period`, `matomo_reports_date_from/to`).
4. Emits Matomo **`Widgetize` iframe** URLs (`module=Widgetize&action=iframe`) for the report,
   themed via `#theme => 'matomo_reports'`.

Report ids (route default → `report`): `visitors_overview`, `visitors_times`,
`visitors_settings`, `visitors_locations`, `visitors_variables`, `actions_pages`,
`actions_entrypages`, `actions_exitpages`, `actions_sitesearch`, `actions_outlinks`,
`actions_downloads`, `events`, `referrers_allreferrers`, `referrers_search`,
`referrers_websites`, `referrers_campaigns`, `goals`, `transitions`. Period mapping:
Today/Yesterday→day, Last week→week, Last month→month, Last year→year; a from/to range uses
`period=range`.

## `MatomoData` helper (`Drupal\matomo_reports\MatomoData`)

Static utility; all Matomo reads go through it:

- `getToken()` — global token, else current user's `user.data` token, HTML-escaped.
- `getUrl()` — `matomo_server_url`, else the `matomo` module's `matomo.settings`
  (`url_https`/`url_http`) when that module exists; warns if empty.
- `getSites($token_auth)` — POSTs Matomo API `SitesManager.getSitesWithAtLeastViewAccess`.
- `getResponse($url, $options, $method)` — Guzzle request, JSON-decoded; honours the ignore-SSL
  flag; returns FALSE on `RequestException`.

## The "Matomo page statistics" block

Block plugin id **`matomo_page_report`** (`admin_label` "Matomo page statistics"),
class `Plugin\Block\MatomoReportsBlock`. Access = `access matomo reports`. It **requires the
`matomo` module** (uses `matomo.settings` `site_id`); otherwise it renders an "install Matomo"
message. It attaches the `matomo_reports/matomoreports` JS library and passes the Matomo URL +
an `Actions.getPageUrl` API query (for the current path) via `drupalSettings`, rendering into
`<div id="matomopageviews">`. Cache contexts: `user`, `url`. Place it like any block (config
entity `block.block.*`, plugin `matomo_page_report`).

## Theme / help

`hook_theme()` registers `matomo_reports` (`matomo-reports.html.twig`, var `data_url`).
`hook_help()` describes the module on the settings route. No Drush, no plugin types, no
config schema.
