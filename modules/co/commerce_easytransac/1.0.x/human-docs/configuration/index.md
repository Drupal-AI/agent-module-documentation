# Configuration

Commerce EasyTransac is configured in two places: each **payment gateway** you
add, and an optional **module settings** page.

## Add the gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Choose **EasyTransac** (or the **Pay by bank** variant).
4. Paste your **API Key**. The mode is derived automatically from the key prefix:
   keys starting `et_test_` run in **Demo** mode, `et_live_` in **Real** mode — so
   there is no separate mode selector to set.
5. Copy the read‑only **Notification URL** shown on the form (this is the
   Commerce notify route for this gateway) into your EasyTransac application
   settings. Also authorise your web server's IP address in EasyTransac, as their
   setup requires.
6. On the EasyTransac (card) gateway, optionally enable **OneClick payments**
   (saved cards for authenticated users) and **Multiple (instalment) payments**,
   choose the allowed instalment counts (2–12), and set a **pre‑authorisation
   duration** (1–30 days) if you use authorise‑then‑capture.
7. Save.

## Module settings page

There is a global settings page at **Administration → Commerce → Configuration →
EasyTransac** (`/admin/commerce/config/easytransac`) for module‑wide EasyTransac
options, controlled by the **administer commerce easytransac** permission. Grant
that permission only to trusted roles.

## Handle the API key as a secret

Your EasyTransac API key is a secret. The key doubles as the signature key that
verifies notifications, so protect it: store it in an environment variable and
reference it through a **Key** entity rather than pasting a live key into exported
configuration.

```bash
ddev dotenv set .ddev/.env --easytransac-api-key=<value>
ddev restart
```

Restrict who can edit payment gateways, and use separate test (`et_test_`) and
live (`et_live_`) keys for your development and production environments.

## How a payment is verified

You do not have to configure this — it's how the gateway protects you — but it's
worth understanding. The customer pays on EasyTransac's hosted form and returns to
the gateway's return handler, while EasyTransac also sends a server‑to‑server
notification. **Both** paths verify EasyTransac's signature using your account API
key before the payment is trusted; the return additionally checks that the order
id and the customer's user id match. The payment amount and state are read from
the **verified** EasyTransac response and mapped to Commerce states
(captured → completed, authorized → authorization, plus refunded, pending and
failed) — never from client‑supplied values.

## Payment operations

From the order's payments, you can **capture** an authorised payment, **void** an
authorisation, and **refund** a completed payment (full or partial). Two extra
operations, **Synchronise** and **Status**, re‑query EasyTransac to reconcile a
payment's remote state.
