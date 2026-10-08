<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Eulerian - Commerce Product (eulerian_commerce_product) — agent index

Submodule of **Eulerian**. Adds product data to the Eulerian datalayer on Commerce product-canonical
pages. Package `Statistics`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.1.0.
Depends on `commerce:commerce_product` and `eulerian:eulerian`. No routes, permissions, config or
schema of its own.

## Solution doc

- **The helper, the `hook_page_attachments_alter` merge, and the extension event** →
  [api/datalayer.md](api/datalayer.md)

## What it provides

- **Service** `eulerian_commerce_product.helper` (`Services\CommerceProductHelper`, interface
  `CommerceProductHelperInterface`) — `supplyDatalayer()`.
- **Hook class** `Hook\EulerianCommerceProductHooks` (autowired) implementing
  `hook_page_attachments_alter` (attribute `#[Hook('page_attachments_alter')]`; legacy wrapper in
  the `.module`).
- **Event** `Event\CommerceProductParamsEvent` — dispatched while building the product datalayer so
  subscribers can set `prdparam-*` attributes.

## Mechanism

- `EulerianCommerceProductHooks::pageAttachmentsAlter()` returns early unless the base module has
  already set `drupalSettings.eulerian.datalayer`, then merges (`+=`) the helper's contribution.
- `CommerceProductHelper::supplyDatalayer()` acts only on `entity.commerce_product.canonical` with a
  `commerce_product` in the request; it returns `prdref => $product->uuid()`,
  `prdname => $product->label()`, then dispatches `CommerceProductParamsEvent` and appends each
  returned parameter as `prdparam-<name> => (string) value`.
- Data is placed into drupalSettings (JSON-encoded by core). No routes, no external HTTP, no
  credentials, no mutation.
