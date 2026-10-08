<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhooks Drush commands

`src/Commands/WebhooksCommands.php` (registered via `drush.services.yml`).

## `webhooks:trigger` (alias `wt`)

```
drush webhooks:trigger <event> [--payload='{"ping":"pong"}'] [--headers='{"X-Custom":"Header"}'] [--content_type=application/json]
```

Builds a `Webhook` from the options and calls `WebhooksService::triggerEvent($webhook, $event)`,
sending to every active outgoing webhook subscribed to `<event>` (e.g. `entity:node:create`,
`entity:user:update`, `system:cron`, or a custom event). Useful for testing an outgoing endpoint.

## `webhooks:list`

```
drush webhooks:list [--type=incoming|outgoing] [--status=0|1]
```

Lists configured webhooks — columns `display_name`, `machine_name`, `type`, `status`
(active/inactive). Supports the standard Drush field/filter options.
