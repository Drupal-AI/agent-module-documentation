# Configuration

Commerce Pei is configured as a **payment gateway** — there is no separate
settings form. You create a Pei gateway holding your API credentials and Commerce
offers it at checkout.

## Add the Pei gateway

1. Log in as a user who can administer payment gateways.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **Name** (for example, "Pei").
4. Choose the Pei plugin.

## Fill in the fields

Enter the **Pei API credentials** from your Pei account. Because this is an
on-site gateway, these credentials are what the module uses to create and capture
the payment during checkout.

- Set the **mode / environment** (test vs. live) if offered, and use test
  credentials while setting up.

## Keep your credentials safe

The Pei API credentials are secrets and, like all Commerce gateway settings, are
stored in configuration. Do not commit them to version control, and restrict who
can administer payment gateways and export configuration. On this project the
recommended pattern — matching the module's own guidance to keep credentials
env-backed — is to store the values in environment variables via DDEV's dotenv
command and expose them to Drupal through **Key** entities rather than typing raw
secrets into exportable config:

```bash
ddev dotenv set .ddev/.env --pei-api-key=<value>
ddev restart
```

Run your site over **HTTPS** — essential here, because with an on-site gateway the
shopper enters payment details on your own pages.

## Save and expose at checkout

Click **Save**, then make sure the gateway is enabled and available in your
store's checkout flow.

## How the payment flow works (good to know)

As an on-site gateway, Commerce Pei processes payment **synchronously during
checkout, with the buyer present** — buyer authorization is handled when the
payment method is created, and the payment is captured in the same flow. There is
no anonymous asynchronous callback, which removes the class of risks that come
with forged inbound notifications.
