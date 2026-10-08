<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gateways, configuration & checkout embedding

## Install / enable

`drush en commerce_revolut` (pulls `commerce_payment` + `commerce_order`; needs
`drupal/commerce ^3`). Then add a gateway at
`/admin/commerce/config/payment-gateways` → **Add payment gateway** → pick one of
the three Revolut plugins. A Revolut Business (merchant) account is required.

## The three gateway plugins

All defined with `#[CommercePaymentGateway]` in
`src/Plugin/Commerce/PaymentGateway/` and sharing `RevolutTrait`:

- **`revolut_checkout`** (`RevolutCheckout`, label "Revolut Checkout", display
  "Credit card") — `OnsitePaymentGatewayBase`. `payment_method_types: ["credit_card"]`,
  `credit_card_types: amex/mastercard/visa`, `requires_billing_information: FALSE`,
  `libraries: ["commerce_revolut/checkout"]`. Forms: add-payment-method =
  `PaymentMethodAddForm`, edit = core `PaymentMethodEditForm`. Onsite card fields
  rendered by the Revolut Checkout widget.
- **`revolut_pay`** (`RevolutPay`, label + display "Revolut Pay") — same base and
  options, but `payment_method_types: ["revolut"]` (the module's own method type).
  Renders the Revolut Pay button.
- **`revolut_payment_link`** (`RevolutPaymentLink`, label "Revolut Payment Link",
  display "Revolut") — `OffsitePaymentGatewayBase`, `payment_type: "payment_default"`,
  form offsite-payment = `PaymentOffsiteForm`. Redirects the shopper (HTTP GET) to a
  hosted Revolut `checkout_url`.

## Configuration keys

From `RevolutTrait::defaultConfiguration()` / `buildConfigurationForm()`, on top of
the base gateway config (`mode` test/live, `display_label`, etc.):

| key | type | notes |
|-----|------|-------|
| `public_key` | textfield, required | Revolut **public** key — passed to the browser widget (`publicKey`) |
| `secret_key` | textfield, required | Revolut **secret** key — server-side `Authorization: Bearer` for all API calls |
| `logging` | checkbox, default FALSE | when on, logs API request/response bodies to the `commerce_revolut` dblog channel |

`submitConfigurationForm()` persists these when the form has no errors. There is no
API-key validation call in the config form.

## Mode → environment & library switching

- `getRevolutMode()` maps Commerce `mode`: `live` → `production`, anything else →
  `sandbox`. `request()` then targets `REVOLUT_PRODUCTION_URL`
  (`https://merchant.revolut.com`) or `REVOLUT_SANDBOX_URL`
  (`https://sandbox-merchant.revolut.com`), path `/api/<endpoint>`, header
  `Revolut-Api-Version: 2024-09-01`.
- `commerce_revolut_library_info_alter()` (`.module`) swaps the front-end `embed.js`
  to `sandbox-merchant.revolut.com` when any enabled `revolut_pay` /
  `revolut_checkout` gateway is in `test` mode (otherwise the live
  `merchant.revolut.com/embed.js` from `revolut_js` in `.libraries.yml`).

## Payment method type `revolut`

`Plugin/Commerce/PaymentMethodType/Revolut` (id `revolut`, label "Revolut Pay").
Bundle fields: `revolut_payment_type` (list_string, required — allowed values from
`REVOLUT_PAYMENT_METHODS`: apple_pay, card, google_pay, revolut_pay_card,
revolut_pay_account), `revolut_card_type`, `revolut_card_number` (last digits),
`revolut_card_exp_month`, `revolut_card_exp_year`. `buildLabel()` renders e.g.
"Credit Card ending in 4242" (no "ending in" for `revolut_pay_account`).
`revolut_checkout` instead uses core's `credit_card` method type.

## Checkout embedding (onsite)

Card data is entered in Revolut's widget (`embed.js`), never posted to Drupal.

- **With a review pane**: `commerce_revolut_form_commerce_checkout_flow_alter()`
  (`.module`), on the `review` step, calls `putRevolutOrder($order)` and attaches
  `commerce_revolut/checkout` + `drupalSettings.commerceRevolut` (publicKey, mode,
  order, token, email, billing, integration) plus a hidden
  `revolut_payment_method_id` field the JS populates.
- **Without a review pane**: `PaymentMethodAddForm::buildCreditCardForm()` does the
  same attachment when the next checkout step is `payment`; otherwise it sets the
  hidden field's value to the Revolut order id directly.
- `js/commerce_revolut.checkout.js` (Drupal behavior `commerceRevolut`): for
  `revolut_checkout` builds a `createCardField` and submits the form on the widget's
  `onSuccess`; for `revolut_pay` mounts the Revolut Pay button and submits on the
  `payment` `success` event. `validateCreditCardForm()` is intentionally empty — the
  JS widget validates client-side.

## Credentials handling

Commerce recommends keeping live keys out of exported config (settings.php override
or a Key entity), entering only test/placeholder values in the form. `getPublicKey()`
/ `getSecretKey()` read straight from plugin configuration.
