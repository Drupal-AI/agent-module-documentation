<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Amazon SP-API (commerce_amazon_sp_api) — agent index

Drupal Commerce integration with the **Amazon Selling Partner API (SP-API)**. It syncs **FBA
inventory** into Drupal, links Amazon items to Commerce product variations, and — when a Commerce
order is placed — creates an **Amazon Fulfillment Outbound order** so Amazon ships it, then tracks
that fulfillment and drives the Drupal order's workflow from Amazon's status. It is a
product/order/fulfillment integration, **not a payment gateway**. Package `Commerce (Contrib)`.
Core `^10 || ^11`. License GPL-2.0-or-later. Installed version **1.0.0** (version dir `1.0.x`).

Scope note: only the **Fulfillment Outbound** and **FBA Inventory** SP-API areas are wired into
Commerce. The client also has Listings/Product-Type/Sellers calls, but managing Amazon listings is
not fully implemented in the UI (per README).

## Dependencies

- Drupal modules (`.info.yml`): `commerce:commerce_product`, `commerce:commerce_order`,
  `commerce_shipping:commerce_shipping`. `composer.json` requires `drupal/commerce ^2 || ^3` and
  `drupal/commerce_shipping ^2`. No external PHP SDK — calls SP-API directly over the core
  `http_client` (Guzzle). Also uses `state_machine` (via commerce_order) and the `entity` module
  handlers.

## Authentication model (from source)

- Uses **Login-with-Amazon (LWA)** only. No AWS SigV4 request signing (Amazon dropped that
  requirement): SP-API calls carry the LWA access token in the `x-amz-access-token` header.
- The admin **self-authorizes** the SP-API app in Amazon Seller Central and pastes the resulting
  **refresh token** into the Amazon App entity. `ApiClient::refreshAccessToken()` exchanges it at
  `https://api.amazon.com/auth/o2/token` for an access token (cached on the entity with an
  `expires_in`, refreshed automatically 60s before expiry). All traffic is HTTPS. There is no
  authorize/callback route.

## What it provides (from source)

- **Four content entity types**: `commerce_amazon_app` (credentials + auth + region + sandbox/
  production mode + participating marketplaces), `commerce_amazon_marketplace` (one region under an
  app; sync/fulfillment settings + Commerce conditions), `commerce_amazon_item` (an Amazon SKU
  linked to a Commerce product variation), `commerce_amazon_fulfillment` (an Amazon fulfillment
  order tied to a Commerce order, with a `fulfillment_default` state-machine workflow).
- **API client service** `commerce_amazon_sp_api.client` (`Amazon/ApiClient`) — ~15 SP-API methods
  (inventory summaries, fulfillment order create/get/cancel/preview, delivery offers, marketplace
  participations, listings/product-type). See [agent/api-client.md](api-client.md).
- **Inventory service** `commerce_amazon_sp_api.inventory` (`Amazon/Inventory`) and **fulfillment
  service** `commerce_amazon_sp_api.fulfillment_order` (`Amazon/FulfillmentOrder`), driven by
  `hook_cron` and by an order-place event subscriber. See [agent/sync-fulfillment.md](sync-fulfillment.md).
- **Event subscribers**: `OrderPlaceSubscriber` (creates the Amazon fulfillment order on
  `commerce_order.place.post_transition`) and `FulfillmentWorkflowSubscriber` (maps Amazon
  fulfillment state transitions onto Commerce order transitions).
- **Events** (`Event/AmazonEvents`): item sync, fulfillment order create/preview, order-item
  validation, and put-listings payload alter — all let other modules alter the outbound payload.
- **Routes** (`.routing.yml`): admin menu pages under `/admin/commerce/amazon` and
  `/admin/commerce/config/amazon-sp-api`, plus per-entity settings forms. Entity CRUD routes come
  from `entity`/`AdminHtmlRouteProvider` subclasses; the marketplace `integration` form has its own
  route. All admin-gated.
- **Permissions** (`.permissions.yml`): `administer commerce_amazon_marketplace` (restricted) and
  view/edit/delete/create `commerce_amazon_marketplace`; the App and Item entities use the `entity`
  module's generated permissions (`administer commerce_amazon_app`, etc.).
- **Storage/schema**: base tables for the four entities plus a plain `commerce_amazon_inventory`
  table (SKU → fulfillable quantity per marketplace) with `hook_views_data`; two shipped Views
  (`commerce_amazon_items`, `fulfillments`). Commerce Log categories/templates for order-log
  entries. `.install` has `hook_schema` + update hooks 10001–10009.

## Solution docs

- **Amazon App / Marketplace / Item / Fulfillment entities, fields, regions & endpoints, storage** →
  [agent/entities.md](entities.md)
- **ApiClient: LWA token refresh, `apiCall()`, and the SP-API methods** →
  [agent/api-client.md](api-client.md)
- **Inventory cron sync, order-place fulfillment flow, workflow mapping, events, integration form** →
  [agent/sync-fulfillment.md](sync-fulfillment.md)
