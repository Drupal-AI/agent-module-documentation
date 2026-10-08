<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cron Fail Alert watches whether Drupal's cron has run recently and emails a configured administrator when the time since the last successful cron run exceeds a tolerance you set, so a stalled cron is caught before it silently breaks search indexing, queues or scheduled tasks.

---

The module is a single lightweight event subscriber (`CronFailAlertSubscriber`) hooked on `KernelEvents::RESPONSE`, so its check piggybacks on ordinary page requests rather than on cron itself (which by definition is not running when it has failed). On each response it reads a throttle timestamp from Drupal state (`cron_fail_alert.last_check_timestamp`); if fewer than *check frequency* minutes have passed it returns immediately, keeping the per-request cost negligible. When the frequency window has elapsed it runs `checkCronStatus()`, which compares `now` against core's `system.cron_last` state value: if more than *tolerance* minutes have gone by, cron is considered failed and an alert email is built and sent through the mail manager, then the throttle timestamp is updated regardless of the outcome. The email recipient defaults to the site's default email (`system.site:mail`) unless a specific address is configured, and the subject and body are admin-editable templates — the body supports the tokens `@minutes` (whole minutes since the last cron run) and `:site` (the site's scheme + host). Mail assembly is done in `CronFailAlertHooks::mail()` (an OO `hook_mail()` invoked via the legacy shim in `cron_fail_alert.module`), which sets the from address to the site mail and wraps the body with `MailFormatHelper::wrapMail()`. All behavior is controlled from one settings form at `/admin/config/system/cron-fail-alert` (route `cron_fail_alert.settings_form`, permission `administer cron-fail-alert configuration`), whose values live in the `cron_fail_alert.settings` config object (schema provided). The form enforces a valid recipient email and that tolerance is strictly greater than frequency to avoid false positives. There are no dependencies beyond core, no submodules, no Drush commands, no entities and no plugins — just config, one permission, one route/form, and the subscriber.

---

- Get an email the moment cron stops running on a production site, before search/index/queue backlogs build up.
- Detect a crashed or mis-scheduled external cron (crontab / system timer) that has silently stopped hitting the site.
- Alert on a stalled Drupal cron even though cron itself can no longer send the notification.
- Monitor cron on a site that relies on core's automatic (visitor-triggered) cron without adding external monitoring infrastructure.
- Set a tolerance just above your real cron interval (e.g. cron every 15 min, tolerance 20) to catch genuine failures without false alarms.
- Tune the check frequency (1–1440 min) to trade alert latency against per-request overhead.
- Route alerts to an ops/on-call mailbox by setting a dedicated recipient address instead of the default site email.
- Fall back to the site's default email automatically when no recipient is configured.
- Customize the alert subject line for your ticketing/paging system's filters (the site name is appended automatically).
- Customize the alert body copy, including the `@minutes` elapsed value and the `:site` URL, to give responders context.
- Include a direct link to the affected site in the alert via the `:site` token for faster triage.
- Rely on built-in validation that blocks saving a tolerance less than or equal to the check frequency.
- Run cron-failure monitoring on many sites with an identical, config-exportable setup.
- Keep monitoring self-contained — no third-party service, API key or external endpoint required.
- Add cron reliability alerting to a site with almost no performance cost thanks to the state-based throttle.
- Ship the configuration between environments via config export/import (`cron_fail_alert.settings`).
- Restrict who can change alerting settings using the dedicated `administer cron-fail-alert configuration` permission.
- Confirm alert delivery is logged: successes and failures are written to the `cron_fail_alert` logger channel.
- Use it as a low-effort safety net on sites where a missed scheduled task would corrupt data or user experience.
