<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: Webhooks (advanced_filesystem_webhooks) — agent index

Outbound HTTP webhook dispatcher for the Advanced Filesystem suite. On file-entity hooks and on
events raised by sibling sub-modules it POSTs a JSON payload to each configured, subscribed
endpoint — optionally HMAC-signed, delivered inline or via a retrying queue, with a delivery log.
Package `Advanced Filesystem`. Depends on **`advanced_filesystem`** and core **`file`**. Core
`^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.27 (version-dir 1.0.x).

- **Configuration, endpoints, events, routes, the dispatcher service and the queue worker** →
  [config/settings.md](config/settings.md)

## What it actually is

- **No inbound webhook receiver.** Every route is an admin page; the module only *sends* HTTP.
- One service **`advanced_filesystem_webhooks.dispatcher`** → `Service\WebhookDispatcher`
  (`@config.factory`, logger, `@database`, `@queue`, `@http_client`, `@datetime.time`).
- One queue worker plugin **`advanced_filesystem_webhook_delivery`** →
  `Plugin\QueueWorker\WebhookDeliveryWorker` (cron time 30 s), re-queues on failure until
  `max_attempts`.
- One config form `Form\WebhookSettingsForm`, one controller `Controller\WebhookLogController`
  (`page()` = delivery log, `test()` = send a `test.ping`).
- One config object **`advanced_filesystem_webhooks.settings`** (schema in `config/schema/`),
  one DB table **`adfs_webhook_log`** (hook_schema in `.install`), one permission
  **`administer advanced_filesystem_webhooks`** (`restrict access: true`).
- No entities, no field types, no Drush.

## Events (WebhookDispatcher constants)

`file.upload`, `file.delete` (fired by this module's `hook_file_insert`/`hook_file_delete`);
`antivirus.infected`, `quota.exceeded`, `lgpd.finding` (raised by sibling sub-modules calling
`WebhookDispatcher::dispatch()`). Payload shape: `{event, timestamp, site, data:{…}}`.

## Routes (all `_permission: 'administer advanced_filesystem_webhooks'`, `_admin_route`)

- `advanced_filesystem_webhooks.settings` — `/admin/config/media/advanced_filesystem/webhooks` (form).
- `advanced_filesystem_webhooks.log` — `…/webhooks/log` (delivery log).
- `advanced_filesystem_webhooks.test` — `…/webhooks/test/{index}` — adds `_csrf_token: 'TRUE'`;
  sends a synthetic `test.ping` to endpoint `{index}`.
