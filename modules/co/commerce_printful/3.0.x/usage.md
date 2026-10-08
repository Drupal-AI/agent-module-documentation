<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Printful integrates Drupal Commerce with Printful for print-on-demand product sync and order fulfillment.

---

Commerce Printful integrates Drupal Commerce with Printful — the print-on-demand drop-shipping and
fulfillment service. It syncs Printful sync products and their variants into Commerce products, gets
live shipping rates through a `printful_shipping` shipping method, sends paid orders to Printful for
fulfillment (per shipment, as drafts or confirmed), and receives Printful `package_shipped`
fulfillment updates on a webhook that records the shipment's tracking code, carrier, and shipped
time. It depends on Drupal Commerce (plus `commerce_shipping` and `commerce_currency_resolver`),
provides Drush commands (`printful:test`, `printful:sync-products`) and its own permissions, in the
Commerce (contrib) package. Version 3.0.1 targets Commerce 3.x and Drupal 11.

Use it to fulfill Commerce orders through Printful without holding stock. Create a `printful_store`
config entity with your Printful API key, the Commerce store, the product type, and the color/size/
image attribute mapping; sync products from `/admin/commerce/config/printful/synchronization` (or
`drush psp`); add the "Printful dropshipping" shipping method to your shippable variation type; and
enable order synchronization (optionally as drafts for review). Store the Printful **API key as a
secret** — an environment variable exposed through a Key entity rather than raw exportable config —
and run the site over **HTTPS**. Payment is handled by your own Commerce payment gateway; Printful
bills the card on file per order.

---

- Integrate Commerce with Printful for print-on-demand.
- Sync Printful products and variants into Commerce.
- Map color / size / image attributes to Commerce fields.
- Get live Printful shipping rates via `printful_shipping`.
- Send paid orders to Printful per shipment (drafts or confirmed).
- Receive `package_shipped` webhook updates (tracking, carrier, shipped time).
- Depend on Commerce, commerce_shipping, commerce_currency_resolver.
- Provide Drush commands (`printful:test`, `printful:sync-products`).
- Provide the `administer commerce printful` permission.
- Configure per store via the `printful_store` config entity.
- Store the Printful API key as a secret (env var + Key entity).
- Operate the site over HTTPS.
- Choose draft export while testing fulfillment.
- Add a Commerce payment gateway to collect from customers.
- Note: Printful `external_id` is the shipment id, not the order id.
