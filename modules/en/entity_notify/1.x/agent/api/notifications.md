<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notification trigger flow & delivery

All logic is procedural in `entity_notify.module`; there are no services or plugins in this module.

## Triggers

- `entity_notify_entity_insert()` → `_entity_notify_event($entity, 'insert')`
- `entity_notify_entity_update()` → `_entity_notify_event($entity, 'update')`
- `entity_notify_entity_delete()` → `_entity_notify_event($entity, 'delete')`

So the event string is one of `insert` / `update` / `delete`.

## `_entity_notify_event(EntityInterface $entity, string $event)`

1. Return early unless `entity_notify.settings:enable` is TRUE.
2. If the current request URI exactly matches a line in `ignore_paths`, return.
3. Only proceed if the entity type is `node`, `comment`, or is listed in
   `enabled_target_entity_types`.
4. Build `$url`: comment → `$entity->permalink()` absolute; else `$entity->toUrl('canonical',
   ['absolute' => TRUE])`. `$params = ['url' => $url, 'event' => $event]`.
5. Load recipient/channel variables from `entity_notify.settings`; for node/comment, **override**
   them with the bundle's `entity_notify` third-party settings (see config/per-bundle.md).
6. Dispatch to each enabled channel.

## Recipients (email)

- **Admin** (`admin`): `User::load(1)` → its email.
- **Node author** (`node_author`, comment context only): `$entity->getCommentedEntity()->getOwner()`
  email.
- **Roles** (`roles`): `entityQuery('user')` for active users with each role
  (`accessCheck(FALSE)`), then each user's email.
- **Custom list** (`maillist`): comma-split addresses.

Each address goes through `_entity_notify_send_mail($to, $params)`, which validates with the
`email.validator` service, then `plugin.manager.mail`→`mail('entity_notify',
'entity_notify_new_event', $to, <preferred langcode>, $params)`. `hook_mail()`
(`entity_notify_mail`) builds subject `New entity event (@event) on @siteName` and body
`Link to the entity: @url`. A watchdog notice logs each send with the recipient address.
**Body contains only the event name and entity URL — no entity field values.**

## Telegram delivery

If `telegram` is on, for each comma-split chat ID a
`\Drupal\telegram_api\ValueObject\TelegramMessage` is built (text = event + site name + URL,
`token` = bot token, `chatId`). Optional SOCKS5 proxy fields and a custom `url`/endpoint are set.
Then either:

- `telegram_queue` on → `telegram_api.service->queue($message)` (deferred, processed by the
  `telegram_api_queue` QueueWorker on cron/drush), or
- off → `telegram_api.service->sendToTelegramBot($message)`; a non-`TRUE` return is logged as an
  error.

`telegram_api`'s `sendToTelegramBot()` POSTs via the core Guzzle `http_client` (default TLS
verification) with a 10s timeout to `api.telegram.org` or the configured custom endpoint.

## Extending

There is no hook/event to alter the message or recipients; customization is limited to the config
keys. To change delivery you would override `hook_mail` output or the Telegram value object
upstream. The notification carries no per-recipient access check on the linked entity — recipients
are whoever an administrator configured.
