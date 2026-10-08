<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — `notify_widget.settings`

Config object **`notify_widget.settings`**, edited by `NotifyWidgetSettingsForm`
(`src/Form/NotifyWidgetSettingsForm.php`, a `ConfigFormBase`). Route
**`notify_widget.settings`** at `/admin/config/system/notify-widget`, permission
**`administer site configuration`** (also the `configure` link and a menu item under
*Configuration → System*, `notify_widget.links.menu.yml`). Schema in
`config/schema/notify_widget.schema.yml`.

## Install & enable

```bash
composer require drupal/notify_widget
drush en notify_widget -y
```

No contrib dependencies (core only; `^10 || ^11`). No `hook_requirements`; `hook_install` /
`hook_uninstall` only print a status message. Installing creates the `notify_widget` DB table.

## Settings keys

| Key | Type | Default | Effect |
|---|---|---|---|
| `max_notifications` | integer | 10 | Max rows the **popup** and `getNotificationsForUser()` return (form range 1–5000). |
| `include_read` | boolean | TRUE | Whether read notifications appear in the popup (`renderNotifyWidgetBlock()`). |
| `read_cutoff` | integer (seconds) | 0 | If > 0, read notifications older than now − cutoff are hidden from the popup. Form options: 0/900/1800/3600/21600/86400/604800. |
| `purge_days_old` | integer (days) | 0 | If > 0, `purgeOldNotificationsIfNeeded()` deletes notifications older than this on each visit to the full list. 0 disables. |
| `use_module_css` | boolean | TRUE | TRUE attaches library `notify_widget/notifications_popup_css` (JS + bundled `css/style.css`); FALSE attaches `notify_widget/notifications_popup` (JS only — you style `#notify_widget` yourself). |

Note the config **schema declares only these five keys**; there is no `config/install/` default
file for `notify_widget.settings`, so before the form is saved the code relies on the `?? default`
fallbacks shown above. `read_cutoff` is stored as the selected string option but read as `(int)`.

## Bundled action config

`config/install/system.action.notify_widget_send_action.yml` installs a `system.action` entity
(`id: notify_widget_send_action`, `type: user`, `plugin: notify_widget_send_action`) that exposes
the bulk send action on the People listing — see [routes/notifications.md](../routes/notifications.md).
