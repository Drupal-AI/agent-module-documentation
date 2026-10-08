# Configuration

CM.com Payment is configured the same way as any Drupal Commerce gateway — by adding
a payment gateway to your store, not through a dedicated settings page.

## Add the CM.com gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
2. Click **Add payment gateway**.
3. Give it a name (for example "CM.com") and choose the **CM.com** plugin as the
   gateway type.

## Fill in the gateway settings

On the gateway form you'll enter the three credentials CM.com issued for your
account — **Merchant name**, **Password** and **Merchant key** — which the module
uses both to send the shopper to CM.com and, on their return, to verify the order
status server‑side. (An optional **Debug** checkbox adds request/response detail to
the Drupal log; leave it off in production.) Set the gateway **mode** to **Test**
while you're integrating and switch it to **Live** for production.

### Keep the credentials restricted

The merchant name, password and merchant key are secrets that CM.com issued for your
account. They are stored in the payment‑gateway configuration, so restrict who can
reach the Payment gateways admin pages to trusted administrators, and be careful when
exporting/committing configuration. If you prefer to keep the values out of exported
config, you can supply them through a settings.php config override rather than typing
them into the form.

## How the payment flow works

At checkout the shopper is redirected to CM.com to pick a payment method and pay.
When they return, the gateway makes a server‑to‑server call to CM.com's API to read
the authoritative order status, and only completes the payment if CM.com reports
success — it never trusts a status supplied by the browser. Test a full order in
**Test** mode before going live.

## Save

Save the gateway. It's now available during checkout for the store(s) it's enabled
on.
