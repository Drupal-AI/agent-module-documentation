<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Notify watches whether a site's active configuration differs from what is exported to the sync directory, and sends an email and/or Slack notification when it does — catching configuration drift before it becomes a failed deployment.

---

On a Drupal site that manages configuration in git, changing a setting through the admin UI on production creates drift: the active configuration no longer matches the exported files, and the next `drush cim` will either overwrite the change or fail, usually unnoticed until deploy day. Config Notify makes the divergence visible. Its `config_notify.notifier` service (`NotifierService`) transforms the sync storage through the core import transformer and compares it to active storage with a `StorageComparer`; when they differ it builds a message — an optional host label, a "configuration changes not exported" line, and optionally the list of changed config object names (capped by a configurable limit) — and delivers it by email (core mail, to the site address or a specified one) and/or Slack (via the contrib `slack` module when installed and its webhook is set). Delivery is driven either by `hook_cron`, with an optional once-per-day throttle, or on demand from a "Notify now" button that appears on the settings form whenever drift is present. The settings form lives at `/admin/config/development/configuration/notify` as a "Notify" tab under core's configuration-synchronize page, gated by the core `synchronize configuration` permission. The module depends only on core `config` (Slack is optional) and supports `^8.8 || ^9 || ^10 || ^11`. Two practical notes: cron notifications require both drift and the `cron` flag being on; and a real site always has *some* expected drift — modules that write config at runtime, or config deliberately ignored via `config_ignore`/`config_split` — so the check is most useful once that baseline noise is tuned out.

---

- Detect configuration drift on production.
- Email a team when active config diverges from git.
- Post a Slack alert on config drift.
- Catch an undeployed UI change before release.
- Monitor config status automatically on cron.
- Throttle alerts to one per day to avoid noise.
- Send an instant notification with the "Notify now" button.
- Include the list of changed config object names in the alert.
- Cap how many changed config names each alert lists.
- Label alerts with a custom host name (e.g. PROD vs STAGE).
- Route drift emails to a specific ops address.
- Prevent a surprise at deployment time.
- Support a config-in-code governance workflow.
- Alert developers to an emergency UI fix on production.
- Watch several environments for divergence.
- Reduce failed `drush cim` deployments.
- Trigger a drift check from custom code via the notifier service.
- Reinforce a change-control policy with automated alerts.
- Notify when a config import is effectively pending.
- Encourage exporting configuration after any admin change.
- Reduce time spent diagnosing config-import failures.
- Surface a drift warning to admins who open the config-sync page.
