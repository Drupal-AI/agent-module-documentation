# The `site_audit_report` entity

Defined in `src/Entity/SiteAuditReport.php` as a `@ContentEntityType`.

## Definition highlights

- id `site_audit_report`; base_table `site_audit_report`; data_table `site_audit_report_field_data`;
  revision tables too. `show_revision_ui = TRUE`, `translatable = TRUE`.
- `admin_permission = "administer site audit report"`; owner key `uid` (uses `EntityOwnerTrait`).
- Handlers: list builder, views_data, access control handler, add/edit/delete forms, admin route
  provider. `field_ui_base_route = entity.site_audit_report.settings`.
- Links: collection `/admin/reports/site-audit/reports`, add-form `/admin/reports/site-audit/save`,
  canonical/edit/delete under `/admin/reports/site-audit/reports/{id}`.

## Base fields

- `label` (string) — report label; default from `site_audit_send.settings` `remote_label`.
- `uri` (entity key) — site scheme+host.
- `data` — the audit output; on `preSave()` it is normalized through the `serializer` service
  (`\Drupal::service('serializer')->normalize(...)`), which is why the module depends on `serialization`.
- Plus owner/created/changed and revision metadata.

## Creating / saving reports

```php
use Drupal\site_audit_report_entity\Entity\SiteAuditReport;

// Runs a FULL audit (all/selected reports) and saves a new entity:
$entity = SiteAuditReport::saveReport('Nightly audit', 'Captured by cron');
$url = $entity->link; // absolute canonical URL

// Lightweight: create directly without running an audit (e.g. tests/fixtures):
$entity = SiteAuditReport::create(['label' => 'Manual', 'data' => []]);
$entity->save();
```

Other statics: `sendReport($label, $log, $send_method='report_api')` (builds a report and invokes the
`site_audit_send` send methods), `audit('json'|'html')` (renders the audit), `getNewReportData()`.

## Permissions

`create site audit report`, `view site audit report`, `edit site audit report`,
`delete site audit report`, and `administer site audit report` (restricted; also the entity's admin
permission).

## Field formatter

`site_audit_report_html` (`SiteAuditDataHtmlFormatter`) renders the stored `data` as an HTML report;
schema key `field.formatter.settings.site_audit_report_html`.

## Settings config

`site_audit_report_entity.settings` (config object) currently exposes one `example` string; the
settings form lives at route `site_audit_report_entity.settings_form`
(`/admin/config/system/site-audit-report`).
