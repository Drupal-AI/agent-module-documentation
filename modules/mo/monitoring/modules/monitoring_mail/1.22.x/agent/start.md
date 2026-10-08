# Monitoring Mail — agent index

Sends **escalation email** when a Monitoring sensor transitions into a bad status. Experimental.
Depends on `monitoring`.

- **Settings (recipient, severities), where they live, how mail is triggered** → [configure/mail-escalation.md](configure/mail-escalation.md)

Key facts:
- Config `monitoring_mail.settings`: `mail` (recipient address), `severities` (list, default `[CRITICAL]`).
- Fields are added to the base settings form (`/admin/config/system/monitoring/settings`) via
  `hook_form_monitoring_settings_alter()` — no separate form.
- Mail is sent from `hook_monitoring_run_sensors()` on status transition
  (`monitoring_mail_needs_mail()`, `hook_mail()`).
