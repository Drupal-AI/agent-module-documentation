# Configuration

Setting up Monobank has two parts: creating a Basket payment point that uses the
Monobank service, and entering your Monobank token on the gateway settings page.

## 1. Create the Basket payment point

1. Go to **`/admin/basket/settings-payment`**.
2. Create a payment point and choose **Monobank** as its service.
3. After saving, Basket shows a button through to the Monobank gateway's own
   settings page (equivalently, navigate to
   **`/admin/config/development/monobank`**).

## 2. Enter the Monobank token

On the gateway settings page (`monobank.settings`) you enter your Monobank
acquiring **token** and can switch the module into **test mode** while you try
things out.

**Treat the token as a secret.** It authorises invoice creation and status
lookups against your Monobank account, so it should not be committed to your
repository or exported into configuration in plain text. The safe pattern on this
project is to keep the value in an environment variable:

```bash
ddev dotenv set .ddev/.env --monobank-token=<your-token>
ddev restart
```

The flag becomes the environment variable `MONOBANK_TOKEN` in the web container.
Prefer surfacing it through a **Key** entity (install the Key module if needed)
with the built-in environment provider, or read it with `getenv('MONOBANK_TOKEN')`
where a Key entity does not fit. Because the module calls Monobank's servers, make
sure your site's outbound network allows HTTPS requests to the Monobank API.

## 3. Payment status callback

The status callback at **`/monobank/status`** receives Monobank's payment status
POST and marks an order paid (triggering Basket's `paymentFinish()` fulfilment).
The user-facing result page checks the payment via Monobank's server-side
`getStatus()`.

- **Serve the site over HTTPS** so tokens and callbacks are encrypted.

## Test first

Use test mode to run a payment end to end, then switch to live once you have
confirmed the happy path and your fulfilment flow.
