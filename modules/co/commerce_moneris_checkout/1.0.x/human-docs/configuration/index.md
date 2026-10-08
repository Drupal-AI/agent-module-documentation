# Configuration

Setting up Commerce Moneris Checkout has two parts: configuring a **Moneris
Checkout profile** in your Moneris account, and then adding the gateway in Drupal
with the credentials that tie the two together.

## 1. Configure a Moneris Checkout profile

In your Moneris account, create and configure a **Moneris Checkout profile** as
described in the module's README. The README's instructions target the shared
**test** environment, but the same steps apply to a **live** account — you just
use your own login details and API key. Note the checkout ID/profile identifier
this produces; you'll need it in Drupal.

## 2. Add the payment gateway in Drupal

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a **Name** and choose the **Moneris Checkout** plugin.

## The settings, field by field

- **Environment** — choose **Testing** while integrating (using the shared test
  environment) and **Production** for real payments. (Internally these are the
  `qa` and `prod` modes.)
- **Store ID** — your Moneris store identifier.
- **API Token** — your Moneris API token.
- **Checkout ID** — the identifier of the Moneris Checkout profile you created
  above, which drives the embedded iframe.
- **Country** — **Canada** (default) or **US**.
- **Moneris Checkout order number strategy** — how the order number sent to
  Moneris is chosen: **Use the order ID** (default), **Use the order ID with
  timestamp appended** (recommended during testing, since Moneris rejects a
  repeated order number), or **Generate the order number early** (may leave gaps
  in your Commerce order numbers).
- **Log the following messages for debugging** — optional API request/response
  logging. Leave these off in production once integration works; the log entries
  are only needed while troubleshooting.

Save the gateway.

## Keep your credentials secret

Your Moneris **API token** (and store credentials) are secrets — treat them like
passwords:

- Don't commit them to version control.
- Prefer storing the token in an environment variable rather than hard-coding it.
  With DDEV you can set it once with the built-in dotenv command:

  ```bash
  ddev dotenv set .ddev/.env --moneris-api-token='<your token>'
  ddev restart
  ```

  Keep `.ddev/.env` out of version control.
- Always serve checkout over **HTTPS**.

## How the payment is confirmed (why it's safe)

When the customer finishes in the Moneris Checkout iframe, the module checks the
response code, then **fetches the receipt directly from Moneris server-side** and
**verifies the receipt's order number matches the order's stored Moneris data**
before recording the payment. Because the confirmation is authenticated against
Moneris rather than read from the returning request, a forged or mismatched return
is rejected.

## Test before going live

With the gateway in **test** mode and the shared test environment configured, run
a full checkout and confirm the payment records against the order. Switch to
**live** mode and your production Moneris profile/credentials only once the test
flow works cleanly.
