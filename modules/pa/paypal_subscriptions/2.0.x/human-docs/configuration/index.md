# Configuration

PayPal Subscriptions is configured as a **Commerce payment gateway**, not through a
standalone settings page.

## Add the recurring gateway

1. Log in as a user who can administer Commerce payment gateways.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway** and choose **PayPal recurring (Express
   Checkout)** as the plugin.

## The fields

Because this gateway extends Commerce PayPal's Express Checkout gateway, most of
the fields are the standard ones you already know from that gateway:

- **PayPal API credentials** — the API username, password, and signature (NVP
  credentials) for your PayPal business account, exactly as for the normal
  Commerce PayPal Express Checkout gateway.
- **Mode** — **Test** (PayPal sandbox) or **Live**. Use Test while you verify the
  flow.
- **Billing period** — the extra setting this module adds: how often PayPal bills
  the recurring profile — **Day, Week, SemiMonth, Month,** or **Year**. This is the
  cadence of the subscription created at checkout.
- The usual Commerce gateway options (display name, payment method types, etc.).

## Keep API credentials secret

Your PayPal API password and signature are live credential material. Store them in
environment variables rather than committing them, for example with DDEV:

```bash
ddev dotenv set .ddev/.env --paypal-api-signature=<value>
ddev restart
```

(Keep `.ddev/.env` out of version control.) Review your configuration export
before committing to make sure real credentials are not written into the exported
gateway config.

## How the recurring flow behaves

At checkout the gateway sends PayPal a `SetExpressCheckout` request flagged for
recurring payments. When the shopper returns, the module calls
`GetExpressCheckoutDetails` and then `CreateRecurringPaymentsProfile`
server-to-server, and records a Commerce payment (in the *authorization* state,
with the PayPal PROFILEID as its remote ID) **only** when PayPal confirms the
profile is active. If PayPal reports an error or a non-active profile, the module
throws rather than recording a payment — so an order never appears paid unless
PayPal actually created the subscription.

## Save and test

Save the gateway, then run a full test checkout in **Test/sandbox** mode: complete
the PayPal Express Checkout flow and confirm a recurring profile is created and a
Commerce payment is recorded. Switch to **Live** only once the sandbox flow works
end to end.
