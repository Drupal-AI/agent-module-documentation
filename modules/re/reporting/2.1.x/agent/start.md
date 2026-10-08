<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reporting — agent index

Implements the **W3C Reporting API**. You define `reporting_endpoint` **config entities**; a
response subscriber advertises the enabled ones in a `Reporting-Endpoints` header, and browsers
POST reports to `/system/reporting/{id}`, which the module logs to the `reporting` logger channel.
Ships a `csp` integration plugin so the Content-Security-Policy module can target an endpoint.

- **Create/manage endpoints, the header, routes, disable(410), CSP integration, view reports** →
  [configure/endpoints.md](configure/endpoints.md)
- **The intake protocol: accepted content types, status codes, how reports are stored/read** →
  [api/endpoint-protocol.md](api/endpoint-protocol.md)

Key facts:
- Config entity type `reporting_endpoint` (prefix `reporting.reporting_endpoint.*`); ships a
  `default` endpoint. `configure` route: `entity.reporting_endpoint.collection`
  (`/admin/config/system/reporting`).
- Endpoint intake URL: `/system/reporting/{reporting_endpoint}` (route
  `entity.reporting_endpoint.log`, `_access: TRUE` — public, POST only).
- Enabled endpoints → `Reporting-Endpoints: <id>="<absolute-url>"` header (structured-fields dict,
  via `gapple/structured-fields`), cached under cid `reporting.response-endpoints`
  (tag `config:reporting_endpoint_list`).
- Reports logged via `\Drupal::logger('reporting')`; browse at `/admin/reports/reporting` when
  `dblog` is enabled. Admin routes need `administer site configuration`; report page needs
  `access site reports`.
- No custom permission, no Drush. Depends on the PHP library `gapple/structured-fields` (installed
  via Composer).
