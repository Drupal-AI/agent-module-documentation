# Commerce Victoria Bank MIA — manual setup guide

**Commerce Victoria Bank MIA** (`commerce_vicb_mia`) integrates the **Victoria
Bank MIA** payment gateway (Moldova) with Drupal Commerce. The shopper pays by
scanning a **Victoria Bank MIA QR code**, and the bank posts a callback to your
site, which the module uses to complete the order. It depends on **Commerce** and
**Commerce Payment**.

Setup is credential‑based: you obtain a username, password, and your company IBAN
and name from Victoria Bank, enter them on the gateway, and set a QR‑code timeout
(the bank recommends five minutes). You'll need to contact a VictoriaBank manager
for the integration instructions.

**On security (reviewed as sound, with one caveat to note):** when a callback
arrives, the module does **not** trust the callback payload for the payment result.
Instead it **re‑fetches the QR status server‑side** from the bank over an
authenticated request (a Bearer‑token GET), keyed on a QR identifier it stored in
its own database rather than anything from the payload, and completes the order only
when the status is `STATUS_PAID`, using the **order's own total**. That makes it safe
against forged callbacks. The one caveat worth flagging: the module's **JWT
signature check is effectively dead code** (it verifies against an empty secret with
an inverted guard), so the JWT is not actually validated — the security rests
entirely on the server‑side status re‑fetch. Consider fixing the JWT check as
defense‑in‑depth. Store your Victoria Bank MIA credentials securely (env‑backed) and
never commit them. Note this module is currently **not covered by Drupal's security
advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the payment gateway, enter
   credentials securely, and set the callback URL.

## Where it lives in the admin menu

Victoria Bank MIA is added under **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md).
