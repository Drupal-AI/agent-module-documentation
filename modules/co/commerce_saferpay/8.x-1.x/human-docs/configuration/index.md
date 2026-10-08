# Configuration

Saferpay is configured the same way as any Drupal Commerce payment gateway: you
add a gateway entity and fill in its settings. There is no separate global
settings page.

## Before you start: store your Saferpay credentials as secrets

Your Saferpay **API user password** is a secret. Do not type production secrets
into a form whose values then get exported into version-controlled
configuration. The safe pattern on this project is to keep the value in an
environment variable and expose it through a **Key** entity:

1. Save the value into DDEV's env file (never commit `.ddev/.env`):
   ```bash
   ddev dotenv set .ddev/.env --saferpay-api-password=<value>
   ddev restart
   ```
2. Make sure the Key module is available:
   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ```
3. Create a Key that reads the environment variable:
   ```bash
   ddev drush key:save saferpay_api_password --label='Saferpay API password' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"SAFERPAY_API_PASSWORD","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

Where the gateway form does not offer a Key selector, keep the secret out of
exported config by overriding it from `settings.php` instead.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a **Name** customers-facing staff will recognise (for example
   "Credit card (Saferpay)").
3. Choose the **Saferpay PaymentPage** plugin (this is the current JSON API
   gateway — it lives in the main module).

## Gateway settings, field by field

- **Mode (Test / Live)** — Saferpay uses different endpoints and credentials for
  test and live. Start in **Test**, run test transactions, and only switch to
  **Live** once everything reconciles. Confirming the mode before go-live is the
  single most common source of "it worked in test but not in production" issues.
- **Customer ID** — your Saferpay customer identifier.
- **Terminal ID** — the Saferpay terminal to route transactions through.
- **API user name** and **API user password** — the API credentials Saferpay
  issued for the selected mode. Enter the password from the Key/secret you set up
  above rather than pasting a production secret directly. Remember test and live
  have *different* credentials.
- **Order identifier** *(required)* — the reference sent to Saferpay as the
  `OrderId`. If the Token module is installed you can use `commerce_order`
  tokens (for example the order number); when left blank at runtime the module
  falls back to the internal order id.
- **Order description** *(required)* — the text shown to the customer on
  Saferpay's payment page. Supports the same tokens.
- **Auto finalize payment by capture of transaction** — when ticked, an
  authorized transaction is captured (settled) immediately; untick it to
  **authorize only** and capture later from the order's Payments tab.
- **Auto assert refunds** — when ticked, a refund is captured automatically
  after it is created.
- **Allowed payment methods** — optionally limit which Saferpay payment means
  (card brands, Twint, etc.) are offered. Selecting none means all are allowed.
- **Request alias**, **debug logging**, and **webhook wait time** are optional
  advanced settings; leave them at their defaults unless you have a specific
  reason (webhook wait is a *blocking* delay and should normally stay 0).

Saferpay uses an **external (hosted) payment page** — customers always enter card
details on Saferpay, so there is no card form on your site to configure.

## Save and test

Click **Save**. Place a test order end to end: you should be redirected to
Saferpay's hosted page, and on return the order's payment should reflect the real
status that the module fetched back from Saferpay's API. Because the module
asserts the result server-to-server, a tampered return URL cannot mark an order
paid — but you should still verify a full round-trip in Test mode before going
live.
