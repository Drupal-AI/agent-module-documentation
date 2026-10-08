# Configuration

Commerce Pesapal is configured as a **payment gateway** — there is no separate
settings form. You create a Pesapal gateway holding your credentials and Commerce
offers it at checkout.

## Add the Pesapal gateway

1. Log in as a user who can administer payment gateways.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **Name** (for example, "Pesapal").
4. Choose the Pesapal plugin.

## Fill in the fields

- **Consumer key** and **Consumer secret** — the credentials from your Pesapal
  account. The module supports separate **sandbox** and **live** credentials, so
  enter the pair that matches the mode you are configuring.
- **Mode / environment** — choose **sandbox** for testing (using Pesapal's
  demo/sandbox credentials) and **live** only with production credentials.

After entering credentials you can use the module's built-in ability to **test the
API configuration** to confirm your keys work before taking real payments.

## Keep your credentials safe

The consumer key and secret are credentials and, like all Commerce gateway
settings, are stored in configuration. Do not commit them to version control, and
restrict who can administer payment gateways and export configuration. On this
project the recommended pattern is to keep such values in environment variables
via DDEV's dotenv command and expose them to Drupal through **Key** entities
rather than typing raw secrets into exportable config:

```bash
ddev dotenv set .ddev/.env --pesapal-consumer-key=<value> --pesapal-consumer-secret=<value>
ddev restart
```

Run your site over **HTTPS** so redirect and IPN traffic is protected.

## Save and expose at checkout

Click **Save**, then make sure the gateway is enabled and available in your
store's checkout flow — it should then appear among your payment options.

## How payment results are handled (good to know)

After the shopper pays, Pesapal calls your site's IPN endpoint
(`/payment/pesapal/ipn`) and returns the customer to the order. The module does
**not** trust the status in that request. It re-fetches the real transaction
status from Pesapal's API (calls signed with OAuth HMAC-SHA1), fulfils the order
only when the re-fetched status is `COMPLETED`, records the server-side order
total rather than any amount from the request, and de-duplicates by the remote
transaction id — the authoritative status always comes from Pesapal, not from the
callback request.
