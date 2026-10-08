<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manage reporting endpoints

## The config entity

`reporting_endpoint` is a **config entity** (`\Drupal\reporting\Entity\ReportingEndpoint`,
`admin_permission: administer site configuration`). Config name pattern:
`reporting.reporting_endpoint.<id>`. Exported keys: `id`, `label`, `status`, `type`, `external_uri`.
The module ships one enabled endpoint out of the box: `default`
(`reporting.reporting_endpoint.default`).

```yaml
# reporting.reporting_endpoint.default
id: default
label: Default
status: true
```

`type` is `internal` (Drupal's own intake URL) or `external` (browsers post to `external_uri`). The
config schema is `FullyValidatable`; `type` has a `Choice` constraint (`internal`/`external`) and
`external_uri` a `Regex` constraint (`/^(https:\/\/|\/(?!\/))/` — must be an `https://` URL or a
single-leading-slash root-relative path).

## Admin UI (configure route)

- Collection / configure route: `entity.reporting_endpoint.collection` → `/admin/config/system/reporting`.
- Add: `/admin/config/system/reporting/add` (`entity.reporting_endpoint.add_form`).
- Edit: `/admin/config/system/reporting/{id}` (`entity.reporting_endpoint.edit_form`).
- Delete: `/admin/config/system/reporting/{id}/delete`.

All four require the `administer site configuration` permission. The add/edit form fields are:
**Label**, machine **id**, **Type** (radios: `Local` = internal, `External URI`), **External URI**
(text; shown/required only when type is external), and **Enabled**. `validateForm()` enforces the
https/root-relative rule for external URIs and nulls `external_uri` when the type is internal.

## The endpoint URL and the header

Each **enabled** endpoint is advertised on every main response by `ResponseSubscriber`:

```
Reporting-Endpoints: default="https://example.com/system/reporting/default"
```

The advertised URL is:
- **internal** endpoint → its absolute intake URL `/system/reporting/{id}` (route
  `entity.reporting_endpoint.log`, `no_cache: TRUE`).
- **external** endpoint → its configured `external_uri` (skipped if empty).

This is a structured-fields dictionary (serialized with `gapple/structured-fields`) keyed by
endpoint id → URL. The endpoint list is cached under cid `reporting.response-endpoints` with cache
tag `config:reporting_endpoint_list`, so adding/editing/deleting an endpoint invalidates it
automatically.

## Internal vs external endpoints

- **internal** — browsers POST reports to Drupal's `/system/reporting/{id}` URL, and the module logs
  them (see `api/endpoint-protocol.md`).
- **external** — browsers POST straight to the third-party `external_uri` (e.g. a report-uri.com
  collector). Drupal only advertises the URI; its own `/system/reporting/{id}` route returns
  **410 Gone** for external endpoints because there is no local intake.

## Enable / disable

An endpoint's `status` (boolean) controls it:
- **enabled** → included in the header; an internal endpoint's log URL accepts reports.
- **disabled** → dropped from the header; the log URL returns **`410 Gone`** (per the Reporting API
  spec, telling browsers to stop delivering).

```bash
# create an internal endpoint
drush php:eval '\Drupal\reporting\Entity\ReportingEndpoint::create(["id" => "csp", "label" => "CSP", "type" => "internal", "status" => TRUE])->save();'

# create an external endpoint
drush php:eval '\Drupal\reporting\Entity\ReportingEndpoint::create(["id" => "saas", "label" => "SaaS", "type" => "external", "external_uri" => "https://example.report-uri.com/r/d/csp/enforce", "status" => TRUE])->save();'

# disable one
drush php:eval '$e=\Drupal\reporting\Entity\ReportingEndpoint::load("csp"); $e->disable()->save();'

# read config
drush cget reporting.reporting_endpoint.csp
```

## Update hook

`reporting_update_20001()` backfills endpoints created before 2.2 that lack the new keys, setting
`type = internal` and `external_uri = NULL` on each.

## CSP module integration (ReportTo plugin)

If the contrib **Content-Security-Policy** (`csp`) module is installed, this module provides a
`@CspReportingHandler` plugin id `reporting` ("Reporting Endpoint"). In the CSP policy settings you
pick a reporting endpoint; `ReportTo::alterPolicy()` then sets the policy's `report-uri` to the
endpoint's intake URL (internal → the log URL; external → the `external_uri`) and `report-to` to the
endpoint id — so CSP violations flow to the chosen endpoint. (The `csp` dependency is dev-only; the
plugin simply does nothing if `csp` is absent.)

## Viewing collected reports

Reports are written to the logger, not a bespoke table. With core **dblog** enabled, the module adds
a **"Recent violation reports"** page at `/admin/reports/reporting` (route
`reporting.dblog.overview`, permission `access site reports`, `_module_dependencies: dblog`) that
queries `watchdog` for `type = reporting` and shows endpoint, date, report type, disposition, and
location, each linking to the full dblog event. Without dblog, reports still go to whatever logger
backend is configured (channel `reporting`).
