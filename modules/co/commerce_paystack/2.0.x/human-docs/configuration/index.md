# Configuration

Commerce Paystack is configured as a **payment gateway**. There is no separate
settings page — you create a Paystack gateway and Commerce offers it at checkout.
This module has no permissions of its own; administering it uses the standard
Commerce *Administer payment gateways* permission.

## Add the Paystack gateway

1. Log in as a user who can administer payment gateways.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **Name** (for example, "Paystack").
4. Choose the plugin **Paystack Standard (Off-site)**.

## Fill in the fields

- **Mode** — choose **Test** or **Live**. Use Test with your `sk_test_…` key while
  you are setting up and trying things out; switch to Live only when you are ready
  to take real money.
- **Secret Key** — your Paystack merchant **Secret Key**. The form validates that
  the value starts with `sk_`, so paste the secret key (not the public key). Use
  the test secret key in Test mode and the live secret key in Live mode.

## Keep your Secret Key safe

The Secret Key is a credential and, like all Commerce gateway settings, is stored
in configuration. Do not commit it to version control, and restrict who can
administer payment gateways and export configuration. On this project the
recommended pattern is to keep the value in an environment variable via DDEV's
dotenv command and expose it to Drupal through a **Key** entity rather than typing
the raw secret into exportable config:

```bash
ddev dotenv set .ddev/.env --paystack-secret-key=<value>
ddev restart
```

Run your site over **HTTPS** so the redirect traffic is protected.

## Save and expose at checkout

Click **Save**, then make sure the gateway is enabled and available in your
store's checkout flow so shoppers see Paystack as a payment option.

## How the payment flow works (good to know)

At checkout the module initializes a Paystack transaction (using your order's UUID
as the reference and sending the amount in kobo) and redirects the shopper to
Paystack's hosted page. When they return, the module reads the transaction
reference and makes an **authenticated server-side call to Paystack to verify the
transaction**. A Commerce payment is created only when Paystack confirms the
transaction — the browser redirect is never trusted on its own, and there is no
inbound webhook endpoint to forge. TLS verification is left at the library's
secure default.

One thing to be aware of for high-value stores: on return the module records the
order's own total as the payment amount and does not separately compare the
*verified paid amount and currency* returned by Paystack against the order. Because
the reference is the server-generated order UUID this is largely mitigated, but if
you sell high-value items you may want a developer to add an explicit
amount/currency cross-check before fulfilment for defence in depth. Review the
`commerce_paystack` logs if you see verification errors.
