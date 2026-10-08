# Khalti — manual setup guide

**Khalti** (`khalti`) is a **Drupal Commerce payment gateway** for
[Khalti](https://khalti.com/), Nepal's leading digital wallet and payment
gateway. It integrates the **Khalti ePay v2 Web Checkout (KPG‑2)** so a Nepali
store can accept online payments in **Nepalese Rupees (NPR)** — via the Khalti
wallet, eBanking, mobile banking, SCT/VISA cards, and ConnectIPS — through an
offsite redirect checkout flow.

At checkout the customer is redirected to a Khalti‑hosted payment page. Payment
is initiated **server‑side**, so your secret key never leaves your server. When
the customer returns, the module does **not** trust the query parameters Khalti
appends to the return URL — instead it verifies the payment **server‑side via the
Khalti Lookup API** before updating the order, and it handles all seven Khalti
payment statuses explicitly. This is the correct, defensive posture for a payment
callback (see the note below).

The gateway needs a **Khalti merchant account** (sandbox at
`test-admin.khalti.com`, live at `admin.khalti.com`) and a store configured in
NPR. Khalti works in *paisa* (1 NPR = 100 paisa; minimum Rs. 10 = 1000 paisa), a
detail the module handles for you once your store currency is NPR.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the Drupal Commerce suite.
2. [Configuration](configuration/index.md) — enable NPR, add the payment gateway,
   enter your secret keys securely, and test in the sandbox.

## Where it lives in the admin menu

Khalti has no standalone settings page. It registers a **payment gateway plugin**
that you add and configure under **Commerce → Configuration → Payment Gateways**
(`/admin/commerce/config/payment-gateways`). Currency and store settings live
under **Commerce → Configuration → Currencies** and **→ Stores**.

## A note on the return/callback (please read)

Payment modules are most often insecure at the moment the shopper returns from
the gateway. Khalti gets this right, and it's worth knowing why so you don't
"simplify" it away:

- The return handler (`/khalti/success/{token}`) is bound to a **session token**
  generated during checkout and compared with **`hash_equals()`** — a mismatch
  returns 403, so a return URL cannot be replayed against another session.
- The controller **verifies the payment server‑side through Khalti's Lookup API**
  and updates the order from that authoritative result — it never marks an order
  paid based on the callback's own query parameters ("never trust the callback
  parameters alone").
- Orders are always unlocked after the redirect, regardless of outcome, so a
  shopper is never stranded on a locked order.

If you customise the checkout flow, keep the **Payment** and **Payment process**
panes in place and in order so this verification step runs.
