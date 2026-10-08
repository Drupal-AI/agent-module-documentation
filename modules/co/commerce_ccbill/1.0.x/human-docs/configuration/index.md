# Configuration

CCBill is configured like any Commerce payment gateway, with one extra step on the
CCBill side: pointing CCBill's background post‑back (webhook) at your site.

## Store your salt securely

The **salt** is the shared secret that keys the MD5 form digest. Keep it out of
version control — on a DDEV site, store it in an environment variable:

```bash
ddev dotenv set .ddev/.env --ccbill-salt=<value>
ddev restart
```

(`.ddev/.env` must stay out of version control.) Reference it through a **Key**
entity where practical rather than pasting it into exported config.

## Add the gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways/add`).
2. Give the gateway a name and display label, and choose the **CCBill** plugin.
3. Enter your CCBill details:
   - **Client account** and **subaccount** numbers.
   - **FlexForm ID** — the id of the FlexForm the shopper is redirected to.
   - **Salt** — the shared secret used for the form digest (keep confidential —
     see above).
   - **Validate IP** — keep this **enabled** (the default). It restricts accepted
     post‑backs to CCBill's published IP ranges.
4. Choose the **mode** (sandbox/live) and save.

## Wire up the background post-back

In your **CCBill Admin Portal**, enable Webhooks / the background post‑back and set
its URL to your site's notify endpoint, which defaults to
`/payment/notify/{payment_gateway}` (substitute the machine name of the gateway you
just created). This is how CCBill tells your site a payment succeeded. Without it,
orders will never be marked complete even after a successful payment.

## How confirmation works

When CCBill posts back, the module validates the request before recording anything:

1. If **Validate IP** is on (default), it checks the client IP against CCBill's
   published ranges.
2. It recomputes the **MD5 form digest** from your salt and compares it to the one
   CCBill sent.

Only on a `NewSaleSuccess` event (and if no payment already exists for that
transaction) does it create a completed payment, set the order to completed, and
dispatch the `CCBillPaymentEvent`.

## Security caveat to respect

There is a mismatch in what the post‑back verification covers that you should
factor into how you run this gateway:

- **The verified digest does not cover the recorded amount.** The MD5 digest that
  the module validates is computed over the *subscription* price, period, and
  currency fields, but the payment amount the module actually **records** is taken
  from a *different, unsigned* set of post‑back fields (the "accounting" price and
  currency). In other words, the amount that is cryptographically verified is not
  the same field as the amount that gets stored on the order.
- **Practical mitigations:** keep **Validate IP enabled** so only CCBill's servers
  can post back, keep the **salt secret**, and **reconcile the amounts recorded in
  Commerce against CCBill's own transaction reports** rather than trusting the
  recorded amount blindly. Review this behaviour before processing live payments,
  and watch the project for updates.
