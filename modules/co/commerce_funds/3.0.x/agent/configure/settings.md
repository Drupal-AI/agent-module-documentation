<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Commerce Funds

All admin configuration lives under `/admin/commerce/funds` (route `commerce_funds.settings`, a menu
hub gated by `administer funds+administer transactions+administer withdrawal requests`). Local tasks map
to five config forms, each requiring the `administer funds` permission. Everything is stored in the
single config object **`commerce_funds.settings`** (schema: `config/schema/commerce_funds.schema.yml`).

## The five settings forms (routes → form class → config keys)

- **Global** — `commerce_funds.settings.global` (`/admin/commerce/funds/configure/global`) →
  `Form\ConfigureGlobal`. Writes `global`:
  - `global.disable_funds_forms` (sequence): names of default form routes to remove — values are the
    route suffixes `transfer`, `deposit`, `withdraw`, `escrow`, `convert_currencies`. See "Disabling the
    default forms" below.
  - `global.add_rt_fee_calculation` (bool): show live fee calculation under the amount field (attaches
    the `commerce_funds/calculate_fees` JS library).
- **Fees** — `commerce_funds.settings.fees` (`/configure/fees`) → `Form\ConfigureFees`. Writes the `fees`
  sequence. Keys follow the pattern `<type>_rate` and `<type>_fixed` where `<type>` is `transfer`,
  `escrow`, `deposit_<payment_gateway>`, `withdraw_<method>`, `payment`. `*_rate` is a percentage,
  `*_fixed` is a flat amount; when both are set the larger of (amount×(1+rate)) and (amount+fixed) is
  used (`FeesManager::calculateTransactionFee`). Users with `administer transactions` are charged no fee.
- **Withdrawal methods** — `commerce_funds.settings.withdrawal_methods` (`/configure/withdrawal-methods`) →
  `Form\ConfigureWithdrawals`. Writes `withdrawal_methods` (sequence of enabled `WithdrawalMethod` plugin
  ids: `bank_account`, `check`, `paypal`, `skrill`). Also writes `encryption_profile` (id of an `encrypt`
  encryption profile) when the `encrypt` module is installed — used to encrypt stored payout details.
- **Exchange rates** — `commerce_funds.settings.exchange_rates` (`/configure/exchange-rates`) →
  `Form\ConfigureExchangeRates`. Writes `exchange_rate_provider` (id of a `commerce_exchanger`
  `commerce_exchange_rates` config entity). Requires the `commerce_exchanger` module; conversion is
  unavailable without it.
- **Mails** — `commerce_funds.settings.mails` (`/configure/mails`) → `Form\ConfigureMails`. Writes one
  mapping per notification: `mail_transfer_issuer`, `mail_transfer_recipient`,
  `mail_escrow_created_{issuer,recipient}`, `mail_escrow_canceled_by_issuer_{issuer,recipient}`,
  `mail_escrow_canceled_by_recipient_{issuer,recipient}`, `mail_escrow_released_{issuer,recipient}`,
  `mail_withdrawal_declined`, `mail_withdrawal_approved`. Each has `subject` (text), `body` (text_format)
  and `activated` (bool). Bodies/subjects are token-replaced with the `commerce_funds_transaction`,
  `commerce_funds_balance`, and `commerce_funds_balance_uid` tokens (see `commerce_funds.tokens.inc`).
  Config is translatable (`commerce_funds.config_translation.yml`).

## Disabling the default forms

`Routing\RouteSubscriber::alterRoutes()` reads `global.disable_funds_forms` and removes each route named
`commerce_funds.<form_name>` from the collection. Use this when you drive operations through the
`commerce_funds_transaction` field / `funds_transaction` element instead of the standalone `/user/funds/*`
pages (see [fields/transaction-field.md](../fields/transaction-field.md)). A removed route 404s.

## Install-time config (config/install)

Enabling the module installs, among others: the six transaction-type bundles
(`commerce_funds.commerce_funds_transaction_type.{deposit,transfer,escrow,withdrawal_request,conversion,payment}`),
a `deposit` checkout flow, `deposit`/`fee` product types + variations + order types, the `funds_payment`
profile type, a `field_transaction` entity-reference field on the `deposit` order bundle, and default
`commerce_funds.settings`. Optional views (`config/optional`): `commerce_funds_transactions`,
`commerce_funds_user_transactions`, `commerce_funds_withdrawal_requests`.

## Currencies

The set of currencies a user may pick is derived from enabled `commerce_currency` entities
(`AvailableCurrenciesTrait::currencySelectForm`, `FundsDefaultCurrency`). A `commerce_currency` cannot be
deleted while any user holds a balance in it — `commerce_funds_commerce_currency_predelete()` throws
`CurrencyInUseException` if the code appears in the site balance.
