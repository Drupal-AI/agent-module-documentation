<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manage reporting endpoints

## The config entity

`reporting_endpoint` is a **config entity** (`\Drupal\reporting\Entity\ReportingEndpoint`,
`admin_permission: administer site configuration`). Config name pattern:
`reporting.reporting_endpoint.<id>`. Exported keys are just `id`, `label`, `status`. The module
ships one enabled endpoint out of the box: `default` (`reporting.reporting_endpoint.default`).

```yaml
# reporting.reporting_endpoint.default
id: default
label: Default
status: true
```

## Admin UI (configure route)

- Collection / configure route: `entity.reporting_endpoint.collection` → `/admin/config/system/reporting`.
- Add: `/admin/config/system/reporting/add` (`entity.reporting_endpoint.add_form`).
- Edit: `/admin/config/system/reporting/{id}` (`entity.reporting_endpoint.edit_form`).
- Delete: `/admin/config/system/reporting/{id}/delete`.

All four require the `administer site configuration` permission.

## The endpoint URL and the header

Each **enabled** endpoint is reachable at `/system/reporting/{id}` (route
`entity.reporting_endpoint.log`, `no_cache: TRUE`). On every main response, `ResponseSubscriber`
adds a header advertising all enabled endpoints:

```
Reporting-Endpoints: default="https://example.com/system/reporting/default"
```

This is a structured-fields dictionary (serialized with `gapple/structured-fields`) keyed by
endpoint id → absolute log URL. The endpoint list is cached under cid
`reporting.response-endpoints` with cache tag `config:reporting_endpoint_list`, so adding/editing/
deleting an endpoint invalidates it automatically.

## Enable / disable

An endpoint's `status` (boolean) controls it:
- **enabled** → included in the header; the log URL accepts reports.
- **disabled** → dropped from the header; the log URL returns **`410 Gone`** (per the Reporting API
  spec, telling browsers to stop delivering).

```bash
# create an endpoint
drush php:eval '\Drupal\reporting\Entity\ReportingEndpoint::create(["id" => "csp", "label" => "CSP", "status" => TRUE])->save();'

# disable one
drush php:eval '$e=\Drupal\reporting\Entity\ReportingEndpoint::load("csp"); $e->disable()->save();'

# read config
drush cget reporting.reporting_endpoint.csp
```

## CSP module integration (ReportTo plugin)

If the contrib **Content-Security-Policy** (`csp`) module is installed, this module provides a
`@CspReportingHandler` plugin id `reporting` ("Reporting Endpoint"). In the CSP policy settings you
pick a reporting endpoint; `ReportTo::alterPolicy()` then sets the policy's `report-uri` to the
endpoint's log URL and `report-to` to the endpoint id — so CSP violations flow into this module.
(The `csp` dependency is dev-only; the plugin simply does nothing if `csp` is absent.)

## Viewing collected reports

Reports are written to the logger, not a bespoke table. With core **dblog** enabled, the module adds
a **"Recent violation reports"** page at `/admin/reports/reporting` (route
`reporting.dblog.overview`, permission `access site reports`) that queries `watchdog` for
`type = reporting` and shows endpoint, date, report type, disposition, and location, each linking to
the full dblog event. Without dblog, reports still go to whatever logger backend is configured
(channel `reporting`).
