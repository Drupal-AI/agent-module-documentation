<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Eulerian - Commerce Cart (eulerian_commerce_cart) — agent index

Submodule of **Eulerian**. Adds cart data to the Eulerian datalayer on the Commerce cart page.
Package `Statistics`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.1.0. Depends on
`commerce:commerce_cart` and `eulerian:eulerian_commerce_product` (which in turn depends on the base
`eulerian`). No routes, permissions, config or schema of its own.

## Solution doc

- **The helper and the `hook_page_attachments_alter` merge** → [api/datalayer.md](api/datalayer.md)

## What it provides

- **Service** `eulerian_commerce_cart.helper` (`Services\CommerceCartHelper`, interface
  `CommerceCartHelperInterface`) — `supplyDatalayer()`.
- **Hook class** `Hook\EulerianCommerceCartHooks` (autowired) implementing
  `hook_page_attachments_alter`.

## Mechanism

- `EulerianCommerceCartHooks::pageAttachmentsAlter()` returns early unless the base module has set
  `drupalSettings.eulerian.datalayer`, then merges (`+=`) the helper's contribution.
- `CommerceCartHelper::supplyDatalayer()` (service args `@current_route_match`,
  `@commerce_cart.cart_provider`) acts only on route `commerce_cart.page`; it returns
  `scart => 1`, `scartcumul => 0` and `products => [...]` where each item is
  `{ ref: product UUID, amount: variation unit price number, quantity: order-item quantity }`,
  built by iterating `cartProvider->getCarts()` and their purchasable-entity line items.
- Data goes into drupalSettings (JSON-encoded by core). No external HTTP, no credentials, no
  mutation.
