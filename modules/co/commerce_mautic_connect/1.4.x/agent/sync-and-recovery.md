<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sync architecture: subscribers, queues, Drush, magic-link recovery

All Mautic writes use the **email-search-first** pattern:
`getList('email:'.$email,0,1)` → `edit($id,$data)` if found, else `create($data)`.
Every subscriber and queue worker first checks `SyncSuspender::isSuspended()` and
bails when a suspension is held. All API work is wrapped in try/catch so a Mautic
failure never breaks checkout.

## Event subscribers (`src/EventSubscriber/`)

- **CartUpdateSubscriber** (`commerce_mautic_connect.cart_update_subscriber`) —
  real-time abandoned-cart sync.
  - `CART_ENTITY_ADD`, `CART_ORDER_ITEM_UPDATE`, `CART_ORDER_ITEM_REMOVE` →
    `onCartUpdate`: identity = cart email **or** the `mtc_id` cookie; renders cart
    HTML + a magic-link recovery URL and writes `field_cart_html`,
    `cart_recovery_url`, `field_cart_updated` (ISO-8601), `field_cart_language`. If the
    cart is now empty it clears those fields (`overwriteWithBlank => TRUE`).
  - `commerce_order.commerce_order.update` → `onOrderUpdate`: fires when an email is
    first added to a draft order; links the `mtc_id` anonymous contact to the email or
    creates the contact, and syncs cart HTML.
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
  service: `generateToken($order)` = `Crypt::hmacBase64($id.':'.$createdTime,
  Settings::getHashSalt())`; `validateToken()` uses `hash_equals()`.
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

## Magic-link cart recovery

Route `commerce_mautic_connect.restore` → `/cart/restore/{order}/{token}`
(`_access: 'TRUE'`, `order: \d+`), controller `CartRestoreController::restore()`.
Flow: load order → `validateToken()` (else 403) → require `draft` state + items →
adjust cart ownership by current-user status:
- logged-in user + anonymous cart → assign cart to the user;
- logged-in user + own cart → restore;
- logged-in user + **different** user's cart → 403;
- anonymous visitor + cart owned by an active account → `user_login_finalize()` logs
  that account in and restores the cart ("magic link" auto-login);
- owner blocked/deleted → cart transferred to anonymous.
Then it adopts the cart into the session, recalculates totals, and redirects to
`commerce_cart.page`. The recovery URL is generated with the order's language prefix.
Preview route `commerce_mautic_connect.template_preview` →
`/admin/commerce/mautic-connect/preview/{order_id}/{theme}` (`administer site
configuration`) renders the email template for a chosen order/theme.

## Drush commands (`src/Drush/Commands/CommerceMauticConnectCommands.php`)

| Command | Aliases | Purpose |
|---|---|---|
| `commerce-mautic-connect:customer-metrics-sync-all` | `cmcma` | queue RFM for all customers (`--limit`) |
| `commerce-mautic-connect:customer-metrics-sync-customer <email>` | `cmcmc` | queue RFM for one customer |
| `commerce-mautic-connect:abandoned-cart-sync-all` | `cmcac` | queue cart sync for all draft orders w/ email (`--limit`; pass `--uri` so magic links get the right host) |
| `commerce-mautic-connect:coupon-tags-sync` | `cmccts` | backfill coupon tags (`--limit`, `--dry-run`, `--states`) |
| `commerce-mautic-connect:customer-details-sync` | `cmccds` | backfill name/phone/country, one per email, latest order (`--limit`, `--dry-run`, `--states`; ~10/s rate-limited) |

Orders are loaded in 200-ID chunks with `resetCache()` to bound memory on large
sites. `--dry-run` on the coupon and customer-details commands prints the payload
without touching Mautic.
