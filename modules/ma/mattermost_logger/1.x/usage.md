<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mattermost Logger forwards Drupal log messages to a Mattermost channel through Mattermost incoming webhooks, filtered per logging channel and per severity.

---

Mattermost Logger registers a PSR-3 logger service (`mattermost_logger.auto_logger`, tagged `logger`) that receives every message written to Drupal's logger and re-posts the ones you select to Mattermost. In the settings form you map each Drupal logging channel (for example `php`, `cron`, `system`, or your own module name) to a Mattermost incoming-webhook URL and tick the severities that should be forwarded for that channel; a channel can use a shared default webhook or its own dedicated one. Each forwarded message is delivered as a Mattermost attachment with a level-based emoji and a color-coded left border (red for error/emergency, orange for alert, yellow for warning, blue for info and below), so severity is visible at a glance. The module also exposes a public `mattermost_logger` service with convenience methods (`error()`, `warning()`, `info()`, `sendMessage()`, and so on) that developers can call directly to push ad-hoc notifications, including rich Mattermost message attachments (titles, fields, images, author lines) via an optional payload argument. It depends on nothing outside Drupal core and requires only a Mattermost server with an incoming webhook configured.

---

- Post Drupal error logs to a team's Mattermost channel in real time.
- Alert an on-call channel whenever a PHP error or emergency is logged.
- Forward only warnings and above from the `cron` channel while ignoring notices.
- Route each module's log channel to a different Mattermost channel via per-channel webhooks.
- Use one default webhook for most channels and override it for a noisy one.
- Mirror `system` or `security`-relevant log entries into a monitored chat channel.
- Give a support team visibility into failed operations without granting them log access.
- Color-code Mattermost alerts by severity so critical issues stand out.
- Send a manual notification from custom code with `\Drupal::service('mattermost_logger')->error('my_module', 'message')`.
- Push a rich Mattermost attachment (title, fields, image) from a batch or queue worker via `sendMessage()`.
- Notify a channel when a scheduled import or migration finishes or fails.
- Surface deprecation or watchdog warnings during a staging test cycle.
- Keep developers informed of integration failures for a third-party API channel.
- Escalate emergencies with a bell emoji so they are hard to miss in chat.
- Consolidate multi-site log alerts into a shared operations channel.
- Provide lightweight incident awareness without a full monitoring stack.
- Trigger a Mattermost message from a custom event subscriber or hook.
- Announce content-workflow events (publish, unpublish) to an editorial channel.
- Feed cron-job outcomes to a DevOps channel for daily review.
- Notify a channel when payment, email, or queue processing raises an error.
- Toggle which severities reach chat per environment (verbose on staging, errors-only on production).
- Add a dedicated debug channel that receives DEBUG-level messages during troubleshooting.
- Let a module ship notifications through Mattermost without writing its own HTTP client.
- Turn a specific logging channel on or off for Mattermost by editing its enabled levels.
