<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce SEPA (commerce_sepa) — agent index

An **on-site (on-site, no redirect) SEPA direct-debit payment gateway** for Drupal Commerce. At
checkout the customer types their **IBAN** (and optionally BIC + account holder); the module
validates the IBAN with the **`globalcitizen/php-iban`** library, stores it on a stored
`bank_account` payment method, and — if enabled — emails the customer a **SEPA Direct Debit
Mandate** document to print, sign and return. It does **not** move money and does **not** talk to
any bank API: it is a `payment_manual` gateway, so collection/settlement happens out of band
through your bank. Package `Commerce (contrib)`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.
Installed version dir **8.x-1.x** (`.info.yml` version `8.x-1.1`).

## Dependencies

- Drupal module: **`commerce:commerce_payment`** (required, from `.info.yml`).
- Composer libraries (`composer.json`): **`drupal/commerce` `^2.0 || ^3.0`** and
  **`globalcitizen/php-iban` `^2.6`** — the IBAN library provides the procedural functions the
  module calls: `iban_countries()`, `verify_iban()`, `iban_to_human_format()`,
  `iban_get_country_part()`. Also ships a `ludwig.json` so php-iban can be installed via
  [Ludwig](https://www.drupal.org/project/ludwig) instead of Composer.

## What it provides (from source)

- **One payment gateway plugin** `commerce_sepa` —
  `src/Plugin/Commerce/PaymentGateway/Sepa.php`, `@CommercePaymentGateway` (label "SEPA",
  `display_label` "Direct debit"), extends `OnsitePaymentGatewayBase`, implements `SepaInterface`
  (`SupportsCreatingPaymentMethodsInterface` + `SupportsUpdatingStoredPaymentMethodsInterface`).
  Annotation: `payment_type = "payment_manual"`, `payment_method_types = {"bank_account"}`,
  `requires_billing_information = FALSE`, `modes = {"n/a"}` (no test/live split). Add-payment-method
  form only (`@todo` for edit).
- **One payment method type** `bank_account` —
  `src/Plugin/Commerce/PaymentMethodType/BankAccount.php` (`@CommercePaymentMethodType`), extends
  `PaymentMethodTypeBase`. Adds three **string bundle fields** on `commerce_payment_method`: `iban`
  (max_length 34, required), `bic` (required), `account_holder` (required). `buildLabel()` shows
  only the **last 4 digits**: "Bank account ending in @account_number".
- **The checkout/add form** `src/PluginForm/SepaPaymentMethodAddForm.php` — extends Commerce's
  `PaymentMethodAddForm`; renders the IBAN field (+ optional BIC / account-holder fields gated by
  gateway config), validates BIC (ISO 9362 regex) and IBAN (`verify_iban` + optional country
  allow-list), and stores the values on the payment-method entity.
- **`hook_mail()`** (`commerce_sepa.module`, key `sepa_notification`) — sends the mandate email.
- **`commerce_sepa_update_8001()`** (`.install`) — installs the `bic` + `account_holder` field
  storage on existing sites.
- **Config schema** for the gateway plugin
  (`config/schema/commerce_sepa.schema.yml`,
  `commerce_payment.commerce_payment_gateway.plugin.commerce_sepa`).
- **No** `routing.yml`, **no** `*.permissions.yml`, **no** custom controllers/routes, **no**
  templates, **no** JS, **no** Drush, **no** submodules, **no** SEPA XML (pain.008) export. Access
  control is entirely Commerce's default for payment gateways and stored payment methods.

## Payment model (important for agents)

This is a **manual** gateway. `createPayment()` only asserts the payment is `new` and its method is
valid, then `$payment->save()` — the amount is the Commerce payment amount (server-side, derived
from the order), never a request/client value, and there is **no remote authorization or capture**.
An order is therefore **not guaranteed paid** at checkout; the merchant must actually raise the SEPA
debit and reconcile settlement out of band. Payments are captured/voided manually through the
standard Commerce Manual-payment operations.

## Gateway configuration keys

From `defaultConfiguration()` + schema (on top of the base gateway config, which supplies
`display_label`, `instructions` (payment instructions text_format, `#weight` 100), `mode`, etc.):

| key | type | meaning |
|-----|------|---------|
| `valid_countries` | array of country codes | IBAN country allow-list; options = `CountryManager` ∩ `iban_countries()`. Empty = accept any valid IBAN country |
| `bic` | bool | show the **BIC** field on checkout (default FALSE) |
| `account_holder` | bool | show the **account holder** field on checkout (default FALSE) |
| `notify` | bool | send the SEPA Direct Debit Mandate email after a method is added (default FALSE) |
| `notification_from` | email | "from" address for the mandate email; empty ⇒ site email |
| `notification_subject` | string | mandate email subject (token-enabled) |
| `notification_body` | text | mandate document template (token-enabled); default is a full B2B mandate letter with `{{ Creditor Name }}`-style **literal placeholders the admin must edit by hand** |

Token types offered for subject/body: `commerce_order`, `commerce_payment_method`, `profile`.
(Schema also lists legacy keys `instructions` and `sepa_from`; the active code path uses
`notification_from`, not `sepa_from`.)

## Known caveat in this release

`Sepa::createPaymentMethod()` calls `$this->token->replace(...)` when `notify` is enabled, but
`Sepa::create()` never initializes a `token` service (it sets configFactory, currentUser,
languageManager, mailManager, routeMatch only). Enabling the mandate email can therefore fail on a
call to `replace()` on an uninitialized service in this version. Verify on the target site before
relying on the email feature.

## Solution docs

- **Gateway config form, checkout IBAN/BIC form, validation, mandate email, field storage & data
  flow** → [gateway.md](gateway.md)
