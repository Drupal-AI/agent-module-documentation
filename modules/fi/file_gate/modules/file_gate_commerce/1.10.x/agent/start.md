<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate Commerce (file_gate_commerce) — agent index

Optional submodule of **File Gate** adding the `commerce` gate method — deliver a gated file only to a buyer or
licensee, re-checked live on every download. Version **1.10.x**, core `^11.4 || ^12`, package Security. Depends on
`file_gate:file_gate`; the bundled checker needs Drupal Commerce (`commerce_order`). Enable with
`drush en file_gate_commerce`. No permissions, no config schema.

## Provides
- **Gate method** `commerce` — `\Drupal\file_gate_commerce\Plugin\GateMethod\CommerceGate`. `mint()` returns
  `NULL` (live decision); `grants()` reads the field's `sku` setting (empty → fail closed) and calls the
  entitlement checker for the current user. Field setting: `sku`.
- **Service** `file_gate_commerce.entitlement_checker` = `CommerceEntitlementChecker` implementing
  `EntitlementCheckerInterface::isEntitled(AccountInterface $account, string $entitlement, FileInterface $file)`.
  **Swap this service** to gate on licences or an external API.

## Bundled checker
`CommerceEntitlementChecker` (duck-typed against Commerce so it loads without Commerce classes; fails closed when
Commerce is absent or the account is anonymous). Completed states: `completed`, `fulfillment`. It prefers a
SKU-scoped query (variations → order items → the account's own matching orders, each `accessCheck(FALSE)` but
bound to the requesting account's `uid` + completed state + the matching SKU, all range-capped), then falls back
to a bounded scan of the account's 50 most recent completed orders.

See [plugins/commerce.md](plugins/commerce.md) for the method, the checker, and how to override it.
