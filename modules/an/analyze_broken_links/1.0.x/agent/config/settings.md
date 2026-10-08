<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, routes & permissions

## Install / enable

`composer require drupal/analyze_broken_links` then enable `analyze_broken_links` (pulls in
`analyze:analyze` >=1.2.0). `hook_install()` (`.install`) creates the two schema tables if absent.
Then enable the `analyze_broken_links_checker` analyzer on the content types you want to monitor via
Analyze's own settings UI (`analyze.settings`, key `status[<entity_type>][<bundle>]`) — the module
reads that config in `hook_cron` and `hook_entity_update`/`delete` to decide which entities apply.

## Config object: `analyze_broken_links.settings`

Editable via `Form\BrokenLinksSettingsForm` (`getEditableConfigNames()`), form id
`analyze_broken_links_settings`. Schema: `config/schema/analyze_broken_links.schema.yml`.
Install defaults: `config/install/analyze_broken_links.settings.yml`.

| Key | Type | Default (install) | Form widget / bounds | Meaning |
|---|---|---|---|---|
| `request_timeout` | integer | `10` | number, min 1 max 60, required | Per-request timeout AND connect_timeout, seconds. |
| `concurrency_limit` | integer | `5` | number, min 1 max 20, required | Max simultaneous requests in the Guzzle `Pool`. |
| `recheck_ttl` | integer | `86400` | select: 21600/43200/86400/172800/604800 | Cache TTL; how long a checked URL is considered fresh, and the cron staleness cutoff. |
| `check_scope` | string | `both` | radios: both/internal/external | Which links to check (see `LinkExtractorService::matchesScope()`). |
| `excluded_patterns` | sequence(string) | `mailto:*`, `tel:*`, `javascript:*`, `#*` | textarea, one per line, `*` wildcard | URLs matching are skipped. |
| `user_agent` | string | `DrupalAnalyzeBrokenLinks/1.0` | textfield (Advanced), required | User-Agent header on checks. |
| `broken_status_codes` | sequence(integer) | `404,410,500,502,503,521,522,523` | checkboxes from `[400,403,404,410,500,502,503,521,522,523]` | Codes flagged as "broken" in gauges, reports, and `hook_requirements`. |

Note: the install default for `broken_status_codes` includes 521/522/523; several code paths use a
narrower **fallback** of `[404,410,500,502,503]` only when the config value is empty (via `?:`).

`submitForm()` writes all keys, coerces types, filters empty exclusion lines, then calls
`BrokenLinksStorageService::invalidateConfigCache()` which **truncates**
`analyze_broken_links_entity_urls` (entity→URL mappings) so links get re-extracted under the new
rules; the raw per-URL check results in `analyze_broken_links_urls` are kept.

## Routes

| Route | Path | Access | Provided by |
|---|---|---|---|
| `analyze_broken_links.settings` | `/admin/config/analyze/broken-links` | `_permission: administer analyze` | `analyze_broken_links.routing.yml` → `BrokenLinksSettingsForm` |
| `view.broken_links_report.page_1` | (Views page) | `access site reports` | `config/install/views.view.broken_links_report.yml` |

Menu: `analyze_broken_links.settings` link sits under `ai.admin_settings`
(`links.menu.yml`). Local tasks (`links.task.yml`): **Settings** tab (the form) and **Results** tab
(the Views report). The settings form also renders a "View reports" button (only if the user has
`access site reports`) and the Views report renders a "Configure settings" button (only for
`administer analyze`, via `hook_views_pre_view`).

## Permissions (`analyze_broken_links.permissions.yml`)

- **`access broken links reports`** — "View broken links data in the Analyze tab." Gates
  `BrokenLinksChecker::access()`. (The settings form uses `administer analyze`; the Views report
  uses core `access site reports`.)

## Status report

`hook_requirements('runtime')` counts broken URLs (using `broken_status_codes`) and, when > 0,
adds a `REQUIREMENT_WARNING` on `/admin/reports/status` linking to the Views report.
