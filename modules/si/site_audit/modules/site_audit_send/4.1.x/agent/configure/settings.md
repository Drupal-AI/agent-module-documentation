# Configuration & cron

## Config object `site_audit_send.settings`

```yaml
remote_url: 'https://server.example.com/api/site-audit?api-key=xyz'
remote_label: 'Remote Report'
cron_save_interval: 0     # seconds; 0 = never
cron_send_interval: 0     # seconds; 0 = never
cron_delete_interval: 0   # seconds; 0 = never
```

Schema: `site_audit_send.settings` (config_object) — `remote_url` (string), `remote_label` (string),
`cron_save_interval` / `cron_send_interval` / `cron_delete_interval` (integers). Default install ships
only `remote_label: Remote Report`.

## Where you set it (no dedicated route)

`site_audit_send` has **no settings form/route of its own**. Instead
`hook_form_site_audit_config_form_alter()` (`ConfigForm::alterForm`) adds two detail groups to the
main **Site Audit settings** form (`/admin/reports/site-audit/settings`):
- *Recurring Audits*: "Save/Send/Delete report every" selects → the three `cron_*_interval` values.
- *Remote Settings*: "Remote Server URL" (`remote_url`) and "Remote Report Label" (`remote_label`).

On save the URL is validated by a live test POST (`RestClient::testUrl`); 200 = success, 403/404/599
produce specific errors.

Set programmatically / via Drush:

```php
\Drupal::configFactory()->getEditable('site_audit_send.settings')
  ->set('remote_url', 'https://server.example.com/api/site-audit')
  ->set('cron_send_interval', 3600)
  ->save();
```
`drush config:get site_audit_send.settings` reads it.

## Send form

Route `site_audit_send.send_report` → `/admin/reports/site-audit/send`, permission
`access send report form`. It reuses the `site_audit_report` add form and adds a "Send Report" radio
(the send methods) plus buttons: **Send Report** (`::submitForm ::send`) and **Send Report and Save
Locally** (`::submitForm ::send ::save`). A "Send Report" action link appears on the audit page and
the saved-reports collection.

## Cron (`hook_cron`)

Each run checks the three intervals against last-run timestamps in state
(`site_audit.cron_save_last`, `site_audit.cron_send_last`):
- `cron_save_interval` > 0 and due → `SiteAuditReport::saveReport('Cron Report', …)`.
- `cron_send_interval` > 0 and due → `SiteAuditReport::sendReport(remote_label, …)`.
- `cron_delete_interval` > 0 and due → (deletion pass; currently logs a status message).
