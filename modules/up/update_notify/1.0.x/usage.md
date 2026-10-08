<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Update Notify turns Drupal's available-updates data into scheduled, human-readable notifications delivered by email and/or Slack, so maintainers learn what needs updating (and why) without opening the status report.
---
On cron the module checks for available updates via its `UpdateInformationService`, and if the configured send window has arrived, builds a plain-text table of each project's name, installed version, recommended version and release URL, annotated with icons for security updates (🔒), unsupported releases (⛔) and major upgrades (⬆️). The `NotifyService` then delivers that message through the core mail system and, when the contributed Slack module is installed and configured, through a Slack channel. Frequency is selectable (daily / weekly / monthly) with the next-send time computed accordingly, and an operator can force an immediate send with the "Notify now" button on the settings form. Optional extras include the current PHP version, the site host name (or a custom label), and a legend/key explaining the icons.

The settings route `/admin/modules/update/notify` is gated by a `view update notifications` permission (note: this permission string is referenced by routing but not declared by a `permissions.yml`, so it is effectively restricted to the superuser unless another module declares it — a fail-closed gap, not an exposure). The module defines no other routes, does no direct database writes beyond config/state, and only reaches the network through the standard mail plugin and the Slack module's own service. Typical setup: enable, choose frequency and channels (email address, Slack channel), and let cron drive delivery.
---
- Enable scheduled update notifications tied to cron.
- Choose a daily, weekly or monthly notification frequency.
- Receive an email summary of available updates.
- Send the same summary to a Slack channel (via the Slack module).
- See which updates are security releases (🔒) at a glance.
- Spot unsupported releases (⛔) in the notification.
- Identify major-version upgrades (⬆️) that need extra care.
- Trigger an immediate notification with the "Notify now" button.
- Send email to a specific address instead of the site admin default.
- Post to a specific Slack channel instead of the Slack default.
- Include the current PHP version in the message.
- Include the site host name for multi-site identification.
- Use a custom host label instead of the detected URL.
- Add a legend/key explaining the status icons.
- View the last-sent and next-send timestamps on the settings form.
- Get a table with installed vs recommended versions and release URLs.
- Avoid duplicate sends via the tracked next-send state.
- Keep maintainers informed without granting them status-report access.