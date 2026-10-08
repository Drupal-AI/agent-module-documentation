<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Update Notify (update_notify) — agent index
**Sends scheduled email/Slack summaries of available module & core updates, flagging security (🔒), unsupported (⛔) and major (⬆️) releases.**

- **Version:** 1.0.x (release 1.0.4)
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** update (core); optional `slack` module for Slack delivery.
- **Route:** `update_notify.settings` → `/admin/modules/update/notify`, permission `view update notifications`.
- **Services:** `update_notify.notify` (`NotifyService`), `update_notify.update.information` (`UpdateInformationService`).
- **Driver:** `hook_cron` → `triggerNotifications()`; frequency daily/weekly/monthly; "Notify now" forces an immediate send.
- **Security:** admin config route only; gated by `view update notifications` — which the module references but does not declare in a permissions.yml, so it is fail-closed (effectively superuser-only) until another module provides it. No anonymous, mutating, or external-fetch endpoints; delivery uses core mail and the Slack module's service.

See [configure/settings.md](configure/settings.md)
