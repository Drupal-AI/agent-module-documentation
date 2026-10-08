<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The transaction field, blocks & Commerce plugins

## `commerce_funds_transaction` field

An entity-reference-like field type (`Plugin\Field\FieldType\FundsTransactionItem`, id
`commerce_funds_transaction`, category `funds_transaction`, cardinality 1) that stores the id of a
`commerce_funds_transaction` entity. Attach it to any fieldable entity to embed a money-operation form
there instead of using the standalone `/user/funds/*` pages (pair this with
`global.disable_funds_forms`, see [../configure/settings.md](../configure/settings.md)).

Field settings (`field.field_settings.commerce_funds_transaction`): `enable_notes` (bool),
`available_currencies` (sequence of currency codes; empty = all).

**Widgets** (all target `commerce_funds_transaction`; pick one per form display to choose the operation):
- `commerce_funds_transaction_transfer` (default) — `FundsTransactionTransferWidget`
- `commerce_funds_transaction_deposit` — `FundsTransactionDepositWidget`
- `commerce_funds_transaction_withdrawal` — `FundsTransactionWithdrawalWidget`
- `commerce_funds_transaction_escrow` — `FundsTransactionEscrowWidget`
- `commerce_funds_transaction_conversion` — `FundsTransactionConversionWidget`
(shared base `FundsTransactionWidgetBase`; each sets `#transaction_type`).

**Formatter:** `commerce_funds_transaction` (`FundsTransactionTransferFormatter`) — renders the referenced
transaction via the `field__funds_transaction` theme hook / `field--funds-transaction.html.twig`.

## `funds_transaction` render element (`src/Element/FundsTransaction.php`)

The engine behind the widgets. `#type => 'funds_transaction'` with `#transaction_type`
(`transfer|escrow|withdrawal_request|conversion|deposit`), `#available_currencies`, `#notes_enabled`.
Its `valueCallback()` validates (`validateTransaction()`) then creates the `commerce_funds_transaction`
entity (issuer forced to `\Drupal::currentUser()->id()`, recipient from the username autocomplete or
self), returning the new transaction id. `processFundsTransaction()` builds the amount/currency/username/
methods/notes sub-elements and sets `#access` from the per-type permission map (`transfer`→`transfer
funds`, etc.). On the host form's save, `updateFundsTransaction()` (entity builder) calls
`performTransaction()` for non-deposit/withdrawal types (withdrawal is set `Pending`; deposit is handled
at checkout). The standalone `.module` submit `commerce_funds_create_deposit_submit` does the same for
deposit fields (creates the order and redirects to checkout).

## Pay for products with a balance — payment gateway

- Payment gateway `funds_balance` (`Plugin\Commerce\PaymentGateway\BalanceGateway`), payment-method type
  `funds_wallet` (`BalanceMethodType`), add/edit form `PluginForm\Funds\BalanceMethodAddForm`. A wallet
  payment method stores `balance_id` + `currency`.
- `createPayment()` → `doPayment()` creates a `payment` transaction per order item (issuer = payer,
  recipient = product owner) and performs it, then marks the payment `completed`.
- The checkout `#validate` `commerce_funds_payment_validate()` enforces, before payment, that the chosen
  wallet's currency matches the order and the balance covers the total (else it links to a deposit).

## Deposit checkout panes

- `deposit_completion_message` (`CheckoutPane\DepositCompletionMessage`) — the deposit "thank you" pane
  (theme `deposit_completion_message`).
- `CheckoutPane\DepositPaymentInformation` — a subclass of Commerce's `PaymentInformation` swapped in via
  `commerce_funds_commerce_checkout_pane_info_alter()` for the deposit flow (not a standalone plugin id).

## Blocks

- `user_balance` (`FundsUserBalance`) — the current user's balance (theme `user_balance`).
- `funds_operations` (`FundsUserOperations`) — links to the available operations (theme `user_operations`).
- `admin_site_balance` (`FundsAdminSiteBalance`) — the site balance (theme `admin_site_balance`,
  `administer transactions`).
- `admin_user_balances` (`FundsAdminUserBalances`) — all user balances (theme `admin_user_balances`,
  `administer transactions`).

## Views field handlers

`commerce_funds_amount` (formatted money, `MoneyAmount`), `commerce_funds_balance` (`FundsBalance`),
`commerce_funds_escrow_operations` (`EscrowOperations` — cancel/release links on the user escrow
displays), `commerce_funds_withdrawal_operations` (`WithdrawalOperations` — approve/decline links, shown
only to `administer withdrawal requests`). Provided views: `commerce_funds_transactions`,
`commerce_funds_user_transactions`, `commerce_funds_withdrawal_requests`.
