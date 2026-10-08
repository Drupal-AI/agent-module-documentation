<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Emails site administrators (by role and/or address) whenever an uncaught exception is thrown or a log message at a selected severity level is recorded, with flood control and per-case exclude filters.

---

Error & Exception Mailer hooks into Drupal's error handling in two places: an EXCEPTION kernel event subscriber (`ExceptionEventSubscriber`) that fires on uncaught throwables, and a PSR-3 logger backend (`ErrorLog`, tagged `logger`) that fires on log entries whose severity is one of the selected RFC levels. Each triggering event is turned into a plain-text report (site name, timestamp, current user, request URI, referrer, client IP, exception class, message and stack trace) and queued through the `manual_exception_email` QueueWorker to every configured recipient. Recipients are resolved from the settings form's role selection (all active users in those roles) plus a comma-separated address list. `FormAjaxException` and `NotFoundHttpException` (404) are ignored. Built-in flood control compares each new message against the last one with PHP's `similar_text()` and suppresses near-identical alerts until escalating time windows (15 min, 1 h, 6 h, 24 h) elapse, driven by the `max_similar_emails` and `min_similarity` settings. `Exclude` config entities (managed at `/admin/config/exception-mailer/excludes`) refine behavior per case, matching on exception class, error type, severity, message substring, hostname or the current user's roles, and can override recipients, email body and a resend interval. Sending is gated globally by the `enabled` config flag and can be paused temporarily through the `exception_mailer.enabled` state key (e.g. during deployments). All admin routes require the core `administer site configuration` permission.

---

- Get an email alert as soon as an uncaught exception (WSOD / 500 error) occurs on the site.
- Notify a specific admin role of runtime errors without asking staff to watch the database log.
- Send error alerts to a fixed list of email addresses (comma-separated) regardless of role membership.
- Choose which RFC severity levels (emergency, alert, critical, error, warning, notice, info, debug) trigger mail.
- Monitor only fatal-class problems by selecting just emergency/alert/critical/error levels (the default set is 0–3).
- Prevent inbox flooding from a recurring error by capping consecutive similar alerts (`max_similar_emails`).
- Tune how aggressively similar messages are grouped using a similarity threshold percentage (`min_similarity`).
- Receive a summarized alert that shows how many times ("5x ...") an error recurred within a time window.
- Temporarily silence all alerts during a deployment with `drush state:set exception_mailer.enabled 0`, then re-enable with `1`.
- Permanently disable alerts on local/dev/test environments by unchecking "Enable exception emails" in exported config.
- Exclude noisy known exceptions from mail by matching on the exception class string.
- Exclude errors from a specific logger channel (error type) or a set of severity levels.
- Suppress or route alerts for a particular error/exception message substring.
- Filter alerts by client hostname/IP so only errors from certain sources notify you.
- Only alert when the failing request was made by a user in a given role (condition roles on an exclude).
- Route a matched category of errors to a different recipient list than the global default.
- Attach a custom explanatory body to a specific exclude's emails, prepended above the standard system report.
- Throttle resends for a specific exclude with a per-exclude "send interval" (minutes) so it re-sends at most that often.
- Disable an individual exclude rule without deleting it via the exclude's Enabled status.
- Include the current user, request URI, referrer and client IP in every alert to speed up reproduction.
- Localize the alert to a recipient user's preferred language when the address matches a Drupal account.
- Use it as a lightweight self-hosted alternative to external error-tracking services for low-traffic sites.
- Combine role-based and address-based recipients so both a team role and an external on-call address are notified.
- Keep exception details out of mail entirely (logging still happens) by turning the global enable flag off.
