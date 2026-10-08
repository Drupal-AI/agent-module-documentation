# Configuration

Commerce Coinbase is configured entirely through Drupal Commerce's payment-gateway
UI — there is no separate module settings page.

## 1. Get your Coinbase Commerce API key

In your **Coinbase Commerce** account, create an API key. You will paste this into
the gateway configuration in the next step.

## 2. Add the payment gateway

1. Log in as a user who can administer Commerce payment gateways.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway** and choose the **Coinbase** plugin.
4. Give it a name and machine name.
5. In the plugin settings, paste your **Coinbase Commerce API key** into the
   **API key** field. This is the only setting the gateway exposes.
6. Save.

Because the API key is a secret, avoid exposing it in shared exported
configuration. Where your workflow supports it, supply the value from an
environment variable rather than committing the raw key.

> **Using DDEV?** You can keep the key in DDEV's dotenv file
> (`ddev dotenv set .ddev/.env --coinbase-api-key=<value>`, keep `.ddev/.env` out
> of version control, then `ddev restart`).

## 3. Add it to your checkout flow

Enable the gateway for your store so it appears as a payment option at checkout.
When a shopper picks it, the module builds a Coinbase Commerce charge from the
order's amount and currency and redirects them to Coinbase's hosted checkout page
to pay.

## Important: confirm payments manually

As noted on the [overview page](../index.md), this version of the module does
**not** verify payment server-side — there is no return handler and no webhook
(notify) route, so Coinbase's callback is never validated and no completed payment
is recorded automatically. Until that changes:

- **Do not rely on automatic order fulfilment** triggered by payment completion.
- **Reconcile every order manually** against your Coinbase Commerce dashboard
  before treating it as paid.
- Remember the module is **not covered by Drupal's security advisory policy**, so
  weigh that against your risk tolerance for a production store.
