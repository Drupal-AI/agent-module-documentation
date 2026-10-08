# Configuration

All of Commerce Braintree's configuration lives on the **payment gateway** you create —
there is no separate module settings page.

## 1. Add the Braintree payment gateway

1. Go to **Commerce → Configuration → Payment → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the plugin **Braintree (Hosted Fields)**.
3. Set the **Mode**:
   - **Test** — uses the Braintree sandbox. Start here while you set everything up.
   - **Live** — uses your production Braintree account. Switch to this only when you're
     ready to take real money.

## 2. Enter your Braintree credentials

Fill in the credentials from your Braintree account:

- **Merchant ID** *(required)* — your Braintree account's merchant ID.
- **Public key** *(required)* — your Braintree API public key.
- **Private key** *(required)* — your Braintree API private key. This is a secret — see the
  note below on keeping it out of exported configuration.
- **Merchant account ID** — one field per currency your store accepts (see *Multiple
  currencies* below).
- **3D Secure** — Disabled, Enabled, or Required (see *3‑D Secure* below).
- **Enable Credit Card Icons** *(default on)* — show card‑brand icons (Visa, Mastercard,
  etc.) during checkout.

> **Keeping the private key out of version control.** Like every Commerce gateway
> credential, the private key is stored on the gateway config entity. If you export
> configuration to code, don't commit the real key. The standard practice is to keep the
> secret in an environment variable and override it in `settings.php` so it never lands in
> the config sync directory, for example:
>
> ```php
> $config['commerce_payment.commerce_payment_gateway.braintree']['configuration']['private_key']
>   = getenv('BRAINTREE_PRIVATE_KEY');
> ```
>
> With DDEV you can store the value with `ddev dotenv set .ddev/.env
> --braintree-private-key=<value>` (which sets `BRAINTREE_PRIVATE_KEY` in the container) and
> keep `.ddev/.env` out of git. Adjust the config key to match your gateway's machine name.

## 3. Payment method types

Braintree offers three payment method types you can enable in your Braintree control panel
and in the store's checkout:

- **Credit card** — on‑site card entry via Hosted Fields.
- **PayPal** — PayPal as a checkout option through Braintree.
- **PayPal Credit** — a dedicated, separate PayPal Credit option.

## 4. Multiple currencies

Braintree ties transactions to a **merchant account**, and each merchant account has one
currency. For every currency your store accepts, add the matching Braintree **merchant
account ID** in the per‑currency field on the gateway form. If a currency has no mapped
merchant account, a payment in that currency will fail with an error — so make sure every
enabled store currency is mapped.

## 5. 3‑D Secure 2 (SCA)

To require strong customer authentication:

1. On the gateway, set **3D Secure** to **Enabled** (attempt 3DS, but let unenrolled cards
   through) or **Required**.
2. Add the **Braintree 3DS review** checkout pane to the **Review** step of your checkout
   flow, under **Commerce → Configuration → Checkout flows**
   (`/admin/commerce/config/checkout-flows`).

The pane runs Braintree's client‑side 3‑D Secure authentication just before the final
submit. This pane is **required** for 3DS to work with vaulted/stored payment methods, so
don't skip it if you turn 3DS on.

## Testing before going live

With the gateway in **Test** mode you can run full checkouts against Braintree's sandbox
using Braintree's test card numbers. When everything works, edit the gateway, switch **Mode**
to **Live**, and confirm the credentials are your production keys.

## For developers — adding data to a transaction

If you need to send extra metadata to Braintree with each sale (custom fields, a descriptor,
an order channel), subscribe to the `commerce_braintree.transaction_data` event and modify
the transaction data array before it's sent. The array must follow Braintree's
`transaction()->sale()` request format. See the sibling
[`agent/api/events.md`](../agent/api/events.md) reference for a worked subscriber example.
