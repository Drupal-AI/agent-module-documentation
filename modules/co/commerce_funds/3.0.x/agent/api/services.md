<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, entity & balance API

## The balance model

Balances live in one table, `commerce_funds_user_funds`:

- `uid` (int, primary key)
- `balance` (serialized blob) — a PHP-serialized `['<CURRENCY_CODE>' => '<amount>', …]` map.

Row `uid = 1` is the **site balance** (created at install by `commerce_funds_install()`); fees accrue
there. Note: `addFundsToBalance()`/`removeFundsFromBalance()` write a user's balance under `uid = 1`
instead of their own uid when the account has the `administer transactions` permission — i.e. admins'
wallet == site balance by design.

## `commerce_funds.transaction_manager` — `TransactionManager` (`src/TransactionManager.php`)

The one place balances change. Constructor args: `entity_type.manager`, `database`, `current_user`,
`config.factory`, `messenger`, `plugin.manager.mail`, `token`.

- `performTransaction(TransactionInterface $transaction)` — dispatches on `$transaction->bundle()` and
  applies the balance effects, then saves the transaction with a new status. Effects:
  - `deposit` → `addFundsToBalance(issuer)` + `updateSiteBalance` → status `Completed`.
  - `transfer` / `payment` → `addFundsToBalance(recipient)` + `removeFundsFromBalance(issuer)` +
    `updateSiteBalance` → `Completed`.
  - `escrow` → `removeFundsFromBalance(issuer)` → status `Pending` (released/canceled later by the
    confirm forms).
  - `withdrawal_request` → `removeFundsFromBalance(issuer)` + `updateSiteBalance` → `Completed` (only
    reached via admin approval; guarded by `$transaction->access('create', currentUser)`).
  - `conversion` → `removeFundsFromBalance(issuer)` + `addFundsToBalance(recipient)` → `Completed`.
  - Throws `TransactionException` if already `Completed`, or if the per-bundle
    `$transaction->access('create', …)` check fails.
- `addDepositToBalance(OrderInterface $order)` — called on order-paid; credits the deposited amount
  (order item total), records the fee (order total − item total), and performs the deposit transaction.
- `addFundsToBalance($transaction, AccountInterface $account)` / `removeFundsFromBalance(...)` — low-level
  read-modify-write of a currency slot; `merge()` into `commerce_funds_user_funds`; invalidate cache tag
  `funds_balance:<uid>`. (Escrow-cancel and conversion/payment special-case which amount field is used.)
- `updateSiteBalance($transaction)` — add `$transaction->getFee()` to the `uid = 1` row.
- `loadAccountBalance(AccountInterface $account)` → `array` (currency→amount). `loadSiteBalance()` → same
  for `uid = 1`.
- `loadTransactionByHash($hash)` → the `commerce_funds_transaction` with that `hash`.
- `sendTransactionMails($transaction)` — sends the configured `mail_*` notifications (token-replaced).
- `generateConfirmationMessage($transaction)` — adds the localized status message to the messenger.

## `commerce_funds.fees_manager` — `FeesManager` (`src/FeesManager.php`)

- `calculateTransactionFee($brut_amount, $currency, $type)` → `['net_amount' => …, 'fee' => …]`. For
  `type === 'payment'` net = brut − fee; otherwise net = brut + fee. Returns zero fee for
  `administer transactions` users.
- `calculateOrderFee(Order)` / `applyFeeToOrder(Order)` — deposit-checkout fee handling (adds a `fee`
  product line).
- `getExchangeRates()` / `convertCurrencyAmount($amount, $from, $to)` / `printConvertedAmount(...)` —
  require `commerce_exchanger`; read the configured `exchange_rate_provider`.
- `printTransactionFees($type)` / `printPaymentGatewayFees($gateway, $currency, $type)` — human fee
  descriptions used in form field descriptions.

## `commerce_funds.product_manager` — `ProductManager` (`src/ProductManager.php`)

Creates the throwaway `deposit`/`fee` Commerce products, variations and orders used to route a deposit
through real checkout: `createProduct($type, $amount, $currency)`, `createOrder($variation, $transaction = NULL)`,
`updateOrder(...)`.

## Entity: `commerce_funds_transaction` (`src/Entity/Transaction.php`)

Content entity, base table `commerce_funds_transactions`, bundle key `type`, `fieldable = FALSE`,
`admin_permission = administer transactions`, access handler `TransactionAccessControlHandler`. Bundles
are `commerce_funds_transaction_type` config entities. Base fields: `issuer` (user ref, owner/uid),
`recipient` (user ref, `IssuerEqualsCurrentUser` constraint), `method` (string, default `internal`),
`created`, `brut_amount` (decimal, `NetAmountBelowBalance` constraint), `net_amount`, `fee`, `currency`
+ `from_currency` (commerce_currency refs), `status` (string), `hash` (random, default via
`Transaction::hashGenerate()` = `Crypt::randomBytesBase64(12)`), `notes` (text_long). Statuses come from
`Transaction::TRANSACTION_STATUS` (`Completed`, `Pending`, `Canceled`, `Declined`, `Approved`).
Getters/setters: `getIssuer()/getIssuerId()/setIssuerId()`, `getRecipient()/…`, `getBrutAmount()`,
`getNetAmount()`, `getFee()`, `getCurrency()/getCurrencyCode()`, `getFromCurrency()`, `getStatus()`,
`getMethod()`, `getHash()`, `getNotes()`.

## Events, hooks, tokens

- Event subscriber `commerce_funds.update_account_balance` (`EventSubscriber\OrderUpdateSubscriber`)
  listens to `OrderEvents::ORDER_PAID` (priority 100) and, for a paid `deposit` order, calls
  `addDepositToBalance()`.
- `.module` hooks: `hook_help`, `hook_theme`, `hook_mail` (key `commerce_funds_transaction`),
  `hook_user_cancel` + `hook_ENTITY_TYPE_predelete` (anonymize a deleted user's transactions to uid 0),
  `hook_commerce_currency_predelete` (block deleting an in-use currency),
  `hook_commerce_checkout_pane_info_alter`, and the checkout `#validate`
  `commerce_funds_payment_validate` (enforces enough balance + matching currency when paying with a
  `funds_wallet` method).
- Tokens: `commerce_funds.tokens.inc` (transaction + balance tokens for mail bodies).

## Rules action

`commerce_funds_perform_transaction` (`Plugin\RulesAction\TransactionPerform`) — takes an
`entity:commerce_funds_transaction` context, sets fee/net (from the rule or config), saves, and calls
`TransactionManager::performTransaction()`. Lets a site builder move funds from a Rules reaction.
