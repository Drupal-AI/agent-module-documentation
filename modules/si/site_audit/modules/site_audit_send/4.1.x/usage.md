Site Audit Send delivers saved audit reports to a remote endpoint (e.g. a Site Audit Server) over HTTP, on demand from the audit page or automatically on cron, and can save/delete reports on a schedule.

---

This submodule (depends on `site_audit` and `site_audit_report_entity`) adds report delivery. It exposes a `site_audit_send.rest_client` service (`RestClient`) that POSTs a report entity's fields as JSON to a configured `remote_url` (with a `testUrl()` used to validate the endpoint), and defines a pluggable "send method" system via `hook_site_audit_send_send_methods()` — shipping `report_api` (remote server) and a placeholder `email`. Its settings live in `site_audit_send.settings` (`remote_url`, `remote_label`, and three cron intervals: `cron_save_interval`, `cron_send_interval`, `cron_delete_interval`) and are injected into the main Site Audit settings form by `hook_form_FORM_ID_alter()` (there is no standalone settings route). A "Send Report" action/form is added at `/admin/reports/site-audit/send` (permission `access send report form`), reusing the report entity's add form but swapping the submit handlers so it can send, send-and-save, or just save. `hook_cron()` uses the configured intervals to periodically save and send reports (via `SiteAuditReport::saveReport()` / `sendReport()`) and record last-run timestamps in state. A `SiteAuditSentEvent` (`site_audit_report_sent`) fires after each send so other code can react, and a `hook_alter('site_audit_remote_payload')` lets modules modify the outbound payload.

---

- Send an audit report to a central Site Audit Server via its API endpoint.
- Configure the remote URL and API key (as a query param) for report delivery.
- Validate the remote endpoint before saving with the built-in test POST.
- Automatically send audit reports to the remote server on a cron schedule.
- Automatically save audit reports locally on a cron schedule.
- Automatically delete old audit reports on a cron schedule.
- Add a "Send Report" button to the audit page for on-demand delivery.
- Send-and-save a report in one action, or just send without saving.
- Label remote reports with a configurable "Remote Report Label".
- POST a report entity's fields as JSON to any compatible HTTP endpoint.
- React to successful sends by subscribing to the `site_audit_report_sent` event.
- Modify the outbound payload with `hook_alter('site_audit_remote_payload')`.
- Provide additional send methods by implementing `hook_site_audit_send_send_methods()`.
- Implement a custom `HOOK_site_audit_send_send_<method>()` handler for a new destination.
- Centralize audits from many sites into one dashboard/server.
- Schedule regular compliance snapshots without manual Drush runs.
- Use the `site_audit_send.rest_client` service to POST reports from custom code.
- Keep a configurable retention window by tuning the delete interval.
- Surface delivery success/errors to admins via status messages.
- Integrate audit results with an external monitoring pipeline.
