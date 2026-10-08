# Configuration

Commerce Paytrail is configured as a **payment gateway** — there is no separate
settings form. You create a Paytrail gateway holding your merchant credentials and
Commerce offers it at checkout.

## Add the Paytrail gateway

1. Log in as a user who can administer payment gateways.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **Name** (for example, "Paytrail").
4. Choose the Paytrail plugin.

## Fill in the fields

Enter the **merchant credentials** from your Paytrail account. The key values are:

- Your Paytrail **merchant / account identifier**.
- Your Paytrail **merchant secret** — this is the value that keys the HMAC
  signature the module uses to sign outgoing requests and, crucially, to *verify*
  the callbacks Paytrail sends back. It must match exactly, or valid callbacks
  will be rejected.
- The **account mode / environment**, if offered — point it at Paytrail's test
  environment while setting up, and confirm it is correct before going live.

## Keep your merchant secret safe

The merchant secret is a credential and, like all Commerce gateway settings, is
stored in configuration. Do not commit it to version control, and restrict who
can administer payment gateways and export configuration. On this project the
recommended pattern is to keep the value in an environment variable via DDEV's
dotenv command and expose it to Drupal through a **Key** entity rather than typing
the raw secret into exportable config:

```bash
ddev dotenv set .ddev/.env --paytrail-merchant-secret=<value>
ddev restart
```

Run your site over **HTTPS** so redirect and callback traffic is protected.

## Save and expose at checkout

Click **Save**, then make sure the gateway is enabled and available in your
store's checkout flow.

## How payment results are handled (good to know)

Paytrail reports the outcome by calling back to your site. The module **validates
the Paytrail HMAC signature** on the return/notify callback (using the Paytrail
SDK's signature calculation, keyed by your merchant secret) before acting on it.
A callback whose signature does not verify is rejected, so a forged or tampered
notification cannot mark an order as paid. You do not configure this — it is how
the module behaves — but it is why getting the merchant secret exactly right
matters.
