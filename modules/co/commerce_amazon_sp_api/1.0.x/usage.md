<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Amazon SP-API connects Drupal Commerce to Amazon's Selling Partner API: it syncs FBA inventory into Drupal, links Amazon SKUs to product variations, and hands placed Commerce orders to Amazon for fulfillment while tracking their status back.

---

Commerce Amazon SP-API integrates the **Amazon Selling Partner API** with Drupal Commerce so that Amazon fulfills your Drupal orders (FBA/MCF-style outbound fulfillment). You register an SP-API application in Amazon Seller Central, self-authorize it, and paste the resulting refresh token into an **Amazon App** entity in Drupal; the module exchanges it for access tokens via Login-with-Amazon over HTTPS. You then create an **Amazon Marketplace** (one Amazon region under that app) and set the conditions under which a placed Commerce order should be sent to Amazon. Cron periodically pulls **FBA inventory** into Drupal (optionally creating **Amazon Item** links to matching product variations by SKU), and when a Commerce order is placed and eligible, the module creates an Amazon **Fulfillment** order, tracks its status, and — if you enable workflow integration — transitions the Drupal order to match. It depends on Commerce Product, Commerce Order and Commerce Shipping. It is a fulfillment/inventory integration, not a payment gateway. It calls Amazon over HTTPS with SP-API (LWA) credentials — treat those credentials as secrets; order fulfillment sends customer shipping details to Amazon. It has no access-control role beyond its admin permissions.

---

- Fulfill Drupal Commerce orders through Amazon (Fulfillment Outbound / FBA) automatically on order placement.
- Sync FBA inventory quantities from an Amazon merchant account into Drupal on a cron schedule (10/15/30/60-minute periods).
- Optionally sync only changes since the last run (incremental sync via `startDateTime`).
- Auto-create Amazon Item links from FBA stock by matching Amazon SKUs to Commerce product variations.
- Restrict which orders go to a marketplace using Commerce conditions plus an AND/OR operator and a shipping-country match.
- Support multiple Amazon regions/marketplaces, each as its own Marketplace entity under a shared Amazon App.
- Choose fulfillment policy (FillOrKill / FillAll / FillAllAvailable) and shipping speed (Standard / Expedited / Priority) per marketplace.
- Guard against overselling with a configurable low-inventory threshold.
- Track each Amazon fulfillment order's status and shipments, updating the local Fulfillment entity on cron.
- Automatically transition the Commerce order workflow from Amazon fulfillment-state changes (configurable per order type).
- Optionally fetch a fulfillment preview and store it on the order's shipments.
- Run against Amazon's sandbox or production endpoints via a per-app mode switch (sandbox-only helpers for simulating inventory/status).
- Record fulfillment activity to Commerce order logs (order created, transition, not-eligible).
- Let other modules alter outbound payloads and supply order-item validation through dispatched events.
- Configure everything from the Drupal admin UI under `/admin/commerce/amazon` and `/admin/commerce/config/amazon-sp-api`, gated by Commerce admin permissions.
