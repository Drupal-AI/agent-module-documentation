# Configuration

Commerce Payeezy is configured as a Drupal Commerce **payment gateway**.

## Add the gateway

1. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
   (Older documentation points to `/admin/commerce/config/payment-methods`.)
2. Choose the Payeezy plugin — the **hosted (offsite)** gateway or the **on-site**
   gateway, depending on how you want customers to pay.
3. Enter your **Payeezy API credentials** (API key, API secret, merchant token, and
   the response/relay key used to verify the hosted return). You get these from your
   Payeezy developer account.
4. Choose **Test** mode while integrating and switch to **Live** for production.
5. Save, then attach the gateway to your **checkout flow**.

## Store your credentials safely

Your Payeezy keys — especially the **response/relay key** used for return
verification — are secrets. Keep the real values **out of version control**: set them
in your environment rather than committing them in exported configuration. With DDEV
you can store a secret as an environment variable and restart so the container picks
it up:

```bash
ddev dotenv set .ddev/.env --payeezy-response-key=<value>
ddev restart
```

(Never commit `.ddev/.env`.) Restrict who can administer payment gateways, and
protect your configuration exports, since gateway settings live in Drupal
configuration.

## Test, then reconcile

- Run test transactions in **Test** mode before going live, and confirm that a
  completed checkout produces a payment on the order at
  **Commerce → Orders → (order) → Payments**.
- As with any gateway, **reconcile your Commerce orders against your Payeezy merchant
  dashboard** before fulfilling — treat your payment provider's records as the source
  of truth rather than the on-screen checkout result alone.
- The hosted gateway records the payment amount from the **server-side order total**,
  so the amount charged is never taken from the shopper's browser.
- This project is **not covered** by Drupal's security advisory policy and is in
  *maintenance fixes only* status; keep it updated and watch its issue queue.
