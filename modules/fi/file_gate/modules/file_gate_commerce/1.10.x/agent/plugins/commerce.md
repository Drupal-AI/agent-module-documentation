<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate Commerce — the `commerce` gate method & entitlement checker

## The gate method — `CommerceGate`
`src/Plugin/GateMethod/CommerceGate.php`, `#[GateMethod(id: 'commerce', …)]`, `final`, extends `GateMethodBase`.

- `mint()` → `NULL`: access is **decided live** on every download, so a refund/expiry/revocation takes effect
  immediately (no cached grant to outlive it).
- `grants(FileInterface $file, Request $request)`: reads the field `sku` setting; **empty → FALSE** (fail closed);
  otherwise returns `$this->entitlementChecker->isEntitled($this->currentUser, $sku, $file)`. The requester is the
  live Drupal session's `current_user`, so the buyer must be logged in.
- Field settings: `sku` (the product-variation SKU whose purchase grants the file). `fieldSettingsSubmit()` drops
  an empty SKU.

To use it: on a gated private file/image field pick method "Commerce (purchase / entitlement)" and set the SKU.

## The entitlement contract — `EntitlementCheckerInterface`
`isEntitled(AccountInterface $account, string $entitlement, FileInterface $file): bool` — **must fail closed**;
runs live on every download. `$entitlement` is the field's SKU for the bundled checker, opaque for a custom one.

## Bundled checker — `CommerceEntitlementChecker`
Service `file_gate_commerce.entitlement_checker` (args: `@entity_type.manager`, `@logger.channel.file_gate`).
Duck-typed against Commerce entity APIs so the submodule loads without Commerce PHP classes; any throw is logged
and returns FALSE.

- Fail-closed guards: anonymous account, empty entitlement, or no `commerce_order` definition → FALSE.
- **SKU-scoped path** (`entitledViaSkuIndex`, when `commerce_product_variation` + `commerce_order_item` exist):
  find variations with the SKU (≤100) → order items whose `purchased_entity` is one of them (≤500) → the parent
  orders, filtered to `uid = account` **and** `state IN (completed, fulfillment)` (≤1). All entity queries use
  `accessCheck(FALSE)` but are bound to the requesting account's own orders and completed state, so this is not an
  entitlement bypass — it answers "did *this* user complete a purchase of this SKU?".
- **Legacy scan** (`entitledViaOrderScan`, fallback): load the account's 50 most recent `completed`/`fulfillment`
  orders (bounded for large B2B accounts) and return TRUE if any contains a purchased variation whose
  `getSku()` matches.

## Overriding the checker
Register your own service (same id, or an alias) implementing `EntitlementCheckerInterface` to gate on a licence
entity, a subscription, or a remote API. Keep it fail-closed and cheap — it runs on **every** download request.
Commerce then becomes optional (a status-report warning notes the bundled checker needs it, but your override
does not).
