<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Order-view integration, balance route & link builder

The functional core of the module on D10/D11. It surfaces the total amount a customer still **owes**
across all their orders (Commerce core's per-order `balance` field = `total_price − total_paid`).

## Order view alter

`commerce_account_balance_commerce_order_view_alter(&$build, OrderInterface $order, $display)`
(`.module`):

1. Returns early if the order has no email (`$order->getEmail()`) or `order.balance.number < 1`
   (nothing owed).
2. Builds a balance link via the `commerce_account_balance.link_builder` service
   (`getBalanceLink($order)`).
3. If `currencyapi` is enabled, calls `currencyapi.service` `getAllRates()` / `convert()` to render
   the balance in each non-default currency via the `commerce_orders_balance_in_currencies` theme.
4. Attaches `commerce_account_balance/order-page` library (NOTE: this library name is **not**
   defined in `.libraries.yml`, which only defines `orders_balance`), sets a `#weight: -999`
   `account_balance_link` container, and forces `$build['#theme'] = 'commerce_order_account_balance__admin'`
   (the custom admin order template in `templates/`).

## Link builder — `src/AccountBalanceLinkBuilder.php`

Service `commerce_account_balance.link_builder` (args `@current_user`, `@entity_type.manager`).
`getBalanceLink($order)`:

- Resolves the customer (or falls back to the order email for anonymous orders; returns `NULL` if
  neither).
- Permission gate: returns `NULL` unless the current user has **`view any account balance`** or is
  the order's own customer. (Implementation bug: the own-customer branch references an undefined
  `$customer` variable instead of `$data['customer']`, so this check can raise a PHP error rather
  than evaluate cleanly.)
- Loads all orders sharing the order's `mail`, sums their balances, and returns a `Link` render
  array pointing at `commerce_account_balance.account_balance` (`/account/balance/{order}`), which
  itself requires `administer account balances` — so a non-admin who sees the link gets 403 on click.

## Balance-summary route & controller

- Route `commerce_account_balance.account_balance` → `/account/balance/{order}` (`order` upcast to
  `entity:commerce_order`), requirement `_permission: 'administer account balances'`.
- `Controller/AccountBalanceController::viewBalance($order)`: reads `$order->get('mail')->value`,
  calls `commerce_account_balance_get_mail_orders($mail)` (entityQuery on `commerce_order` where
  `mail == $mail`, `accessCheck(TRUE)`, range 0–500) and `commerce_account_balance_get_email_balance()`
  (sums each order's `balance` number, formats via `commerce_price_format`), and renders the
  `commerce_orders_balance_table` theme with the per-order rows.
- `getUserBalance(UserInterface $user)` helper exists but is unused; it reads an optional
  `field_account_balance` user field.

## Helper functions (`.module`)

- `commerce_account_balance_get_mail_orders($mail)` — parameterized entityQuery (no raw SQL).
- `commerce_account_balance_get_email_balance(array $orders)` — sums `balance` numbers, formats in
  the current store's default currency (`commerce_account_balance_currency()` via
  `commerce_store.current_store`).
- `commerce_account_balance_calculate_order_paid_amount()` / `_format_price()` — used by the
  procedural `theme_commerce_orders_balance_table()` fallback (which calls unprefixed
  `calculate_order_paid_amount()` / `format_price()` and would error if invoked; the twig template
  is used in practice).

## Templates

- `commerce-order-account-balance--admin.html.twig` — full admin order layout; renders
  `order.balance`, the account-balance details/link, and the currencies block.
- `commerce-orders-balance-table.html.twig` — table of orders (ID, date, status, total, paid,
  balance), values rendered through Twig auto-escaping / `commerce_price_format`.
- `commerce-orders-balance-in-currencies.html.twig` — list of converted currency amounts.
- `account-balance.html.twig` — placeholder stub (literal text "this is account balance twig tpl").
