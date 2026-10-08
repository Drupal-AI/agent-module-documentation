# Commerce Valitor payment method — manual setup guide

**Commerce Valitor** (`commerce_valitor`) provides a Drupal Commerce payment
gateway for the **Valitor** payment platform (now part of Rapyd), including
**tokenised cards** and **3‑D Secure** card verification. Customers pay by card
during checkout, the card can be tokenised into a reusable payment method, and a
3DS verification step runs in a popup before the charge is taken. It depends on
**Commerce Payment**.

Under the hood the `Valitor` gateway plugin talks to Valitor's Pay API to create
virtual (tokenised) cards and take payments, and a `ValitorMock` plugin is bundled
for automated testing. The 3‑D Secure flow is driven by a controller: it opens the
issuer's 3DS window, renders an intermediate redirect page, and receives the 3DS
result on a webhook that inspects the returned `mdStatus` and shows a success or
"problem validating your card" message. You get add, edit, and refund plugin forms
for managing stored payment methods.

**On security (reviewed as sound):** capture/settlement uses the **order‑derived
amount** (`$payment->getAmount()`), so the amount charged is never taken from
request input. The three controller routes — the verify endpoint, the `/valitor/3ds`
redirect page, and the `/valitor/webhook` endpoint — are declared with open access
(`_access: 'TRUE'`) because they are called by the shopper's browser and the 3DS
processor mid‑checkout; importantly, the webhook only **renders the verification
result** and does not itself move money or perform an authenticated state change.
Keep your Valitor **API key/credentials** as secrets and serve the site over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Valitor payment gateway,
   enter credentials securely, and understand the 3DS flow.

## Where it lives in the admin menu

Valitor is added under **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`, route
`commerce_payment.configuration`). See [Configuration](configuration/index.md).
