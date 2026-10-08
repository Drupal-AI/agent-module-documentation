Monitoring Mail (experimental) sends an escalation email when a Monitoring sensor's result transitions into a bad status, to a configured recipient and for configured severities.

---

The submodule implements `hook_monitoring_run_sensors()` (`monitoring_mail_monitoring_run_sensors()`): after each sensor run it compares the new status to the previous one and, when a sensor transitions into one of the configured severities, sends mail. `monitoring_mail_needs_mail()` decides whether a given result warrants mail based on the severity list and the old/new status; `hook_mail()` (`monitoring_mail_mail()`) builds the message. Configuration is stored in `monitoring_mail.settings` with two keys: `mail` (the recipient email address) and `severities` (a list of statuses that trigger mail, default `[CRITICAL]`). Rather than shipping its own form, it **injects fields into the base module's settings form** via `hook_form_monitoring_settings_alter()`/`_submit()`, so the recipient and severities are edited at `/admin/config/system/monitoring/settings`. Depends on the base `monitoring` module.

---

- Email an administrator when any sensor becomes CRITICAL.
- Also alert on WARNING transitions by adding WARNING to the severities list.
- Send escalation mail to an on-call address for site-health incidents.
- Notify only on transitions (status change), avoiding repeated mails for a steady-state failure.
- Configure the recipient address on the Monitoring settings page.
- Choose which severities trigger mail (e.g. CRITICAL only, or WARNING + CRITICAL).
- Get notified when cron-age or disk-usage sensors cross their thresholds.
- Alert when watchdog error counts spike (via the relevant sensors).
- Route Drupal health alerts into a shared team inbox.
- Combine with other monitoring integrations (Prometheus/Munin) for redundant alerting.
- Provide a lightweight email alert path without an external monitoring server.
- Escalate security sensor transitions (failed logins, user integrity) by email.
- Send a heads-up when a required module/requirement sensor fails.
- Set up basic alerting quickly on a small site.
- Test alerting by forcing a sensor into a bad state and confirming mail is sent.
- Keep stakeholders informed of production incidents automatically.
- Disable mail temporarily by clearing the recipient address.
- Tune noise by narrowing the severities that trigger mail.
- Use it as an example of implementing `hook_monitoring_run_sensors()` for custom reactions.
