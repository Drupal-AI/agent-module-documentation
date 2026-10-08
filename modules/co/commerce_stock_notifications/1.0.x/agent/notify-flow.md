<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notify + purge flow (cron → queue → mail)

Everything after a subscription is stored runs from `commerce_stock_notifications_cron()` in
`commerce_stock_notifications.module`, which feeds two queue workers.

## `hook_cron` — builds two queues

Runs only when the target queue is empty (`numberOfItems() == 0`), so a backlog drains before new items
are enqueued.

1. **Cleanup queue** (`commerce_stock_notifications_cleanup`): computes
   `now - purge_interval days` (from config, default 30), entity-queries notifications where
   `sent_time IS NOT NULL AND sent_time < purge_time`, loads them, and enqueues each entity.
2. **Notify queue** (`commerce_stock_notifications`): entity-queries notifications where
   `sent_time IS NULL`, sorted by `submit_time`, `range(0, 500)`. For each, loads the referenced
   product variation (`product_id`) and enqueues it **only if `commerce_stock_notifications_check_stock()`
   is true** (variation is currently back in stock).

Note: entities themselves are placed on the queue as items (the workers receive the loaded entity).

## Notify worker — `CommerceStockNotifyQueue` (`processItem`)

Plugin `commerce_stock_notifications`, cron time 120s. Per item:
- Skips if `sent_time` is already set.
- `user_load_by_mail($data->getEmail())` to resolve a user for token context (may be null/anonymous).
- Loads the variation; **throws** (re-queues later) if the variation or its parent product is
  unpublished; **returns** (skips this run) if the variation is no longer in stock.
- Token-replaces `email_subject` and `email_body` config with `commerce_product_variation` + `user`
  contexts, renders the `commerce_stock_notifications_message` theme (isolated render via
  `DeprecationHelper` → `renderInIsolation`/`renderPlain`), and calls `mailManager->mail()` with key
  `commerce_stock_notifications.notify`, recipient = subscriber email, language = the resolved user's
  preferred langcode or the site default for anonymous.
- On success, sets `sent_time` to now and saves (so it will not be re-sent, and becomes eligible for
  purge after `purge_interval` days).

## Purge worker — `CommerceStockNotificationPurgeQueue` (`processItem`)

Plugin `commerce_stock_notifications_cleanup`, cron time 240s. Simply `$data->delete()` — removes the
already-sent, aged-out notification record.

## Theming / mail

- `hook_theme` registers `commerce_stock_notifications_message` (vars: message, commerce_product_variation,
  commerce_product_variation_url, user, mail). Template
  `templates/commerce-stock-notifications-message.html.twig` prints only `{{ message }}`.
- `hook_mail` (key `commerce_stock_notifications.notify`) forces HTML content type, from = site mail,
  subject = `params['mail_title']`, body = `params['message']`.
- `templates/commerce_stock_notification.html.twig` is the entity view template (prints `content`).

## Views data

`StockNotificationViewsData` overrides the `sent_time` field handler id to `date`. The bundled
`list_of_subscribed_products` view exposes id, product title (via `product_id` relationship),
submit/sent times, and a custom Unsubscribe-link field, filtered to the current user (`uid_current`) and
published variations, on the account tab `user/%user/stock_notifications`.
