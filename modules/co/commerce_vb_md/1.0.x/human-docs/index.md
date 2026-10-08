# Commerce VictoriaBank Moldova — manual setup guide

**Commerce VictoriaBank Moldova** (`commerce_vb_md`) integrates the
**VictoriaBank** payment gateway (Moldova) with Drupal Commerce. The shopper pays
through VictoriaBank, and the bank posts a **signed callback** back to your site,
which the module verifies before completing the order. It depends on **Commerce
Payment**.

Setting this gateway up is a little more involved than a typical hosted gateway,
because VictoriaBank uses **RSA key pairs**: you generate your own public/private
key pair, obtain the bank's public key, and place all three PEM files inside a
folder in your site's private file system. The module then uses these to sign your
requests and verify the bank's callback. You'll need to contact a VictoriaBank
manager for the integration instructions and to exchange keys.

**On security (reviewed as sound):** the callback verifies the bank's `P_SIGN`
signature by RSA — it runs `openssl_public_decrypt()` with the **bank's public
key** and compares the decrypted MAC. Because only the bank holds the matching
private key, the signature cannot be forged, so a fake callback cannot mark an order
paid. This is a correct, defensive pattern. The module reads the RSA key pair from
your site's **private filesystem** (`private://vicb_pem/`) — keep those PEM files
there, outside the web root, and never commit them to version control. Note this
module is currently **not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — generate/place the PEM keys, add the
   payment gateway, and set the callback URL.

## Where it lives in the admin menu

VictoriaBank is added under **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md).
