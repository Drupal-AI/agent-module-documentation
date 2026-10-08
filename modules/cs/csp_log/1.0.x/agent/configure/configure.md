# Configure csp_log

There is **no settings form** for this module. `csp_log.info.yml` declares
`configure: csp_log.settings`, but that route is not defined in `csp_log.routing.yml`
(a dangling reference). All configuration is either done on the CSP module's policy
form or by pointing a CSP header at the endpoint manually.

## Routes (from csp_log.routing.yml)

| Route | Path | Access | Notes |
|---|---|---|---|
| `csp_log.reporturi` | `/log-report-uri/{type}` | `_access: TRUE` (public) | `no_cache: TRUE`. POST target for browser CSP reports. |
| `csp_log.overview` | `/admin/reports/csp` | `access csp_log reports` | Per-violation list (`LogOverviewForm`). |
| `csp_log.aggregated` | `/admin/reports/csp/aggregated-logs` | `access csp_log reports` | Grouped counts (`LogAggregationForm`). |

`{type}`: the endpoint stores `enforce` when `type === 'enforce'`, otherwise `reportOnly`.
Point an enforcing policy at `/log-report-uri/enforce` and a report-only policy at
`/log-report-uri/report-only` (or `/log-report-uri/reportOnly`).

## Recommended: wire it through the CSP module

Enable the [csp](https://www.drupal.org/project/csp) module (listed as a dev/suggested
dependency). On the CSP policy form, for the Enforced and/or Report-only policy select the
reporting handler **"Dedicated CSP log"** (plugin id `csp_log`). The handler's
`alterPolicy()` then sets the policy's `report-uri` directive to this module's endpoint
automatically (absolute URL, correct `enforce` vs `reportOnly` type). See
[plugins/plugins.md](../plugins/plugins.md).

The handler adds one field, **"Log lifetime (days)"** (`cleanup`, integer, default 0).
This is stored under `csp.settings` at `<policy>.reporting.options.cleanup`.

## Standalone (without the CSP module)

Set a CSP header yourself with a matching report directive, e.g.:

```
Content-Security-Policy-Report-Only: default-src 'self'; report-uri /log-report-uri/report-only
Content-Security-Policy: default-src 'self'; report-uri /log-report-uri/enforce
```

The endpoint expects the browser's standard report JSON (a `{"csp-report": {...}}` body,
or the bare report object). Required keys: `document-uri`, `effective-directive`,
`blocked-uri` — a report missing any of these returns HTTP 400. Success returns 202.

## Cron cleanup

`csp_log_cron()` reads `csp.settings`; for each policy (`enforce`, `report-only`) whose
`reporting.plugin` is `csp_log` it reads `reporting.options.cleanup` (days) and, if
non-zero, deletes logs of that type older than `now - cleanup*86400`. `0` = keep forever.
Cleanup therefore only runs when the CSP module drives the config; standalone users must
prune manually (see [api/api.md](../api/api.md) `removeLogs()`).

## Permission

`access csp_log reports` — "Access CSP reports". Gates both admin report screens. Grant to
a trusted role (e.g. administrator / security team). The report endpoint itself is public
and needs no permission.

## Storage

Data lives in the dedicated `csp_log` table (created by `hook_schema()`): `id`,
`document_uri`, `effective_directive`, `blocked_uri`, `referrer`, `type`, `report` (raw
JSON blob), `timestamp`. Nothing is written to watchdog/dblog.
