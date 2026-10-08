<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sync architecture: subscribers, queues, Drush, recovery-link copy flow

All Mautic writes use the **email-search-first** pattern:
`getList('email:'.$email,0,1)` → `edit($id,$data)` if found, else `create($data)`.
Every subscriber and queue worker first checks `SyncSuspender::isSuspended()` and
bails when a suspension is held. All API work is wrapped in try/catch so a Mautic
failure never breaks checkout.

## Event subscribers (`src/EventSubscriber/`)

- **CartUpdateSubscriber** (`commerce_mautic_connect.cart_update_subscriber`) —
  real-time abandoned-cart sync.
  - `CART_ENTITY_ADD`, `CART_ORDER_ITEM_UPDATE`, `CART_ORDER_ITEM_REMOVE`,
    `CART_EMPTY` → `onCartUpdate`: identity = cart email **or** the `mtc_id` cookie;
    renders cart HTML + a recovery URL and writes `field_cart_html`,
    `cart_recovery_url`, `field_cart_updated` (ISO-8601), `field_cart_language`. If the
    cart is now empty it clears those fields (`overwriteWithBlank => TRUE`).
    `CART_EMPTY` is the only event fired when a cart is emptied in one go.
  - `commerce_order.commerce_order.update` → `onOrderUpdate`: fires when an email is
    first added to a draft order; links the `mtc_id` anonymous contact to the email or
    creates the contact, and syncs the whole cart (so a contact first seen here still
    gets the language and enters language-filtered segments).
  - `commerce_order.place.post_transition` → `onOrderPlaced`: clears the cart HTML
    field (removes contact from the abandoned-cart segment) and, if `enable_coupon_tags`,
    tags the contact with `prefix.couponCode` for each coupon on the order.
- **OrderTransitionSubscriber** (`…order_transition_subscriber`) — Customer Metrics.
  Subscribes to ~11 order transitions; on any transition **into** a configured state
  (or **out of** one, e.g. refund/cancel) it enqueues a metrics recalculation
  `{email, order_id}` when `enable_customer_metrics` is on.
- **CustomerDetailsSubscriber** (`…customer_details_subscriber`) — runs on both
  `place` and `paid` post_transition, calling `CustomerDetailsSyncService::syncOrderContact`
  (paid covers async gateways like Multibanco/MB WAY that only fill the billing
  profile at place).
- **RestoredCartAssignSubscriber** (`…restored_cart_assign_subscriber`) — **new**;
  subscribes `OrderEvents::ORDER_ASSIGN` at priority 100 (ahead of cart-merge
  subscribers). When a cart that was restored from a recovery link is later assigned
  to the original order's customer (they signed in), it removes from the **original**
  order the lines the copy already holds (matched via `OrderItemMatcher`), so a
  carts-merging module does not duplicate items. An original left empty is deleted.
  Tracked via the `commerce_mautic_connect_restored_from` order-data key.

## Queue workers (`src/Plugin/QueueWorker/`, cron time=60)

- **CustomerMetricsSyncQueueWorker** (`commerce_mautic_connect_customer_metrics_sync`)
  — calls `CustomerMetricsCalculationService::calculateCustomerMetrics($email)` and
  upserts the five metric fields. If suspended it throws `SuspendQueueException`
  (releases the item, stops the run, resumes next cron).
- **AbandonedCartSyncQueueWorker** (`commerce_mautic_connect_abandoned_cart_sync`) —
  bulk cart sync for Drush backfills; reloads the order fresh, re-checks draft +
  items, renders HTML with a passed `base_url`, upserts the cart fields.

## Services

- `commerce_mautic_connect.recovery` (`CartRecoveryService`) — stateless token
  service. `getRecoveryUrl($order,$language?)` issues an absolute URL to the
  `.restore` route carrying `order`, `timestamp` (issue time) and `token`; the token
  is `Crypt::hmacBase64($id.':'.$createdTime.':'.$timestamp, Settings::getHashSalt())`.
  `isValidToken($order,$timestamp,$token)` checks `isWithinLifetime($timestamp)` then
  `hash_equals()`. `isValidLegacyToken($order,$token)` validates pre-1.5.0 links
  (payload `$id.':'.$createdTime`, no issue time) with the lifetime counted from the
  order's **changed** time. `getLifetime()` reads `recovery_link_lifetime`
  (default `DEFAULT_LIFETIME` = 604800). `generateToken()`/`validateToken()` remain
  but are **deprecated** (removed in 2.0.0).
- `commerce_mautic_connect.cart_email_formatter` (`CartEmailFormatter`) — **new**;
  `quantity()` trims trailing-zero decimals ("2.00" → "2"), `price()` formats a
  `Price` via `commerce_price.currency_formatter`. Used by `generateCartHtml()`.
- `commerce_mautic_connect.customer_metrics_calculation`
  (`CustomerMetricsCalculationService`) — queries all orders for an email in the
  configured states, sums totals (converting to `base_currency` via
  `commerce_exchanger.calculate` when that optional service is present, else face
  value), derives total spent / order count / first+last order dates / AOV. Returns
  an **empty array** (not zeros) when there are no orders, so the worker leaves the
  contact untouched.
- `commerce_mautic_connect.customer_details_sync` (`CustomerDetailsSyncService`) —
  builds a payload field-by-field from the billing profile; only non-empty values are
  included (`overwriteWithBlank` is never sent), so a blank never wipes existing
  Mautic data. `previewOrderContact()` returns the exact payload without calling the
  API (used by `--dry-run`). `writeWithCountryFallback()` retries once without the
  country if Mautic rejects the write.
- `commerce_mautic_connect.country_mapper` (`MauticCountryMapper`) — `toMauticName($iso)`
  maps ISO alpha-2 → the country name Mautic's native select accepts (explicit alias
  table → CLDR name → deterministic normalization against bundled
  `assets/mautic_countries.json`); returns `NULL` when unmappable so the caller omits
  the field.
- `commerce_mautic_connect.sync_suspender` (`SyncSuspender`) — counted, per-request,
  never-persisted suspension. Consumers wrap deliberate customer-data rewrites (GDPR
  erasure, migration, bulk import) in `suspend()` / `resume()` (use a `finally`) so
  the module doesn't turn those saves into unwanted Mautic contact writes.

## Recovery-link cart restoration (copy, not auto-login)

Routes (`commerce_mautic_connect.routing.yml`), both `_access: 'TRUE'`,
`order: \d+`, `no_cache: TRUE`:
- `.restore` → `/cart/restore/{order}/{timestamp}/{token}` → `CartRestoreController::restore()`.
- `.restore_legacy` → `/cart/restore/{order}/{token}` → `::restoreLegacy()` (links
  issued before 1.5.0, validated against the order's changed time).

The routes are intentionally open: the signed HMAC token is the access check, done in
the controller. **Opening a link never signs anyone in and never hands over the
original order** — a redesign from pre-1.5.0, which auto-logged in the cart owner.
`restoreFrom()` flow: require `draft` state + items → if the order is already one of
the visitor's carts, redirect; else copy each order item (`copyOrderItem()` clones
only configurable fields, skips base-field price/overrides/adjustments so prices are
recalculated for the opener, and drops items whose purchasable entity is gone or
`access('view')` fails) into the visitor's cart, de-duplicating against existing cart
lines via `OrderItemMatcher` so opening twice does not double quantities. The copy's
`commerce_mautic_connect_restored_from` data records the source order id (for
`RestoredCartAssignSubscriber`). Every failure (unknown order, bad token, expired
link) ends identically — a warning on the cart page — so the response does not reveal
which orders exist. The redirect carries over only `utm_*` query parameters (via
`RequestStack`) for campaign attribution.

Preview route `commerce_mautic_connect.template_preview` →
`/admin/commerce/mautic-connect/preview/{order_id}/{theme}` (`administer site
configuration`) renders the email template for a chosen order/theme.

## Drush commands (`src/Drush/Commands/CommerceMauticConnectCommands.php`)

| Command | Aliases | Purpose |
|---|---|---|
| `commerce-mautic-connect:customer-metrics-sync-all` | `cmcma`, `mautic-customer-metrics-sync-all` | queue RFM for all customers (`--limit`) |
| `commerce-mautic-connect:customer-metrics-sync-customer <email>` | `cmcmc`, `mautic-customer-metrics-sync-customer` | queue RFM for one customer |
| `commerce-mautic-connect:abandoned-cart-sync-all` | `cmcac`, `mautic-abandoned-cart-sync-all` | queue cart sync for all draft orders w/ email (`--limit`; pass `--uri` so recovery links get the right host) |
| `commerce-mautic-connect:coupon-tags-sync` | `cmccts`, `mautic-coupon-tags-sync` | backfill coupon tags (`--limit`, `--dry-run`, `--states`) |
| `commerce-mautic-connect:customer-details-sync` | `cmccds`, `mautic-customer-details-sync` | backfill name/phone/country, one per email, latest order (`--limit`, `--dry-run`, `--states`; ~10/s rate-limited) |

Each command no-ops with a warning when its feature toggle is off. Orders are loaded
in 200-ID chunks (`ORDER_LOAD_CHUNK_SIZE`) with `resetCache()` to bound memory on
large sites; all queries use `accessCheck(FALSE)`. `--states` defaults to
`completed,fulfillment,paid,processing,shipped`. `--dry-run` on the coupon and
customer-details commands prints the payload without touching Mautic.
