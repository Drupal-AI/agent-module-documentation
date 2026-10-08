<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logging and alerts routes Drupal's log (watchdog/dblog) messages to destinations other than the database: **emaillog** emails them, sending different severity levels to different addresses, and **errorlog** writes selected severities to the web server's error log.

---

The project has an unusual shape worth knowing before installing: there is **no module at the project root** — `logging_alerts/` contains only a licence and two subdirectories, each a complete module, so `drush en logging_alerts` fails and you enable `emaillog` and/or `errorlog` instead. Both register a Drupal logger channel (a service tagged `logger`, class in each module's `src/Logger/`) that core calls for every logged message, so no event subscriber or watchdog hook is needed. **emaillog** keeps one email address per severity (`emaillog_0`..`emaillog_7`), so emergency and critical entries can go to a pager address while notices go nowhere; it sends through Drupal's core mail system (`hook_mail` key `alert`), can attach per-severity debug info (PHP superglobals and a backtrace) to each mail, offers a `similar_text()`-based rate limiter to suppress floods of near-identical alerts, and renders the body from `emaillog.html.twig`. **errorlog** keeps a boolean per severity (`errorlog_0`..`errorlog_7`) and writes a pipe-delimited line to PHP `error_log()`, whose final destination (syslog, an Apache error log, the Windows event log) depends on the server's `error_log` ini setting. Both config forms live under `/admin/config/development/` and are gated by core `administer site configuration`; only errorlog ships a config schema. The latest release on this branch is **2.1.0-beta1**.

---

- Email critical errors to an on-call address.
- Send different severity levels to different recipients.
- Route emergency and alert entries to a pager or SMS-to-email gateway.
- Write Drupal logs to the web server error log.
- Aggregate Drupal logs alongside server logs.
- Alert on emergencies without a separate monitoring stack.
- Feed logs into an existing log shipper via error_log/syslog.
- Get notified by email when a site starts erroring.
- Route notices and info away from the alerting address.
- Reduce reliance on dblog for critical events.
- Keep a durable record of errors outside the database.
- Attach request/backtrace debug info to alert emails.
- Rate-limit near-identical alert emails during an error loop.
- Format alert emails with a Twig template.
- Include Drupal logs in a centralised syslog pipeline.
- Detect a failing cron run by email.
- Notify a developer of PHP errors as they happen.
- Support an out-of-hours escalation process.
- Send logs to a ticketing-system intake address.
- Override the alert subject with the legacy format.
- Run emaillog and errorlog together to both email and log-file critical events.
- Customise the email body per severity or per channel with theme suggestions.
