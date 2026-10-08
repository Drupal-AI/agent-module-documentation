<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Eulerian - Commerce Checkout (eulerian_commerce_checkout) — agent index

Submodule of **Eulerian**. Adds the completed-order (conversion) datalayer on the Commerce checkout
"complete" step. Package `Statistics`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version
1.1.0. Depends on `commerce:commerce_checkout` and `eulerian:eulerian`. No routes, permissions,
config or schema of its own.

## Solution doc

- **The helper and the `hook_page_attachments_alter` merge** → [api/datalayer.md](api/datalayer.md)

## What it provides

- **Service** `eulerian_commerce_checkout.helper` (`Services\CommerceCheckoutHelper`, interface
  `CommerceCheckoutHelperInterface`) — `supplyDatalayer()`.
- **Hook class** `Hook\EulerianCommerceCheckoutHooks` (autowired) implementing
  `hook_page_attachments_alter`.

## Mechanism

- `EulerianCommerceCheckoutHooks::pageAttachmentsAlter()` returns early unless the base module has
  set `drupalSettings.eulerian.datalayer`, then merges (`+=`) the helper's contribution.
- `CommerceCheckoutHelper::supplyDatalayer()` (service args `@current_route_match`,
  `@commerce_checkout.checkout_order_manager`) reads the routed `commerce_order`, resolves its
  checkout step with `CheckoutOrderManager::getCheckoutStepId()`, and only proceeds when the
  requested step equals the resolved step **and** equals `complete`.
- `supplyCheckoutCompletedDatalayer($order)` returns `ref => order UUID`,
  `amount => order total number`, `currency => order total currency code`, and `products => [...]`
  ({ ref: product UUID, amount: variation unit price, quantity }) for each purchasable order item.
- Data goes into drupalSettings (JSON-encoded by core). No external HTTP, no credentials, no
  mutation; order access is already enforced by the Commerce checkout route.
