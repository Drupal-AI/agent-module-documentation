<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Watchdog Mailer registers a logger backend that emails Drupal log entries the moment they are written, turning the log stream into a push alerting channel without any external monitoring stack.

---

Because it is a tagged `logger` service (`logger.watchdog_mailer`) rather than a dblog poller, it sees every entry at log time and decides per configured "notification type" whether to mail it. Each notification type matches on log channel (an include or exclude list) and RFC severity, then sends token-templated mail via core's mail system to a default recipient list plus any per-type recipients. A single settings form at `/admin/config/development/watchdog_mailer` (permission `administer watchdog_mailer`) controls the master switch, recipients, subject/body templates, the notification types, and an optional frequency cap. The cap (`mail_limit` over `mail_limit_time_frame` seconds, tracked in State) is worth configuring before enabling on a busy site: an erroring site logs at machine speed, and without a severity threshold and rate limit a single fault can generate a flood of mail. Note too that log messages routinely carry usernames, IP addresses, request paths and PHP backtraces, so the default templates move that data through your mail provider and into inboxes — decide the channel/severity scope deliberately. Core requirement is `^10 || ^11`; the Token module is an optional convenience for the in-form token browser. A `.tugboat/` config indicates an upstream demo environment.

---

- Email critical and emergency errors the instant they are logged.
- Alert on PHP fatals and warnings without a separate monitoring service.
- Route `cron`-channel failures to an on-call address.
- Send `php`-channel entries (with backtrace) to a developer inbox.
- Notify a security contact on `access denied` spikes.
- Include a full PHP backtrace, file and line in the alert body via tokens.
- Define one notification type per team, each with its own recipients.
- Exclude noisy channels while mailing everything else (channel negate).
- Watch a newly deployed feature's channel for errors.
- Cap alert volume with a per-hour mail limit to avoid inbox flooding.
- Get a one-shot "limit reached" notice when the cap trips.
- Escalate out-of-hours errors to a pager gateway address.
- Keep an error trail outside the database, in mailboxes.
- Send alerts to a chat channel via its email-in gateway.
- Catch errors that never surface in a user-facing report.
- Filter alerts to a chosen severity threshold.
- Customize subject and body with site and log tokens.
- Provide evidence for an incident review from mail history.
- Restrict who configures alerting via a dedicated permission.
- Complement dblog with push notifications instead of manual log checks.
- Add or remove notification types from the UI as needs change.
