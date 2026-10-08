<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Account Balance shows a customer's outstanding order balance across their orders in Drupal Commerce.

---

Commerce Account Balance integrates with the Drupal Commerce order page to display how much a
customer still **owes** across all of their orders. For a given order it reads Commerce core's
`balance` field (order total minus amount paid) on every order that shares the same customer email,
sums those balances, and shows the total — a "collect money from customers" / accounts-receivable
view rather than a spendable store-credit wallet. It depends on Commerce, Commerce Price and core
User, and lives in the Commerce package. Optional integration with the `currencyapi` module shows
the owed amount converted into other currencies.

The active surface on Drupal 10.3/11 is: a `hook_commerce_order_view_alter` that adds an "Account
Balance" link and a custom template to the order view; a route `/account/balance/{order}` (gated by
the `administer account balances` permission) that renders a table of the customer's orders with
their per-order balances; and a `commerce_account_balance.link_builder` service. The module also
ships an "Account Balance" block, an `AccountBalance` content entity, and an adjustment form, but
these are incomplete on the current 1.0.4 release (the block calls a method the stub entity does not
define, the entity has no field definitions or access handler, and the adjustment form is commented
out). A large amount of Drupal 7 code (Rules deposit actions, a deposit/checkout flow, a transaction
ledger, default views) ships in the module but is inert on Drupal 10/11.

Three permissions govern it: `view account balance` (own balance block), `view any account balance`
(checked by the link builder), and `administer account balances` (the balance route). Because the
figures are financial, grant `administer account balances` and `view any account balance` only to
trusted staff. Setup is enabling the module and assigning permissions; there is no configuration
form.

---

- Show a customer's outstanding order balance on the Commerce order page.
- Sum the balance owed across all orders sharing a customer email.
- Read Commerce core's per-order `balance` field (total minus paid).
- Add an Account Balance link to the order view via a view alter.
- Render a balance route at `/account/balance/{order}` for administrators.
- Provide the `commerce_account_balance.link_builder` service.
- Optionally convert the owed amount via the currencyapi module.
- Provide view / view-any / administer permissions.
- Gate the balance route with `administer account balances`.
- Depend on Commerce, Commerce Price and core User.
- Ship an (incomplete) Account Balance block.
- Ship an (incomplete) AccountBalance content entity.
- Ship an (inactive, commented-out) adjustment form.
- Carry inert Drupal 7 deposit/ledger/checkout code.
- Help reconcile what a customer owes across orders.
- Display balances per order in a table.
- Support multi-currency display of the owed amount.
- Restrict balance figures to trusted staff.
- Treat the balance figures as financial data.
- Require no configuration form to operate.
