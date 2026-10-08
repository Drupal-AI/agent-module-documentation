<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Funds (commerce_funds) — agent index

Builds a **funds-management / wallet system** on top of Drupal Commerce. Each user gets per-currency
**account balances** (stored in the `commerce_funds_user_funds` table as a serialized currency→amount
map, keyed by uid; `uid = 1` holds the **site balance**). Users **deposit** money (paid through a real
Commerce checkout that mints a `deposit` product/order), **transfer** funds to other users, create
**escrow** payments they later release or cancel, **convert** between currencies (via
`commerce_exchanger`), **pay for products** with their balance (the `funds_balance` payment gateway),
and send **withdrawal requests** that an administrator approves or declines. Every money move is
recorded as a `commerce_funds_transaction` entity (bundles: `deposit`, `transfer`, `escrow`,
`withdrawal_request`, `conversion`, `payment`) and applied by the central `TransactionManager` service.
Optional configurable **fees** (fixed / percentage / percentage-with-minimum) are added per transaction
type and accrue to the site balance.

The default user flows are standalone forms under `/user/funds/*`; the same operations can also be
embedded on any fieldable entity via the `commerce_funds_transaction` field (a `funds_transaction` render
element with per-type widgets). Admins can disable the standalone form routes and drive everything
through fields instead.

- Depends on (info.yml): `commerce:commerce`, `commerce:commerce_checkout`, `commerce:commerce_order`,
  `commerce:commerce_payment`, `commerce:commerce_product`, `commerce:commerce_store`. Composer requires
  `drupal/commerce:^3.0`.
- Soft/optional integrations (dev-suggested): `commerce_exchanger` (currency conversion + exchange
  rates), `encrypt` (encrypt stored withdrawal-method details), `rules` (perform transactions from
  Rules), `symfony/intl` (validate bank details).
- Core: `^10 || ^11`. Package: `Commerce (contrib)`.
- Has a settings hub: `configure: commerce_funds.settings` (`/admin/commerce/funds`), with sub-forms for
  global / fees / withdrawal methods / exchange rates / mails.
- Provides **permissions** (9) and **config schema**. No drush commands.
- Defines one **plugin type**: `WithdrawalMethod` (manager `plugin.manager.withdrawal_method`).
- Defines a content entity `commerce_funds_transaction` (+ config bundle entity
  `commerce_funds_transaction_type`), a field type, 5 field widgets, a formatter, a render element, 4
  blocks, a payment gateway + payment-method type, 2 checkout panes, 4 views field handlers, 2 validation
  constraints, and a Rules action.

## What you'd do → where

- **Configure fees, withdrawal methods, exchange rates, mails, or disable the default forms** →
  [configure/settings.md](configure/settings.md)
- **Understand the balance model, the TransactionManager/FeesManager/ProductManager services, the
  transaction entity + events + Rules action, or move funds from code** → [api/services.md](api/services.md)
- **Know who can deposit/transfer/withdraw/administer and how routes/entity access are gated** →
  [permissions/permissions.md](permissions/permissions.md)
- **Embed a transaction form on an entity (the `commerce_funds_transaction` field), pay with balance, or
  use the blocks / checkout panes** → [fields/transaction-field.md](fields/transaction-field.md)
- **Add a custom withdrawal method (bank account / check / paypal / skrill / your own)** →
  [plugins/withdrawal-methods.md](plugins/withdrawal-methods.md)

## Key facts (real machine names)

- **User routes:** `commerce_funds.deposit` (`/user/funds/deposit`), `commerce_funds.transfer`
  (`/user/funds/transfer`), `commerce_funds.escrow` (`/user/funds/escrow`), `commerce_funds.escrow.release`
  / `commerce_funds.escrow.cancel` (`/user/funds/escrow/manage/{release|cancel}/{transaction_hash}`),
  `commerce_funds.withdraw` (`/user/funds/withdraw`), `commerce_funds.convert_currencies`
  (`/user/funds/converter`), `commerce_funds.withdrawal_methods` /`.edit`
  (`/user/{user}/withdrawal-methods[/{method}/edit]`).
- **Admin routes:** `commerce_funds.settings` (`/admin/commerce/funds`) and `.settings.global` / `.fees`
  / `.withdrawal_methods` / `.exchange_rates` / `.mails`; `commerce_funds.admin.withdrawal_requests.approve`
  / `.decline` (`/admin/commerce/funds/withdrawals/{approve|decline}/{request_hash}`).
- **Services:** `commerce_funds.transaction_manager` (`TransactionManager`),
  `commerce_funds.fees_manager` (`FeesManager`), `commerce_funds.product_manager` (`ProductManager`),
  `plugin.manager.withdrawal_method`, `commerce_funds.route_subscriber`,
  `commerce_funds.update_account_balance` (order-paid event subscriber).
- **Entity:** content entity `commerce_funds_transaction` (base table `commerce_funds_transactions`;
  bundle entity `commerce_funds_transaction_type`; access handler `TransactionAccessControlHandler`).
  Balance table: `commerce_funds_user_funds` (`uid`, serialized `balance`).
- **Permissions:** `administer funds`, `administer transactions`, `administer withdrawal requests`,
  `view own transactions`, `deposit funds`, `create escrow payment`, `transfer funds`, `withdraw funds`,
  `convert currencies`.
- **Plugin type:** `WithdrawalMethod` — attribute `…\Attribute\WithdrawalMethod`, annotation
  `…\Annotation\WithdrawalMethod`, interface `WithdrawalMethodInterface`, dir `Plugin/Funds/WithdrawalMethod`,
  manager `plugin.manager.withdrawal_method`, alter hook `commerce_funds_withdrawal_methods_info_alter`.
  Bundled ids: `bank_account`, `check`, `paypal`, `skrill`.
- **Field:** field type `commerce_funds_transaction`; widgets `commerce_funds_transaction_transfer`
  (default), `_deposit`, `_withdrawal`, `_escrow`, `_conversion`; formatter `commerce_funds_transaction`;
  render element `funds_transaction`.
- **Commerce plugins:** payment gateway `funds_balance` (`BalanceGateway`), payment-method type
  `funds_wallet`, checkout panes `deposit_completion_message` + a `PaymentInformation` override.
- **Blocks:** `user_balance`, `funds_operations`, `admin_site_balance`, `admin_user_balances`.
- **Views field handlers:** `commerce_funds_amount`, `commerce_funds_balance`,
  `commerce_funds_escrow_operations`, `commerce_funds_withdrawal_operations`. Views:
  `commerce_funds_transactions` (admin), `commerce_funds_user_transactions`,
  `commerce_funds_withdrawal_requests`.
- **Constraints:** `IssuerEqualsCurrentUser`, `NetAmountBelowBalance`. **Rules action:**
  `commerce_funds_perform_transaction`. **Libraries:** `calculate_fees`, `delayed_submit`, `manage_fields`.
