# Configuration

Commerce PostFinance is configured as a **payment gateway**, plus one step in the
PostFinance portal to register the webhook. There is no separate settings form in
Drupal — you create a PostFinance gateway and Commerce offers it at checkout.

## Add the PostFinance gateway

1. Log in as a user who can administer payment gateways.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **Name** (for example, "PostFinance").
4. Choose the **PostFinance** plugin.

## Fill in the fields

Enter the credentials from your PostFinance Checkout space:

- **Space ID** — the id of your PostFinance Checkout space.
- **User ID** — the API user id.
- **API secret / key** — the authentication key for that API user.
- **Mode / environment** — point it at your PostFinance **test space** while
  setting up, and switch to the live space only when ready.

The customer's available payment methods (PostFinance Card, Visa, Mastercard,
Twint, and so on) are whatever you have activated in your PostFinance space — you
do not enable them individually here.

## Register the webhook

Because payment is confirmed asynchronously, PostFinance must be able to notify
your site. In the **PostFinance portal**, register the webhook URL:

```
https://your-site.example/commerce_postfinance_checkout/webhook
```

Use your real site domain, over HTTPS.

## Keep your credentials safe

The API secret is a credential and, like all Commerce gateway settings, is stored
in configuration. Do not commit it to version control, and restrict who can
administer payment gateways and export configuration. On this project the
recommended pattern is to keep the value in an environment variable via DDEV's
dotenv command and expose it to Drupal through a **Key** entity rather than typing
the raw secret into exportable config:

```bash
ddev dotenv set .ddev/.env --postfinance-api-secret=<value>
ddev restart
```

Run your site over **HTTPS** so redirect and webhook traffic is protected.

## Save and expose at checkout

Click **Save**, then make sure the gateway is enabled and available in your
store's checkout flow.

## How payment results are handled (good to know)

At checkout the shopper is redirected to PostFinance to pay, then returned to your
site. Final confirmation comes through the webhook you registered. The module does
**not** trust the webhook request body for fulfilment — it reads the transaction's
`entityId` from the notification and **re-fetches the transaction from the
PostFinance API** to obtain the authoritative state before updating the Commerce
payment. This bounded server-to-server re-fetch means a forged POST to the webhook
cannot mark an order paid. Card data stays entirely off-site on PostFinance.
