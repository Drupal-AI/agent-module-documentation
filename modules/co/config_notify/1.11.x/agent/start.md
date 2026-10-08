<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Notify (config_notify) — agent index

Sends notifications (email and/or Slack) when the site's **active** configuration diverges
from the **exported/sync** configuration (config drift). The check runs on cron or on demand
via a "Notify now" button on the settings form. Depends on core `config`; Slack support is a
soft dependency on the contrib `slack` module. Core: `^8.8 || ^9 || ^10 || ^11`.

Configure at `/admin/config/development/configuration/notify` (route `config_notify.settings`),
gated by core's **`synchronize configuration`** permission. It appears as a "Notify" local-task
tab and menu link under the core config-sync page (`config.sync`). The module defines no
permissions, drush commands, plugin types, or config schema of its own.

- **Turn on drift notifications, choose email vs Slack, throttle to once/day, list changes** → [configure/settings.md](configure/settings.md)
- **Run the drift check or send a notification from your own code** → [api/notifier.md](api/notifier.md)
- **How cron decides to send, and the mail key to alter** → [hooks/cron.md](hooks/cron.md)

Key facts:
- Config object: `config_notify.settings` — keys `cron`, `daily`, `email`, `email_to`,
  `slack`, `list_changes`, `list_changes_limit`, `add_host`, `custom_host_value`
  (no `config/install` defaults and no schema — keys are unset until the form is saved once).
- Service: `config_notify.notifier` → `Drupal\config_notify\NotifierService`
  (`checkChanges()`, `getChanges()`, `getDefaultMessage()`, `notifyEmail()`, `notifySlack()`).
- Hooks: `hook_cron` (the automatic trigger), `hook_mail` (key `config_notify`), `hook_uninstall`.
- State: `config_notify.last_sent` (unix timestamp of the last notification; cleared on uninstall).
- The message contains the host label plus the list of changed config **object names**
  (e.g. `system.site`), not their values.
