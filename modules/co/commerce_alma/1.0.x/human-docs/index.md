# Commerce Alma — manual setup guide

**Commerce Alma** (`commerce_alma`) is a Drupal Commerce payment gateway for
**Alma**, the installment / buy‑now‑pay‑later provider popular in France and across
the EU. It lets customers split a purchase into installments through Alma via an
off‑site redirect flow: the shopper is sent to Alma to arrange the payment, then
returns to your store. Each gateway you configure defines an available **fee plan**
(the installment plan on offer).

It depends on Commerce Payment (`commerce_payment`) and lives in the Commerce
(contrib) package. This is a **beta** release, so verify the flow for your exact
version before relying on it in production. (The "deferred_trigger" option
mentioned in the project is not yet implemented.)

The payment lifecycle is deliberately server‑authoritative, which is what keeps it
safe. In‑progress Alma payments are authorized; paid ones are captured; and a cron
job periodically revisits authorized payments to try to capture them. Crucially,
the module confirms outcomes by **fetching the payment directly from Alma's API**
(via the Alma SDK, using your merchant API key) and updating the order only when
Alma's own authoritative state says it's paid — it does **not** trust an IPN/return
payload's claimed status. Keep your Alma **API key** a secret and serve everything
over HTTPS. Because captures depend on cron, make sure cron runs reliably.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Alma payment gateway, enter
   your API key, choose the fee plan and mode, and confirm cron runs.

## Where it lives in the admin menu

Like every Commerce payment gateway, you add and configure it under
**Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md) for the fields.
