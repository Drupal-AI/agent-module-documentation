# Configuration

Commerce PayU is configured as a **payment gateway** — there is no separate
settings form. You create a PayU gateway holding your merchant credentials and
Commerce offers it at checkout.

## Add the PayU gateway

1. Log in as a user who can administer payment gateways.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **Name** (for example, "PayU").
4. Choose the **PayU** plugin.

## Fill in the fields

Enter the credentials from your PayU merchant panel:

- **POS ID** — the identifier of your PayU point of sale.
- **Signature key** — PayU's second key, used to verify the signature on PayU's
  notifications. This is critical: if it is wrong, *every* incoming notification
  will fail verification and no payment will be recorded.
- **OAuth client id** and **OAuth client secret** — used to authenticate the
  module's API calls to PayU.
- **Mode / environment** — choose **sandbox** for testing (maps to PayU's sandbox
  environment) and **live** (secure) only with production credentials.

## Keep your credentials safe

The signature key and OAuth secret are credentials and, like all Commerce gateway
settings, are stored in configuration. Do not commit them to version control, and
restrict who can administer payment gateways and export configuration. On this
project the recommended pattern is to keep such values in environment variables
via DDEV's dotenv command and expose them to Drupal through **Key** entities
rather than typing raw secrets into exportable config:

```bash
ddev dotenv set .ddev/.env --payu-signature-key=<value> --payu-oauth-secret=<value>
ddev restart
```

Run your site over **HTTPS** so redirect and notification traffic is protected.

## Save and expose at checkout

Click **Save**, then make sure the gateway is enabled and available in your
store's checkout flow.

## How payment results are handled (good to know)

At checkout the module builds a PayU order — converting the price to PayU's
minor-unit integers, adding buyer, billing/delivery, and line-item data — and
POST-redirects the shopper to PayU's hosted page. PayU then calls back to the
gateway's notify URL. Before doing anything financial the module **verifies the
`Openpayu-Signature` header against your configured signature key**; only a valid
signature *and* a `COMPLETED` status result in a Commerce payment, and the
recorded amount comes from your local order total, not the callback body. A bad
signature causes the PayU order to be cancelled and no payment to be created.

The browser return (`onReturn`) simply checks that a payment now exists — the real
fulfilment happens in the verified server-to-server notification. If you are
troubleshooting, watch the `commerce_payu` log channel for failed-notification and
order-creation messages.
