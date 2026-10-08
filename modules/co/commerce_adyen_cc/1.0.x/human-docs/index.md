# Commerce Adyen (Credit Card) — manual setup guide

**Commerce Adyen (Credit Card)** (`commerce_adyen_cc`) is a Drupal Commerce
payment gateway that accepts card payments through **Adyen**. It integrates with
Adyen's Card Component (their "Web Component") to collect card data securely inside
iframes hosted by Adyen, then processes the payment through Adyen's REST API. It
also supports a custom 3D Secure 2 flow, as required for custom card integrations.

Unlike the older Commerce Adyen project, this module targets Commerce 2.x and
above only, and deliberately does **not** support Adyen's legacy hosted payment
page API. It depends on Drupal Commerce and lives in the Commerce (contrib)
package.

Because this handles real card payments, two things deserve attention. First,
payment outcomes must be confirmed **server‑side with Adyen** — the module talks to
Adyen's API, and for asynchronous results Adyen sends **HMAC‑signed notification
webhooks**. Always verify the HMAC signature on those notifications before treating
an order as paid; never trust a browser return alone. Second, your Adyen **API key
and HMAC key are secrets** — store them outside version control and serve
everything over HTTPS. Note this branch is a development release, so review the
notification/verification flow for the exact version you deploy, and test
thoroughly with Adyen's test cards before going live.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Adyen payment gateway,
   choose test vs live mode, and enter your Adyen credentials.

## Where it lives in the admin menu

Like every Commerce payment gateway, you add and configure it under
**Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md) for the fields.
