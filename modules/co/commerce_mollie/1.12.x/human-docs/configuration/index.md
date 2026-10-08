# Configuration

Mollie is set up as a standard Drupal Commerce payment gateway; the module adds no
settings page of its own.

## Add the Mollie gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
2. Click **Add payment gateway** and choose **Mollie** as the plugin.
3. Fill in the configuration (below) and save.

## Gateway settings, field by field

- **API key (test)** *(required)* — your Mollie test key (starts with `test_`).
  Used when the gateway is in test mode.
- **API key (live)** *(required)* — your Mollie live key (starts with `live_`).
  Used when the gateway is in live mode.
- **Mode** — **Test** or **Live**. The gateway activates the API key that matches
  the selected mode.
- **Callback domain** *(optional)* — the base URL Mollie should use to reach your
  webhook. Include the scheme and no trailing slash. Leave empty to use the current
  host. This is mainly useful in local development, where you point Mollie at a
  tunnel domain (for example a localtunnel URL) so its webhook can reach your
  machine.

> **Keep keys out of exported config.** As covered in
> [Installation](../installation/index.md), prefer setting the API keys via an
> environment variable and a `settings.php` override rather than storing them
> directly in configuration that gets committed.

When you save, the gateway warns you if your default order type's workflow lacks a
**validation** step — adding one is recommended so the payment status transitions
work cleanly.

## How the payment flow works

1. At the payment step of checkout, the shopper is redirected to Mollie's hosted
   checkout to pay.
2. When they return, the module checks the payment's state and forwards them to the
   correct checkout step — the completion page if paid, or the cancel step if the
   payment failed, expired, or was cancelled. If the payment is still being
   processed, a short "please reload" holding page is shown.
3. Separately, Mollie calls the module's webhook. The module then **re-fetches the
   payment status directly from Mollie's API** and applies the matching Commerce
   transition (paid → capture, cancelled/failed → void, expired → expire, open →
   authorize). Because the status is re-fetched server-to-server, a forged webhook
   cannot mark an order paid.

## Testing

Set the gateway to **Test** mode with your `test_` key and run an order through
checkout using Mollie's test methods before switching to **Live** mode with your
`live_` key.
