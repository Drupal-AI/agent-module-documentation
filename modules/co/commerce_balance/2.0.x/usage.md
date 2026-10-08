<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Balance

Extends Drupal Commerce with balance functionality: a computed per-order balance, a per-user list of orders with outstanding balance, and a manual "pay later" gateway.

- Exposes how much of an order is still unpaid as a computed `balance` field.
- Lists a user's orders that carry a positive (outstanding) balance.
- Adds a manual "Balance (Pay later)" payment gateway that defers payment capture.
- Useful for account/credit workflows and B2B "pay on invoice" scenarios.

---

## Installation & configuration

- Requires `commerce`, `commerce_order` and `commerce_payment`; enable with `drush en commerce_balance`.
- No dedicated settings form; the fields are added automatically via base field info.
- Add a payment gateway of type "Balance (Pay later)" if you want the manual gateway at checkout.
- Configure display of the `balance` field on order view displays as desired.
- The user balance field can be shown on user displays via the provided formatter.

---

## Usage & API

- `commerce_balance_entity_base_field_info()` adds a computed `balance` field to `commerce_order`.
- It also adds a computed `commerce_balance` entity-reference field to `user` listing orders with positive balance.
- `OrderBalanceFieldItemList` computes the order balance on demand.
- `UserOrdersBalanceFieldItemList` computes the list of a user's outstanding-balance orders.
- `UserOrdersBalanceFormatter` renders the user's outstanding orders/balance.
- The `Balance` payment gateway is a `ManualPaymentGatewayInterface` implementation.
- The manual gateway intentionally no-ops `createPayment`/`receivePayment`/`void`/`refund` so no `commerce_payment` entity is forced during checkout.
- Balance is derived from order/payment totals, not stored as a mutable field, so it cannot be tampered with directly.
- The gateway declares mode "n/a" and requires billing information.
- No custom routes or permissions are added by the module.
- Suitable for invoicing, deposits, and partial-payment tracking.
- Combine with standard Commerce payment gateways to capture the remaining balance later.
- Computed fields update automatically as payments are recorded against the order.
- Because there is no writable balance field, there is no negative-balance manipulation vector.
- Display formatters let admins surface outstanding balances in the UI.
- Works alongside other payment gateways in the same store.
