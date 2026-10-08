# Per-customer approval (`field_purchase_orders_authorized`)

The module installs a boolean field on the **user** entity so a store can extend PO terms per
account (a credit decision).

## The field

- Machine name: `field_purchase_orders_authorized` (boolean, cardinality 1, `user.user` bundle).
- Label "Purchase Orders Authorized", description "Authorize this user to use Purchase Orders at
  checkout.", `on_label` "Yes" / `off_label` "No", default `0` (FALSE).
- Installed by `config/install/field.storage.user…` + `field.field.user…`.
- **Hidden by default.** To collect it, move it from *Disabled* into the form at
  `admin/config/people/accounts/form-display`. Editing it requires the `authorize user purchase
  orders` permission (enforced by `hook_entity_field_access`, see [../hooks/hooks.md](../hooks/hooks.md)).

Set it programmatically:

```php
$user->set('field_purchase_orders_authorized', TRUE)->save();
```

## How approval is enforced at checkout

Enforcement lives in `PurchaseOrderGateway::authorizePayment()` (called from `createPayment()`):

- If the gateway's `user_approval` is TRUE **and** the customer has
  `field_purchase_orders_authorized`, that boolean is read: empty/FALSE → not approved.
- If `user_approval` is FALSE, **or** the customer entity lacks the field, the customer is treated as
  approved (`$user_approved = TRUE`).
- Not approved → a warning ("Please contact us about using purchase orders for checkout.") is shown
  and the payment stays in state `new`; `assertAuthorized()` then throws `HardDeclineException`, so
  checkout does not complete.
- Approved **and** the customer's open (`authorized`) PO count is below `limit_open` → payment moves
  to `authorized`.

## Two independent controls

1. `user_approval` (this doc) — decides whether an unapproved customer is *declined* at authorization.
2. The `commerce_purchase_order_auth` condition — decides whether the gateway is even *offered* at
   checkout. Add it on the gateway to hide PO from unapproved customers. See
   [../plugins/plugins.md](../plugins/plugins.md).
