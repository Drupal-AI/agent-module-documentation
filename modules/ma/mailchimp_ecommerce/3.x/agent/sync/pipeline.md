<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sync pipeline: events → queues → handlers → Mailchimp SDK

The whole module is a one-way mirror of Commerce entities into Mailchimp. Nothing is synced
inline; every Commerce event only **enqueues** a small data array, and cron workers do the API
calls. This keeps checkout fast and lets rate-limited/failed calls retry.

## API client (`src/MailchimpMarketingApiClient.php`)

`MailchimpMarketingApiClient extends MailchimpMarketing\ApiClient` (the first-party
`mailchimp/marketing` SDK). It only overrides the constructor — require an API key, derive the
`server` from `explode("-", $apikey)[1]` unless passed, and `setConfig(['apiKey'=>…,'server'=>…])`
— and empties `__destruct()` (to avoid the parent's `curl_close`). All HTTP (and TLS) is the SDK's;
the module makes no raw curl / `file_get_contents` calls of its own. Handlers reach the store, order,
customer, product, promo, list and campaign endpoints through `$this->api->ecommerce->*`,
`$this->api->lists->*`, `$this->api->campaigns->*`, `$this->api->ping->*`.

## Handlers (`src/*.Handler`, extend `ApiHandlerBase`)

`ApiHandlerBase` (services get `@config.factory`, `@entity_type.manager`, `@logger.factory`,
`@messenger`, `@string_translation`) constructs `$this->api = new MailchimpMarketingApiClient($apiKey)`
from `mailchimp_ecommerce.settings:api_key`. Shared helpers:
- `buildCustomerBody($mail, $opt_in, $profile, $overrides)` — id + email + opt-in, plus name/company/
  address pulled from the Commerce `profile`'s `address` field (given/family name, address lines,
  city, province, postal code, country code). Used by customer, cart and order bodies.
- `createIdFromMail($mail)` — deterministic Mailchimp customer id = `preg_replace(non-alnum,'',
  crypt(strtolower($mail),'mc'))` (DES-based; just an id, not a security control).
- `getMappedPropertyValue()` / `getPropertyMapping()` — resolve a Mailchimp product property from
  the `product_property_map` config (see [config/settings.md](../config/settings.md)); media/file
  fields resolve to a file URL.
- `validateCampaignId()` — `$this->api->campaigns->get($id)`; 429/5xx → `DelayedRequeueException`.
- `getStoreId()` — from `mailchimp_ecommerce.settings:store_id`.

Concrete handlers and what they call on the SDK:
- **`StoreHandler`** — `stores`/`getStore`/`addStore`/`updateStore`/`deleteStore`/`getLists`/
  `enableSyncing`/`disableSyncing`. Catches `GuzzleHttp\Exception\RequestException` → `log()`.
- **`ProductHandler`** — `syncProduct()` does get-then-update-or-add; `buildProductBody()` /
  `buildProductVariantBody()` assemble id/title/variants/type/url/sku/price/visibility (+ mapped
  description, image, inventory). A product must have ≥1 variation to sync.
- **`OrderHandler`** — handles BOTH carts and orders. `syncCart()` / `syncOrder()` get-then-
  update-or-add; `buildCartOrderBase()` builds customer + currency + totals + tax; `buildCartBody()`
  adds `checkout_url`; `buildOrderBody()` adds lines, shipping/discount totals, `order_url`,
  `landing_site`. `syncOrder()` maps the Mailchimp state to `financial_status`/`fulfillment_status`/
  `cancelled_at_foreign` and can attach `campaign_id`.
- **`CustomerHandler`** — `syncCustomer()` (get→add/update) and `syncCustomerDoubleOptIn()` which
  also `lists->setListMember(list_id, email, {status_if_new/status: 'pending'})`.
- **`PromoHandler`** — `syncPromoRule()` / `syncPromoCode()`; `buildPromoRuleBody()` maps a
  `commerce_promotion` offer to `fixed`/`percentage` + `total`/`per_item`/`shipping` target;
  `buildPromoCodeBody()` maps a coupon.

**Retry contract:** across all handlers, a `RequestException` with code `429` or `>= 500` is
re-thrown as `DelayedRequeueException(120, …)` so the queue re-tries in ~120s; a `404` on a get
means "not found → create"; `EntityStorageException` means the Drupal entity vanished before the
queue ran (logged, skipped).

## Event subscribers (`src/EventSubscriber/`, extend `BaseEventSubscriber`)

`BaseEventSubscriber` provides:
- `createQueueItem($queue, $data)` — enqueues only if no identical pending item exists
  (`getDuplicateQueueItems()` scans the `queue` table and compares the unserialized data with
  `['allowed_classes' => FALSE]`).
- `deleteQueueItems($queue, $key, $value)` — purges pending items whose data matches (used on
  delete events so a pending add/update doesn't run after a delete).
- `getCampaignId()` / `getLandingSite()` — read `mc_cid` / `mc_landing_site` from the session
  (set by `mailchimp_ecommerce_page_attachments()` when a visitor arrives with `?mc_cid=`).

| Subscriber | Queue | Commerce events → action |
|---|---|---|
| `CartEventSubscriber` | `mailchimp_ecommerce_cart_queue` | `commerce_order.place.post_transition`→`orderPlace`; ORDER_ASSIGN/UPDATE/CREATE→`orderEventResponse` (only while draft + has items + has email); ORDER_DELETE→`orderDeleteResponse`; `CART_EMPTY`→`cartEventResponse`. |
| `OrderEventSubscriber` | `mailchimp_ecommerce_order_queue` | order place/validate/process/fulfill/cancel `post_transition`→`orderUpdate`, which maps the transition to a Mailchimp state via `order_workflow_map` config before queueing. |
| `ProductEventSubscriber` | `mailchimp_ecommerce_product_queue` | PRODUCT_INSERT/UPDATE/DELETE + PRODUCT_VARIATION_INSERT/UPDATE/DELETE → queue `productInsert`/`variationUpdate`/… |
| `PromoEventSubscriber` | `mailchimp_ecommerce_promo_queue` | PROMOTION_/COUPON_ INSERT/UPDATE/DELETE (only if `commerce_promotion`'s `PromotionEvents` class exists, else `[]`). |

The **customer queue** (`mailchimp_ecommerce_customer_queue`) is not fed by a subscriber but by the
checkout pane (below).

## Queue workers (`src/Plugin/QueueWorker/`, cron time 120s)

Each worker pulls a `handler` service from the container and dispatches on `$data['event']`:
- `CartQueue` → `order_handler`: `orderPlace`/`orderDelete`/`CartEmptyEvent` → `deleteCart()`;
  otherwise `syncCart()`. (A placed order's Mailchimp *cart* is deleted; the Mailchimp *order* is
  created later by the order queue when the mapped "pending" transition fires.)
- `OrderQueue` → `order_handler->syncOrder(order_id, state, campaign_id)` (skips if the order was
  deleted).
- `ProductQueue` → `product_handler`: product insert/update → `syncProduct()`, delete →
  `deleteProduct()`; variation insert/update → re-`syncProduct()` (product body includes all
  variants), variation delete → `deleteProductVariant()`. Re-resolves a null `product_id` from the
  variation.
- `PromoQueue` → `promo_handler`: promotion/coupon insert/update/delete → the matching
  `sync*`/`delete*`.
- `CustomerQueue` → `customer_handler`: if `double_opt_in` config is on →
  `syncCustomerDoubleOptIn($mail)`, else `syncCustomer($mail, TRUE)`. `$mail` comes from the queued
  data or `Order::load($order_id)->getEmail()`.

Because workers run on cron, sync latency is bounded by your cron frequency; the 120s `cron` time
caps each worker's per-run wall-clock.

## Checkout opt-in pane (`src/Plugin/Commerce/CheckoutPane/ContactSubscription.php`)

`@CommerceCheckoutPane(id = "mailchimp_subscription_information", default_step = "order_information")`.
Renders a "Subscribe to our newsletter" checkbox (label + review-step display configurable via
`buildConfigurationForm()`). On submit, if checked, it enqueues `{email, order_id}` onto
`mailchimp_ecommerce_customer_queue` and sets `mc_checkout_subscribe = TRUE` on the order data
(read back by `OrderHandler::buildCartOrderBase()` as the customer `opt_in`). `isVisible()` always
returns TRUE — enable/position it from the Commerce checkout-flow config.

## Campaign attribution

`mailchimp_ecommerce_page_attachments()` (`.module`): when a request carries `?mc_cid=`, it stores
that campaign id and the landing URL in the session. Subscribers read them via `getCampaignId()` /
`getLandingSite()` and attach `campaign_id` (validated against Mailchimp with
`validateCampaignId()`) to cart/order bodies for attribution.
