# Configuring an Authorize.net payment gateway

Each Authorize.net integration is a Commerce **`commerce_payment_gateway`** config entity
whose `plugin` is one of this module's gateway plugins and whose `configuration` holds the
credentials + mode. Add one in the UI at **`/admin/commerce/config/payment-gateways`** (Add
payment gateway → choose an Authorize.net plugin), or create it in code.

## Gateway plugins

| `plugin` id | Class | Kind | Extra config keys |
|---|---|---|---|
| `authorizenet_acceptjs` | `AcceptJs` | On-site credit card (Accept.js JS tokenizer) — recommended | `enable_credit_card_icons` (bool, default TRUE) |
| `authorizenet_accept_hosted` | `AcceptHosted` | Off-site hosted card form (iframe) | `captcha_security` (bool, default FALSE), `card_code_required` (bool, default TRUE) |
| `authorizenet_echeck` | `Echeck` | ACH / eCheck; payment method type `authnet_echeck` | — |
| `authorizenet_visa_checkout` | `VisaCheckout` | **Legacy, deprecated** | `visa_checkout_api_key` |

Payment type for Accept.js is `acceptjs`; Accept.js/Accept Hosted/Visa Checkout use payment
method type `credit_card`; eCheck uses `authnet_echeck`.

## Shared configuration keys (`config/schema/commerce_authnet.schema.yml`)

Every gateway's `configuration` includes:

- `api_login` — Authorize.Net **API Login ID**.
- `transaction_key` — Authorize.Net **Transaction Key**.
- `client_key` — Authorize.Net **public Client Key** (used by Accept.js in the browser).
- `mode` — Commerce gateway mode: **`test`** (sandbox / developer account) or **`live`**.
- plus the standard Commerce payment-gateway keys (`display_label`, `payment_method_types`,
  `collect_billing_information`, `conditions`, ...).

## Create a gateway in code

```php
$gateway = \Drupal::entityTypeManager()
  ->getStorage('commerce_payment_gateway')
  ->create([
    'id' => 'authnet',
    'label' => 'Authorize.net',
    'plugin' => 'authorizenet_acceptjs',
    'configuration' => [
      'api_login' => 'YOUR_LOGIN_ID',
      'transaction_key' => 'YOUR_TRANSACTION_KEY',
      'client_key' => 'YOUR_CLIENT_KEY',
      'enable_credit_card_icons' => TRUE,
      'mode' => 'test',
      'payment_method_types' => ['credit_card'],
    ],
  ]);
$gateway->save();
```

Read it back with `->getPlugin()->getMode()` (test/live) and `->getPluginConfiguration()`
for the credential array. (Live authorization/capture calls require valid Authorize.Net
credentials and the `commerceguys/authnet` library; the config entity itself saves without
contacting the API.)

## Accept.js workflow (`commerce_authnet.workflows.yml`)

Accept.js defines workflow **`payment_acceptjs`** (group `commerce_payment`) with states
`new`, `authorization`, `authorization_review`, `authorization_declined`,
`authorization_expired`, `authorization_voided`, `unauthorized_review`,
`unauthorized_declined`, `completed`, `partially_refunded`, `refunded`, and transitions for
`authorize`, `authorize_capture`, `capture`, `void`, `expire`, approve/decline review, and
`refund` / `partially_refund`. This gives on-site card payments authorize-only and
authorize-and-capture flows plus fraud "needs review" handling.
