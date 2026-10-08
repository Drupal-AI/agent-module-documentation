# Configuration

Everything is set on one form, plus (optionally) wiring LiqPay into Basket's
checkout.

## Open the settings form

1. Log in as a user with the **Access LiqPay settings** permission. This is a
   **restricted** permission — grant it only to trusted administrators at
   **People → Permissions**.
2. Go to **Configuration → Development → LiqPay**, or navigate directly to
   `/admin/config/development/liqpay`.

Fill in the fields below and click **Save configuration**.

## Sandbox vs live

- **Sandbox** (`sandbox`) — a checkbox that is **on by default**. While it is on,
  the module uses your **sandbox** keys instead of the live ones, so you can test
  the full flow without taking real money. Turn it off only when you are ready to
  accept live payments.

Because of this switch you fill in **two** key pairs:

- **Public key** / **Private key** (`public_key` / `private_key`) — your **live**
  LiqPay API keys.
- **Sandbox public key** / **Sandbox private key**
  (`public_key_sandbox` / `private_key_sandbox`) — the keys used while sandbox
  mode is on.

The **private key** is not just a credential — it is also the secret the module
uses to verify the signature on LiqPay's result callback, so it must be correct
for payments to be confirmed.

## Payment details

- **Currency** (`currency`) — the default payment currency. LiqPay supports
  **UAH**, **USD**, and **EUR**. Default is **UAH**.
- **Description** (`description`) — the order description sent to LiqPay, provided
  per language (English, Ukrainian, Russian) so it matches the buyer's interface
  language.
- **Success message** (`success`) — the message shown on the payment result page
  (`/liqpay/payment_result`) after a successful payment, also per language.

## Keeping your keys secure (recommended)

Payment keys are secrets and should not end up in exported configuration or in
version control. Entering them in the UI is fine for quick sandbox testing, but on
a real site override the private key (and ideally the public key) from an
environment variable in `settings.php`:

```php
$config['liqpay.settings']['config']['private_key'] = getenv('LIQPAY_PRIVATE_KEY');
$config['liqpay.settings']['config']['public_key']  = getenv('LIQPAY_PUBLIC_KEY');
```

Store the values as environment variables (for example with DDEV's
`ddev dotenv set`), never hard‑code them. A **Key** entity is another supported
option. This keeps the live private key out of the database and out of any config
export.

## Basket integration

If the **Basket** module is enabled, LiqPay automatically becomes available as a
payment method in Basket's checkout — enable it in your Basket payment settings.
On a verified successful callback the module finishes the Basket order for you.

If you are **not** using Basket, you can still take payments: create a payment row
and send the buyer to `/liqpay/pay?pay_id=N`, where `N` is the payment's id.

## How a payment flows (for reference)

1. The buyer reaches the checkout form (`/liqpay/pay`) and is auto‑posted to
   LiqPay's hosted checkout.
2. After paying, LiqPay POSTs the result to the module's callback (`/liqpay/api`).
3. The module recomputes and **checks the signature** against your private key and
   only then updates the order — success statuses include `success`, `sandbox`,
   `subscribed`, `unsubscribed`, and `hold_wait`.
4. The buyer sees the outcome at `/liqpay/payment_result`; if the callback is
   delayed, that page polls LiqPay for the current status.
