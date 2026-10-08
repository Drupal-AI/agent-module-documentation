# Site Audit Send — agent index

Delivers saved audit reports to a remote endpoint on demand or on cron. Depends on `site_audit` and
`site_audit_report_entity`.

- **Config keys, the send form/permission, cron behaviour, where settings appear** →
  [configure/settings.md](configure/settings.md)
- **The `RestClient` service, send-method hooks, and the sent event** →
  [api/sending.md](api/sending.md)

Key facts:
- Config object `site_audit_send.settings`: `remote_url`, `remote_label`, `cron_save_interval`,
  `cron_send_interval`, `cron_delete_interval` (intervals in seconds; `0` = never).
- **No standalone settings route** — these fields are injected into the main Site Audit settings form
  (`/admin/reports/site-audit/settings`) via `hook_form_site_audit_config_form_alter()`.
- Send form route `site_audit_send.send_report` (`/admin/reports/site-audit/send`), permission
  `access send report form`.
- Service `site_audit_send.rest_client` (`RestClient`): `postReport($entity)`, `testUrl($url)`.
- Send methods via `hook_site_audit_send_send_methods()` → `report_api`, `email` (placeholder); each
  method M is handled by `HOOK_site_audit_send_send_M($entity)`.
- Event `site_audit_report_sent` (`SiteAuditSentEvent`); payload alter `site_audit_remote_payload`.
- `hook_cron()` saves/sends/deletes per the intervals, tracking last-run in state.
