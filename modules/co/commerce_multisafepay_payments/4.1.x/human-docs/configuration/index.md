# Configuration

Setting up MultiSafepay is a two-part job: first the **global settings** (your API
key and whether you're in live or test mode), then **one payment gateway per
MultiSafepay method** you want to offer at checkout.

## Store the API key securely

Your MultiSafepay API key is a secret — never hard‑code or commit it. With DDEV,
keep it in an environment variable and load it through a Key entity:

```bash
ddev dotenv set .ddev/.env --multisafepay-api-key=<value>
ddev restart
```

Install the Key module if it isn't enabled, confirm the variable is present in the
container, then create a Key with the built-in env provider and reference that Key
from the settings form. This keeps the raw key out of exported configuration.

## Global settings

1. Go to **Configuration → Commerce MultiSafepay Payments**
   (`/admin/config/commerce_multisafepay_payments`). You need the *Administer site
   configuration* permission.
2. Enter your **API key**.
3. Choose the **mode** — **Test** (MultiSafepay's sandbox) while you validate, or
   **Live** for real transactions.
4. Save.

Start in **test** mode until you've confirmed the flow works, then switch to live.

## Add a payment gateway per method

Each MultiSafepay method (iDEAL, Bancontact, Klarna, PayPal, Sofort, cards, the
various national gift cards, and so on) is its own Commerce payment gateway plugin.
For every method you want to offer:

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the MultiSafepay plugin for that method.
3. Give it a name and save. Repeat for each method.

Only the methods you add as gateways appear at checkout.

## How payments are confirmed (and why it's safe)

These are **offsite** gateways: the shopper is redirected to MultiSafepay to pay
and returned to your site afterwards. Confirmation does **not** rely on the data in
the return request. When MultiSafepay sends its asynchronous notification (and via
the second-chance return controller), the module re-fetches the authoritative order
status from the MultiSafepay API using your merchant key and sets the Commerce
payment state from that. All API calls go over HTTPS with TLS certificate
verification enabled. This means a shopper cannot forge a "paid" outcome by tampering
with the return URL — the store always checks with MultiSafepay before trusting a
result.

On fulfilment the module can send shipment tracking back to MultiSafepay, and it
supports refunds and order updates through the API.

## Note on security-advisory coverage

This project is **not** covered by Drupal's security advisory policy and is listed
as *minimally maintained*. That doesn't make it unsafe to use, but keep it updated
and test the payment flow thoroughly (in test mode first) before relying on it in
production.
