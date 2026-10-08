<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mailchimp E-Commerce (mailchimp_ecommerce) — agent index

Syncs a **Drupal Commerce** store (carts, customers, products, promotions, orders) to the
**Mailchimp E-Commerce API** so Mailchimp automations (abandoned cart, retargeting, order
notifications) run on live store data. Package `Mailchimp`. Version **3.x** (installed
3.0.0-alpha1). Core `^10.4 || ^11`, PHP >= 8.0. License GPL-2.0-or-later.

Uses the **first-party `mailchimp/marketing` PHP library** (Mailchimp Marketing API 3.x), NOT
the contrib `mailchimp` module — it has no dependency on it. Hard deps (info.yml):
`address`, `commerce`, `commerce_cart`, `commerce_checkout`, `commerce_order`, `commerce_price`,
`commerce_product`, `profile`, `state_machine`. `commerce_promotion` is used but only when present.

- **Install, settings, config objects & schema, admin routes, mapping forms, batch sync forms,
  Drush** → [config/settings.md](config/settings.md)
- **How data actually flows to Mailchimp: event subscribers → queues → handlers → SDK, the
  checkout opt-in pane, campaign attribution** → [sync/pipeline.md](sync/pipeline.md)

## What it provides (from source)

- **1 permission:** `administer mailchimp ecommerce` (`restrict access: true`) — gates every route.
- **9 admin routes** under `admin/config/services/mailchimp-ecommerce` (all `_form`): settings,
  product-property-map, order-workflow-map, product-sync, order-sync, promo-sync, store-create,
  store-update, store-delete. Menu link under *Configuration → Web services*; local tasks.
- **3 config objects** (schema in `config/schema/mailchimp_ecommerce.schema.yml`):
  `mailchimp_ecommerce.settings` (api_key, store_id, list_id, double_opt_in, batch_limit),
  `.product_property_map`, `.order_workflow_map`.
- **5 handler services** extending `ApiHandlerBase` (`src/`): `store_handler`, `order_handler`,
  `product_handler`, `customer_handler`, `promo_handler` — each wraps `$this->api` (a
  `MailchimpMarketingApiClient`, `src/MailchimpMarketingApiClient.php`, extends
  `MailchimpMarketing\ApiClient`) and calls its `->ecommerce->*` / `->lists->*` / `->ping->*` methods.
- **4 event subscribers** (`src/EventSubscriber/`, all extend `BaseEventSubscriber`): cart, order,
  product, promo — each turns a Commerce event into a queue item.
- **5 queue workers** (`src/Plugin/QueueWorker/`, cron time 120s each): cart, customer, order,
  product, promo queues — each dequeues and calls a handler.
- **1 checkout pane** `mailchimp_subscription_information`
  (`src/Plugin/Commerce/CheckoutPane/ContactSubscription.php`) — newsletter opt-in checkbox.
- **1 Drush command** `mailchimp-ecommerce:store` (alias `mcec:store`).
- **hook_page_attachments** captures `?mc_cid=` (campaign id) + landing URL into the session.
- **hook_requirements** flags an error until an API key is set. `hook_schema` (install) is legacy —
  the `mailchimp_ecommerce_customer` table it once created is dropped by update 9001.

## Mechanism in one paragraph

Commerce fires an event → the matching subscriber builds a small data array and calls
`createQueueItem()` (which de-dupes against pending items) on one of the module's queues → on cron
the queue worker loads the current Commerce entity and calls the handler's `sync*()` method →
the handler builds the Mailchimp body (customer/product/order/cart/promo arrays) and calls the
Mailchimp Marketing SDK (`$this->api->ecommerce->addStore…/updateOrder/…`). Rate-limit (429) and
5xx responses raise `DelayedRequeueException(120)` so the item retries later. See
[sync/pipeline.md](sync/pipeline.md).

## Notes / caveats

- Single store only (README). `store_id`/`list_id` live in `mailchimp_ecommerce.settings`.
- `commerce_promotion` is a soft dependency: `PromoEventSubscriber::getSubscribedEvents()` returns
  `[]` unless `PromotionEvents` exists.
- README is unfinished ("@TODO Continue documentation for Order Automations, Promos, Customers").
- `ProductEventSubscriber::productDelete()` references `$data['variation_id']` which is unset for a
  product-level delete (latent notice) — cosmetic, not functional to the doc.
