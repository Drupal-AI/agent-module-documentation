<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Role Watchdog

Logging works out of the box with **no configuration** — every role change is recorded automatically.
The settings form only controls dblog mirroring and email notifications.

## Settings form

Path `admin/config/people/role_watchdog` (route `role_watchdog.role_watchdog_settings_form`,
permission `administer role_watchdog`, form `RoleWatchdogSettingsForm`).

## Config object `role_watchdog.settings`

Schema `role_watchdog.settings` (type `config_object`):

| Key | Type | Install default | Meaning |
|---|---|---|---|
| `role_watchdog_use_watchdog` | bool | `true` | Also write each role change to the Drupal PSR-3 logger (`role_watchdog` channel) in addition to the module's own entity log. |
| `role_watchdog_monitor_roles` | sequence of role id | `{administrator: administrator}` | Roles to watch for the email notification feature. (Note: the current capture code emails on **any** role change whenever a notify email is set — see below.) |
| `role_watchdog_notify_email` | string (email) | `email@example.com` (placeholder) | Address that receives change notifications. Notifications are sent **only if this is non-empty**. |

Set via Drush:

```bash
ddev drush config:set role_watchdog.settings role_watchdog_use_watchdog 1 -y
ddev drush config:set role_watchdog.settings role_watchdog_notify_email 'audit@example.com' -y
```

## How logging & notification fire

- `role_watchdog_user_update()` diffs `$account->getRoles()` vs `$account->original->getRoles()` and, for
  additions and removals separately, calls:
  - `role_watchdog_save_entity(...)` — always (creates the `role_watchdog` entity record).
  - `role_watchdog_notify(...)` — when `role_watchdog_notify_email` is non-empty (sends `hook_mail` key
    `notification`; from = site mail, subject = "Role watchdog notification on <site>").
  - `role_watchdog_log_change(...)` — when `role_watchdog_use_watchdog` is true (writes a logger notice).
- `role_watchdog_user_insert()` logs the roles assigned at account creation (and notifies if configured).
- `role_watchdog_user_delete()` deletes the log entries whose `field_user_performed_on` is the deleted
  user (accessCheck disabled for the cleanup query).

The default install config leaves `email@example.com` in place; because that value **is** non-empty,
notifications will attempt to send to it until an operator changes or clears it.
