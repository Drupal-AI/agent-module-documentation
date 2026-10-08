<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gateway, checkout form, validation & mandate email

## Install / enable

`drush en commerce_sepa` (pulls `commerce:commerce_payment`). The IBAN helper library
`globalcitizen/php-iban ^2.6` must be present — installed by `composer require drupal/commerce_sepa`
or, without Composer, via Ludwig (`ludwig.json` pins `2.6.1`). Then add a gateway at
`/admin/commerce/config/payment-gateways` → **Add payment gateway** → choose **SEPA**.

## The gateway plugin

`src/Plugin/Commerce/PaymentGateway/Sepa.php`, id **`commerce_sepa`**
(`@CommercePaymentGateway`, label "SEPA", `display_label` "Direct debit"), extends
`OnsitePaymentGatewayBase`, implements `SepaInterface` (Commerce's
`SupportsCreatingPaymentMethodsInterface` + `SupportsUpdatingStoredPaymentMethodsInterface`).
Annotation flags: `payment_type = "payment_manual"`, `payment_method_types = {"bank_account"}`,
`requires_billing_information = FALSE`, `modes = {"n/a"}`. Only the `add-payment-method` form is
declared (`SepaPaymentMethodAddForm`); editing a stored method is a documented `@todo`.

`create()` injects `config.factory`, `current_user`, `language_manager`, `plugin.manager.mail` and
`current_route_match`.

## Configuration form (`buildConfigurationForm`)

- `valid_countries` — multi `#type: select` (`#size: 8`, `#required: FALSE`). Options are
  `CountryManager::getStandardList()` filtered to the codes returned by `iban_countries()`. Used
  only to constrain which IBAN country prefixes checkout accepts.
- `bic` / `account_holder` — checkboxes ("Request BIC number on checkout" / "Request account holder
  on checkout"). When off, those fields are hidden at checkout (`#access` FALSE on the add form).
- `notify` — checkbox "Send SEPA Direct Debit Mandate". A `#states`-driven fieldset then exposes:
  - `notification_from` (`#type: email`, max 180) — empty falls back to `system.site` mail.
  - `notification_subject` (textfield, max 180, required when notify).
  - `notification_body` (textarea, 16 rows, required when notify) — pre-filled with a full B2B SEPA
    mandate letter containing **literal** `{{ Creditor Name }}` / `{{ Creditor Identifier }}` /
    `{{ NAME OF CREDITOR }}` placeholders that the operator must replace by editing this text; they
    are not tokens.
  - `token_tree` link for `commerce_order`, `commerce_payment_method`, `profile` tokens.
- `instructions` (from the manual/base gateway) is re-weighted to `#weight` 100.

`submitConfigurationForm()` persists `valid_countries`, `bic`, `account_holder`, `notify`,
`notification_from`, `notification_subject`, `notification_body` (only when there are no form
errors).

## Checkout / add-payment-method form

`src/PluginForm/SepaPaymentMethodAddForm.php` (extends Commerce `PaymentMethodAddForm`) builds a
`bank-account-form` under `payment_details`:

- `iban` — textfield, `autocomplete: off`, `#required`, max/size 34.
- `bic` — textfield (max/size 11), shown only if gateway `bic` config is TRUE.
- `account_holder` — textfield, shown only if gateway `account_holder` config is TRUE.

`validateBankAccountForm()`:
- If a BIC was entered, `verifyBic()` checks it against the ISO 9362 regex
  `/^([a-zA-Z]){4}([a-zA-Z]){2}([0-9a-zA-Z]){2}([0-9a-zA-Z]{3})?$/`; invalid ⇒ form error.
- Normalizes the IBAN via `iban_to_human_format()`, then errors unless `verify_iban()` passes **and**
  (when `valid_countries` is non-empty) `iban_get_country_part()` is in the allow-list. On success the
  normalized IBAN is written back into the form value.

`submitBankAccountForm()` copies `iban`, `bic` (or `''`), `account_holder` (or `''`) onto the
payment-method entity. Being a Commerce FormAPI form, it carries Drupal's built-in CSRF token.

## Storing the payment method (`createPaymentMethod`)

1. `iban` is re-normalized with `iban_to_human_format()` and, with `bic` + `account_holder`, saved
   as string fields on the `commerce_payment_method` entity (bundle `bank_account`).
2. If `notify` is off, it returns. If on, it token-replaces the subject + body
   (`data` = the payment method, plus the order for anonymous checkout and the billing profile when
   present) and sends the mandate via `MailManager::mail('commerce_sepa', 'sepa_notification', …)`.
   Recipient: for an **anonymous** checkout the order's email (order loaded from the route match);
   for an authenticated user the payment-method **owner's** email. The "from" is
   `notification_from` or the site mail. `hook_mail()` maps the params to a plain-text message.

   NOTE: `createPaymentMethod()` uses `$this->token`, which `create()` does not initialize in this
   release — enabling the mandate email may error until that is fixed on the target site.

## Payment operations

- `createPayment()` — asserts state `new`, asserts the method, `$payment->save()`. No remote call;
  the amount is the server-side Commerce payment amount. Manual capture/void afterwards.
- `deletePaymentMethod()` — `$payment_method->delete()`.
- `updatePaymentMethod()` — `$payment_method->save()` (`@todo`: notify on IBAN change).

## Payment method label

`BankAccount::buildLabel()` renders `Bank account ending in @account_number`, where
`@account_number` is the **last 4** characters of the space-stripped IBAN — the full IBAN is not put
in the label.
