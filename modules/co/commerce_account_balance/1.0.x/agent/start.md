<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Account Balance (commerce_account_balance) — agent index

Displays a customer's **outstanding order balance across all their orders** on the Drupal Commerce
order page. For a given order it reads Commerce core's `balance` field (total_price − total_paid =
amount still **owed**) on every order sharing the same customer email, sums them, and shows the
total. Purpose (per project page): "collect money from customers" — i.e. an accounts-receivable /
amount-owed view, **not** a spendable store-credit wallet. Package `Commerce`. Core `^10.3 || ^11`.
License GPL-2.0-or-later. Installed **1.0.4** (version dir `1.0.x`).

## Dependencies

- Drupal modules (`.info.yml`): **`commerce`**, **`commerce_price`**, core **`user`**.
- Optional soft integration: **`currencyapi`** (if enabled, converts the balance to other
  currencies for display — `moduleExists('currencyapi')` in `.module`).
- No third-party Composer/PHP libraries; `composer.json` present but adds nothing beyond the above.

## What it actually provides in D10/D11 (from source)

- **Order-view integration** — `hook_commerce_order_view_alter()` (`.module`) swaps the order
  render into the custom template `commerce_order_account_balance__admin` and, when the order has an
  email and `order.balance.number >= 1`, attaches an "Account Balance" link built by the
  `commerce_account_balance.link_builder` service.
- **Balance-summary route** — `commerce_account_balance.account_balance` →
  `/account/balance/{order}` (`.routing.yml`), permission **`administer account balances`**,
  `Controller/AccountBalanceController::viewBalance()`. Loads all orders with the same `mail` (up to
  500), sums their `balance` fields, renders the `commerce_orders_balance_table` theme.
- **Block** `commerce_account_balance_block` (`Plugin/Block/AccountBalanceBlock`), permission
  **`view account balance`** — intended to show the current user's balance. NOTE: it is
  non-functional as shipped (calls `AccountBalance::load()->getBalance()`, a method the entity does
  not define).
- **Content entity** `commerce_account_balance` (`Entity/AccountBalance`) — declared but a stub: no
  `baseFieldDefinitions()`, no getters/setters, and it names an access handler class
  (`AccountBalanceAccessControlHandler`) that does not exist in the codebase. Not usable as shipped.
- **Permissions** (`.permissions.yml`): `view account balance`, `view any account balance`,
  `administer account balances`. Only `administer account balances` (route) and
  `view account balance` (block) are wired to anything; `view any account balance` is checked only
  inside the link builder.
- **Themes** (`hook_theme`): `account_balance`, `commerce_order_account_balance__admin`,
  `commerce_orders_balance_table`, `commerce_orders_balance_in_currencies` (templates in
  `templates/`; note `account-balance.html.twig` is a placeholder stub). Library `orders_balance`
  (CSS only). `hook_schema` creates the D7-era `commerce_account_balance_transaction` table.

## Legacy / dead code (Drupal 7 — NOT active on D10/D11)

`commerce_account_balance.rules.inc`, `.rules_defaults.inc`, `includes/*.inc`
(checkout pane, deposit forms, page callbacks) and `includes/views/*.views_default.inc` use D7 APIs
(`variable_get`, `entity_metadata_wrapper`, `rules_invoke_component`, `hook_menu`,
`hook_views_default_views`, ctools modal). These hooks do not fire on D10/D11, so the "deposit
money", "purchase with balance", checkout-pane and transaction-ledger features they describe are
**inert** on the installed version. Treat the README's feature list as a roadmap, not shipped
behavior.

## Solution docs

- **Order-view integration, balance route/controller, link builder, currencyapi, table theme** →
  [order-integration.md](order-integration.md)
- **Account Balance block & the AccountBalance entity stub (both incomplete)** →
  [blocks/account-balance-block.md](blocks/account-balance-block.md)
