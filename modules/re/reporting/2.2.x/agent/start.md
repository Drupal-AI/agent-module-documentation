<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reporting — agent index

Implements the **W3C Reporting API**. You define `reporting_endpoint` **config entities**; a
response subscriber advertises the enabled ones in a `Reporting-Endpoints` header, and browsers
POST reports to `/system/reporting/{id}` (for **internal** endpoints), which the module logs to the
`reporting` logger channel. An endpoint can instead be **external**, pointing browsers at an
`https://` third-party collector URI. Ships a `csp` integration plugin so the
Content-Security-Policy module can target an endpoint.

- **Create/manage endpoints (internal vs external), the header, routes, disable(410), CSP
  integration, view reports** → [configure/endpoints.md](configure/endpoints.md)
- **The intake protocol: accepted content types, status codes, how reports are stored/read** →
  [api/endpoint-protocol.md](api/endpoint-protocol.md)

Key facts:
- Config entity type `reporting_endpoint` (prefix `reporting.reporting_endpoint.*`); ships a
  `default` endpoint. `configure` route: `entity.reporting_endpoint.collection`
  (`/admin/config/system/reporting`). Exported keys: `id`, `label`, `status`, `type`,
  `external_uri`.
- Endpoint `type` is `internal` (Drupal's own intake) or `external` (browsers post to
  `external_uri`, an `https://` or root-relative URI validated by a Regex constraint). Config schema
  is `FullyValidatable`.
- Internal intake URL: `/system/reporting/{reporting_endpoint}` (route
  `entity.reporting_endpoint.log`, `_access: TRUE` — public, POST only). Returns **410 Gone** when
  the endpoint is disabled **or** its type is not `internal`.
- Enabled endpoints → `Reporting-Endpoints: <id>="<url>"` header (structured-fields dict, via
  `gapple/structured-fields`): the internal `/system/reporting/{id}` URL for internal endpoints, or
  the `external_uri` for external ones. Cached under cid `reporting.response-endpoints`
  (tag `config:reporting_endpoint_list`).
- Reports logged via `\Drupal::logger('reporting')`; browse at `/admin/reports/reporting` when
  `dblog` is enabled. Admin routes need `administer site configuration`; report page needs
  `access site reports`.
- Update hook `reporting_update_20001()` backfills pre-2.2 endpoints to `type = internal`,
  `external_uri = NULL`.
- No custom permission, no Drush. Core requirement `^10.1 || ^11 || ^12`. Depends on the PHP library
  `gapple/structured-fields` (installed via Composer).

## Diff 2.1.x → 2.2.x

- **New external endpoint type.** The `reporting_endpoint` config entity gains two exported keys:
  `type` (`internal` | `external`, `Choice` constraint) and `external_uri` (nullable, `Regex`
  constraint requiring an `https://` or single-leading-slash root-relative URI). The endpoint
  add/edit form now shows a **Type** radio (Local / External URI) and an **External URI** field
  (shown/required only for external), with `validateForm()` enforcing the https/root-relative rule
  and clearing `external_uri` when the type is internal.
- **Intake now type-gated.** `ReportingEndpoint::log()` returns **410 Gone** not only when disabled
  but also when `type !== 'internal'` (external endpoints don't accept local intake).
- **Header/CSP advertise the external URI.** `ResponseSubscriber::addReportToHeader()` and
  `ReportTo::alterPolicy()` now emit the `external_uri` for external endpoints (falling back to
  skip if empty) instead of the internal log URL.
- **Update hook** `reporting_update_20001()` added to backfill existing endpoints
  (`type = internal`, `external_uri = NULL`).
- **Config schema** marked `FullyValidatable` and extended with `type`/`external_uri` mappings and
  their constraints.
- **Core support** widened to include Drupal 12 (`^10.1 || ^11 || ^12`), in both `.info.yml` and
  `composer.json`.
