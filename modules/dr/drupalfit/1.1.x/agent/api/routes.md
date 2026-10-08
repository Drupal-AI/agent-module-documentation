<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, permissions, report pages, entity, JSON API, cloud client

## Install & enable

```bash
composer require drupal/drupalfit
drush en drupalfit -y            # pulls core system + update, and league/commonmark
drush en drupalfit_report_export -y   # optional: export submodule
```

## Permissions (`drupalfit.permissions.yml`)

- `view drupalfit reports` — access/view the audit reports. Grants read access to a full site
  security/health posture; grant only to trusted roles.
- `administer drupalfit` — configure settings & API key (`restrict access: true`).
- `administer fit_report_history` — manage the report-history entity (`restrict access: true`); this is
  the entity's `admin_permission`.

## Routes (`drupalfit.routing.yml`)

| Route | Path | Controller / form | Permission |
|---|---|---|---|
| `drupalfit.report` | `/admin/reports/drupalfit-report` | `DrupalFitReport::report` | `view drupalfit reports` |
| `drupalfit.report.run` | `/admin/reports/drupalfit-report/run` | `DrupalFitReport::runReport` | `view drupalfit reports` |
| `drupalfit.help` | `/admin/reports/drupalfit-report/help` | `DrupalFitReport::help` | `view drupalfit reports` |
| `drupalfit.drupalfit_report` | `/admin/reports/drupalfit-report/drupalfit` | `DrupalFitReport::drupalFitReport` | `view drupalfit reports` |
| `drupalfit.settings` | `/admin/reports/drupalfit-report/settings` | `Form\DrupalfitConfigForm` | `administer drupalfit` |
| `drupalfit.drupal_fit_resource_api` | `/api/v1/drupalfit-report` | `Controller\DrupalFitResourceApi` | `view drupalfit reports` + `_format: json` + `_csrf_request_header_token: TRUE` |

Menu link `drupalfit.security_report` places the report under Reports; the entity collection link is
under Content. Local tasks/actions/contextual links are in the `drupalfit.links.*.yml` files.

## Report page vs. running a report

- **View** (`report()`): loads the **latest saved** `fit_report_history` entity, decodes its
  `report_result` (grouped findings) and `report_score` (overall + group scores) JSON, and renders the
  `drupalfit_report` theme hook. It does *not* re-run checks. `#cache max-age = 0`.
- **Run** (`runReport()`): builds a `BatchBuilder` with one `FitReportBatch::runCheck` operation per
  discovered check, then `FitReportBatch::finish` (`src/Batch/FitReportBatch.php`) rebuilds a
  `FitResultCollection`, scores it via the collector, normalizes grouped results, and **creates a new
  `fit_report_history` entity** with the two JSON payloads, then redirects back to `drupalfit.report`.
- **Help** (`help()`): reads the module's own `README.md`, converts it with `league/commonmark`
  (`CommonMarkCoreExtension` + `TableExtension`) and renders the HTML.
- **DrupalFit tab** (`drupalFitReport()`): if no API key is set, shows a `drupalfit_register` prompt
  linking `DrupalFitConstants::DRUPALFIT_BASE_URL . '/register'`. If a key is set, renders a
  `drupalfit_embed` iframe of `https://iframe.drupalfit.com` and passes `apiKey` + `domain` to the page
  via `drupalSettings.drupalfit` for `js/iframe-integration.js`.

## FitReportHistory entity (`src/Entity/FitReportHistory.php`)

Content entity, base table `fit_report_history`, `admin_permission = "administer fit_report_history"`,
`EntityOwnerTrait` + `EntityChangedTrait`. Standard admin HTML routes under
`/admin/reports/drupalfit-report/history…` (collection/add/canonical/edit/delete/delete-multiple) via
`AdminHtmlRouteProvider`. Base fields: `label` (auto-set in `preCreate` to a `Y-m-d\TH:i:s` timestamp),
`report_result` (`string_long` JSON), `report_score` (`string_long` JSON), `status` (bool), `uid`
(owner, defaults to anonymous/0 in `preSave`), `created`, `changed`. `preSave()` validates that both JSON
fields parse (`isValidJson`). List builder `FitReportHistoryListBuilder` adds Label + Author columns.

`drupalfit.module` hooks: `hook_theme` (4 theme hooks), preprocess for `drupalfit_report` (adds score
colors + export libraries) and `fit_report_history` (renders a stored entity through the report theme),
`drupalfit_get_export_data()` (builds export links when the submodule is on), and user-lifecycle hooks
(`hook_user_cancel` / `hook_user_predelete`) that unpublish/anonymize/delete a user's history entries.

## JSON API (`src/Controller/DrupalFitResourceApi.php`)

`__invoke()` runs the collector live: `generate()` → `calculateScore()->calculateScores()`, and returns
`{scores: FitScoreResult::toArray(), results: [...]}` where each result exposes id/name/group/weight name
+ the rendered messages. Requires `view drupalfit reports`, `_format: json`, and a valid CSRF request
header token (call `/session/token` first for the `X-CSRF-Token` header).

## Cloud client — DrupalFitApiClient (`src/Service/DrupalFitApiClient.php`, `drupalfit.api_client`)

Constructor: `http_client` (Guzzle), `config.factory`. `getAuditScores(): ?AuditScores`:
- Reads `api_key` from config `drupalfit.settings`; returns `NULL` if unset (so no call is made).
- `POST https://be.drupalfit.com/api-key/scores` with JSON body `{apiKey: <key>}`, 5s timeout, default
  TLS verification. It **sends only the API key**, not the site report.
- Parses `data` into an `AuditScores` DTO (`accessibilityScore` / `seoScore` / `performanceScore`).
  Result is cached per-request. Any Guzzle/JSON error returns `NULL` (audit degrades to on-site only).
- Endpoints are hard-coded constants in `src/DrupalFitConstants.php` — not request- or config-supplied.

## Configuration (`Form\DrupalfitConfigForm`, config `drupalfit.settings`)

Two keys (schema in `config/schema/drupalfit.schema.yml`, both nullable strings): `api_key` (entered
via a `password` field, obtained from a DrupalFit.com account) and `domain` (defaults to the request
host). The API key is stored as a plain config string (no Key entity / no env var). Leave blank to run
DrupalFit purely on-site.
