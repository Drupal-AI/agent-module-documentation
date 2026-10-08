<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodules

cmrf_core ships four submodules. None are enabled by default; each depends on `cmrf_core`.

## cmrf_views — CiviCRM API as a Views data source
Turns CiviCRM API calls into Views. You define **datasets** (config entities `cmrf_dataset`,
`cmrf_dataset_relationship`) that describe an entity/action and its fields, then build ordinary Views
against them. Supports both APIv3 and APIv4 via two Views query plugins
(`src/Plugin/views/query/API.php`, `API4.php`), plus a full set of field/filter/argument/relationship
plugins (Date, File, JSON, OptionList, Markup, Boolean, Numeric, Text, etc.).
- Admin: dataset management under `/admin/config/cmrf/cmrf_views/...`; a "Clear Views data cache"
  action at `/admin/config/cmrf/cmrf_views/datasets/clear-cache` (route
  `cmrf_views.clear_cache`, `administer site configuration`) flushes caches and rebuilds Views data.
- Access to the resulting data is governed by each **View's own access settings** — the module does
  not itself gate row access, so a View placed on a public page will show whatever the connector's
  CiviCRM user can read. Scope the connector's CiviCRM API user and set View access deliberately.
- Service `cmrf_views.views` (`Drupal\cmrf_views\CMRFViews`) wraps `cmrf_core.core`.

## cmrf_webform — Webform → CiviCRM
Depends on `drupal:webform`. Two handler types, configured under `/admin/config/cmrf/cmrf_webform`
(all routes `administer site configuration`):
- **Submission handlers** (`cmrf_webform_submission`) post a Webform submission to a CiviCRM entity
  (typically `FormProcessor`) via a chosen connector. Can send **immediately** or **queued** for
  background processing, and can optionally delete the local submission after a successful send.
- **Default-value handlers** (`cmrf_webform_default_value`) pre-fill Webform fields from a CiviCRM
  API call.
- **Option sets** (`cmrf_webform_option_set`) source a field's options from CiviCRM.
Managers in `src/Manager/*` build and dispatch the calls; exceptions in `src/Exception/*`.

## cmrf_call_report — call log UI
A Views-based report of the `civicrm_api_call` table (View `cmrf_calls`, page under
`/admin/reports/cmrfcalls`). Everything is gated by the core **`access site reports`** permission:
- View list + per-call detail `/admin/reports/cmrfcalls/{cid}` (`CMRFCallreportController::viewCall`)
  showing request, reply, metadata, timing.
- **Resubmit** `/admin/reports/cmrfcalls/resubmit/{cid}` re-runs a logged call.
- **Purge** `/admin/reports/cmrfcalls/purge` clears history.
The detail view shows the stored `request` and `reply`. The request/reply may contain CiviCRM
**PII** (contact data returned by calls), but do **not** contain the `api_key`/`site_key` (those are
never persisted). Treat `access site reports` as CRM-data access when this submodule is on.

## cmrf_example — sample client
A demonstration `Drupal\cmrf_example\CiviClient` service (`getContactIds()` runs `Contact.get`) and a
`cmrf_example.settings` config naming the connector. Reference implementation for wrapping calls in a
service class; not for production.
