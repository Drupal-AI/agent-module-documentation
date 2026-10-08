<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Account Balance block & AccountBalance entity

Both are shipped but incomplete on the installed 1.0.4 release. Documented here so agents don't
assume working store-credit behavior.

## Block — `src/Plugin/Block/AccountBalanceBlock.php`

- `@Block(id = "commerce_account_balance_block", admin_label = "Account Balance",
  category = "Commerce")`. Injects `@current_user`.
- `blockAccess()` — allowed only if the account has **`view account balance`**.
- `build()` — calls `AccountBalance::load($this->currentUser->id())` then
  `$account_balance->getBalance()` and renders the `account_balance` theme with `#cache` context
  `user`.
- Status: **non-functional as shipped** — the `AccountBalance` entity defines no `getBalance()`
  method (see below), and `account-balance.html.twig` is a placeholder. Placing the block would
  render nothing useful (and error if a balance entity row existed). It only ever reflects the
  current user (no other-user parameter), so there is no cross-user exposure.

## Entity — `src/Entity/AccountBalance.php` (+ `AccountBalanceInterface.php`)

- `@ContentEntityType(id = "commerce_account_balance", base_table = "commerce_account_balance",
  entity_keys = {id, uid}, admin_permission = "administer account balances")`, handlers:
  `views_data` = core `EntityViewsData`, `access` = `AccountBalanceAccessControlHandler`.
- Class body is empty (`extends ContentEntityBase implements AccountBalanceInterface {}`); the
  interface is empty too.
- **Incomplete**: no `baseFieldDefinitions()` (so the declared `id`/`uid` keys have no field
  definitions), no `getBalance()`/`setBalance()`, and the referenced access handler class
  `AccountBalanceAccessControlHandler` **does not exist** in the module. The entity is effectively a
  stub and is not installable/usable as a real balance store.

## Adjustment form — `src/Form/AccountBalanceAdjustmentForm.php`

Present but **entirely commented out**: only `getFormId()` (`commerce_account_balance_adjustment_form`)
and the DI boilerplate are live. `buildForm()`/`submitForm()` — including the add/subtract/set
operations and the transaction-log insert — are all commented and not routed anywhere. There is no
active balance-adjustment path in the D10/D11 code.

## Install schema

`hook_schema()` (`.install`) creates the `commerce_account_balance_transaction` table
(transaction_id, type, action, amount int, order_id, uid, time). No D10/D11 code writes to it (the
writers are the inert D7 rules/deposit code — see `../start.md`). The D7-style
`hook_field_schema()`/`hook_uninstall()` (`variable_del`) in the same file are dead on D10/D11.
