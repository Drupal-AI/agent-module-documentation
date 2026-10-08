<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# rest_log — settings, retention, routes, permissions, report

## Install / enable

`drush en rest_log -y`. Pulls in core `rest`, `views`, `file`. Installing default config
(`config/install/`) provides the `rest_log.settings` object, the `views.view.rest_log` report and
the `system.action.rest_log_delete_action` bulk action. Nothing is logged until a REST resource is
enabled and receives traffic.

## Config object `rest_log.settings`

`config/install/rest_log.settings.yml` defaults / `config/schema/rest_log.schema.yml`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `maximum_lifetime` | integer (seconds) | `2592000` (30 days) | Rows older than this are deleted by cron; `0` disables cleanup (keep forever). |
| `include_same_host` | boolean | `true` | When false, requests whose referer host equals the site host are not logged. |

Set via **`RestLogSettingsForm`** (`src/Form/RestLogSettingsForm.php`, form id
`rest_log_settings`): a number field (`#min` 0) for `maximum_lifetime` and a checkbox for
`include_same_host`. `include_same_host` was introduced by `rest_log_update_9002` (default TRUE).

## Retention / cleanup

`rest_log_cron()` (`rest_log.module`): if `maximum_lifetime` is falsy it returns immediately.
Otherwise it computes `cutoff = current_time - maximum_lifetime`, counts `rest_log` rows with
`created < cutoff`, and deletes them in chunks of 10 000
(`DELETE FROM {rest_log} WHERE created < :time LIMIT 10000`). So expiry is driven by cron runs.

## Routes

| Route | Path | Requirement |
|---|---|---|
| `rest_log.settings` | `/admin/config/development/logging/rest_log` | `_permission: administer site configuration` |
| entity canonical | `/admin/reports/rest_log/{rest_log}` | entity `view` access |
| entity delete-form | `/admin/reports/rest_log/{rest_log}/delete` | entity `delete` access |
| entity delete-multiple | `/admin/reports/rest_log/delete` | entity `delete` access |

`rest_log.routing.yml` declares only the settings form; the entity routes come from
`DefaultHtmlRouteProvider` on the entity type. Menu link `rest_log.list`
(`rest_log.links.menu.yml`) puts the report under *Reports* (`system.admin_reports`) at
`/admin/reports/rest_log`; task links (`rest_log.links.task.yml`) add a *REST Log settings* tab on
`system.logging_settings`.

## Permissions & access

- `rest_log.permissions.yml` defines a single permission **`access rest log list`**
  (*"Access rest log list"*).
- `RestLogAccessControlHandler::checkAccess()` OR-s the parent result with
  `AccessResult::allowedIfHasPermission($account, 'access rest log list')` for the `view` and
  `delete` operations — so that permission gates viewing and deleting individual log entities.
- The settings form is separately gated by core `administer site configuration`.

## Report & bulk action

- `views.view.rest_log` (`config/install/views.view.rest_log.yml`) — the *REST API Logging* Views
  report at `/admin/reports/rest_log` (base table `rest_log`, depends on `file`, `rest_log`,
  `user`). Update 9004 replaced an older `rest_log` view with this one.
- `system.action.rest_log_delete_action` — a bulk `entity:delete_action:rest_log` action
  (*"Delete selected rest logs"*) usable from the Views listing.

## Extending

Register a service implementing `RestLogRouteCheckInterface` and tag it `rest_log.route_check` to
broaden which routes are captured beyond REST-module resources (see
[../api/logging.md](../api/logging.md)).
