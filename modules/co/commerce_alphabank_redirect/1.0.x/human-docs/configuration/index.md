# Configuration

You configure Commerce Alphabank by adding it as a **payment gateway** in Drupal
Commerce and entering the credentials Alpha Bank gave you.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a name (for example "Alpha Bank (card)") and choose the **Alpha Bank**
   redirect plugin provided by this module.

## Key fields

- **Mode: Test or Live** — use Alpha Bank's test environment while you integrate,
  then switch to live once verified.
- **Merchant ID** — your Alpha Bank merchant identifier.
- **Shared secret** — the secret Alpha Bank issued for signing/verifying the
  callback digest. You enter it directly in this gateway field (the module stores
  it in the gateway configuration; it is used server-side and is never sent to the
  customer's browser). Make sure it exactly matches the value configured on the
  bank's side, and treat your Commerce config export as sensitive since the value
  lives there.
- **Post URL** — the bank's VPOS endpoint (a Cardlink test endpoint by default);
  switch it to the production endpoint the bank gives you when going live.
- **Confirm / Cancel URLs** — the success and failure return URLs (they default to
  this module's callback path).

Save the gateway. Alpha Bank now appears as a payment option, and customers are
redirected to the bank's hosted page to pay.

## How the callback is verified

When Alpha Bank calls back after payment, the module computes a **SHA‑256 digest**
over the response fields plus your **shared secret** and compares it with the
digest the bank sent:

- If they **match** and the response is captured/authorized, a **completed**
  payment is recorded and the order is fulfilled.
- If they **don't match**, the module records a non‑fulfilling **"Unvalidated"**
  payment and logs a failure — Commerce treats only *completed* payments as paid,
  so a forged or tampered callback cannot fulfil an order.

This is why the shared secret must stay secret: without it, no one can forge a
valid "paid" callback. Always serve the return/notify endpoints over HTTPS.

## Test before going live

Using Alpha Bank's test environment, place an order and confirm that a genuine paid
response records a completed payment, then switch the mode to **Live**.
