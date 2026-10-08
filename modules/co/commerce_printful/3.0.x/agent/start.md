<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_printful — agent start

Integrates **Drupal Commerce** with **Printful** (print-on-demand drop-shipping / fulfillment).
Pulls Printful sync products + variants into `commerce_product` / `commerce_product_variation`,
gets live shipping rates through a `printful_shipping` shipping-method plugin, pushes paid orders
(per shipment) to Printful, and receives `package_shipped` fulfillment updates on a webhook that
sets a shipment's tracking code. Version **3.0.1**; core `^10.1 || ^11`; targets **Commerce 3.x**
(Drupal-10/Commerce-2 line dropped at 3.0.0).

Config menu: **Admin → Commerce → Configuration → Printful** (`/admin/commerce/config/printful`,
route `commerce_printful.configuration`).

## Architecture at a glance

- **`printful_store` config entity** (`src/Entity/PrintfulStore.php`) — the integration unit.
  Holds `apiKey`, `commerceStoreId`, `productBundle`, `attributeMapping` (color/size/image →
  Commerce fields), `syncOrders`, `draftOrders`, `webhooks`. On save it auto-creates the
  `printful_reference` field on the chosen product type + its variation type (and deletes it when
  the bundle changes or the store is deleted). Admin routes provided by
  `PrintfulStoreHtmlRouteProvider` (extends `AdminHtmlRouteProvider`), which ALSO adds the public
  webhook route. Collection at `/admin/commerce/config/printful/printful_store`.
- **`printful_reference` field** (`src/Plugin/Field/FieldType/PrintfulReferenceItem.php`) — single
  varchar(16) `printful_id` property on products + variations, storing the Printful `external_id`.
  Field storage is created by `config/install/field.storage.*.printful_reference.yml`; per-bundle
  `FieldConfig` is created programmatically by the store entity, not by config-install.
- **`Printful` API service** (`commerce_printful.printful`, `src/Service/Printful.php`) — thin
  Guzzle wrapper. Magic `__call()` maps method names → REST paths (`syncProducts` → `sync/products`,
  `createOrder` → POST `orders`, `shippingRates` → POST `shipping/rates`, `getStoreInfo` → `stores`,
  `get/set/unsetWebhooks` → `webhooks`, …). Bearer auth via `Authorization: Bearer <apiKey>`. Base
  URL from `commerce_printful.settings:api_base_url` (default `https://api.printful.com/`).
  `setConnectionInfo()` sets the per-store api key at runtime.
- **`ProductIntegrator`** (`commerce_printful.product_integrator`) — product/variant sync logic.
- **`OrderIntegrator`** (`commerce_printful.order_integrator`) + **`OrderEventSubscriber`** — push
  paid orders to Printful on the `commerce_order.order.paid` event.
- **`PrintfulShipping`** shipping-method plugin (`id: printful_shipping`) — live rates.
- **`PrintfulController::webhooks`** — receives `package_shipped` events, updates the shipment.
- **Drush** (`commerce_printful.commands`): `printful:test` (pt) connection test,
  `printful:sync-products` (psp) batch product sync.

## Subdocs

- Product & variant sync (sync form, batch, Drush, image/attribute mapping) → [product-sync.md](product-sync.md)
- Order fulfillment (paid-order push, shipment mapping, drafts) → [order-fulfillment.md](order-fulfillment.md)
- Shipping method (`printful_shipping` live rates) → [shipping.md](shipping.md)
- Webhook (`package_shipped` → tracking/status) → [webhooks.md](webhooks.md)

## Permissions

- `administer commerce printful` (restrict access: TRUE) — gates the config form, store CRUD, and
  synchronization form.
- `access commerce administration pages` (from Commerce) — gates the top-level Printful menu page.

## Key files

| Concern | File |
|---|---|
| API client | `src/Service/Printful.php` |
| Product sync | `src/Service/ProductIntegrator.php`, `src/PrintfulSyncBatch.php`, `src/Form/PrintfulSynchronizationForm.php` |
| Order push | `src/Service/OrderIntegrator.php`, `src/EventSubscriber/OrderEventSubscriber.php`, `src/OrderItemsTrait.php` |
| Shipping | `src/Plugin/Commerce/ShippingMethod/PrintfulShipping.php` |
| Webhook | `src/Controller/PrintfulController.php`, `src/PrintfulStoreHtmlRouteProvider.php` |
| Store entity | `src/Entity/PrintfulStore.php`, `src/Form/PrintfulStoreForm.php` |
| Drush | `src/Commands/CommercePrintfulCommands.php` |

## Setup (source-grounded)

1. `composer require drupal/commerce_printful`, `drush en commerce_printful`.
2. Create a Printful store + products at printful.com; get an API key (Settings → Stores → Add API
   Access).
3. Create a Commerce product type whose variation type has attribute fields to map (color, size)
   and an image field. Clear cache so new attributes appear.
4. Add a Printful store at `/admin/commerce/config/printful/printful_store` — API key, Commerce
   store, product type, attribute mapping, order-sync + draft flags, webhook events. The key is
   validated live via `getStoreInfo()` on submit. Store the API key as a secret (env var + Key
   entity) and run over HTTPS.
5. Make the variation type shippable; add the **Printful dropshipping** shipping method; add the
   shipping pane to checkout.
6. Sync products at `/admin/commerce/config/printful/synchronization` (or `drush psp`).

## Gotchas

- Printful order `external_id` = the Commerce **shipment** id, not the order id (an order can have
  many shipments). Single-shipment stores see them coincide.
- Order push only fires for shipments whose shipping method is `printful_shipping`.
- `composer.json` only requires `drupal/commerce:^3.1`, but `.info.yml` also depends on
  `commerce_currency_resolver` and `commerce_shipping` — require those too or install/enable fails.
- `printful_reference` `FieldConfig` is created lazily when you first save a store with a product
  type; changing the product type moves the field and deletes the old one.
