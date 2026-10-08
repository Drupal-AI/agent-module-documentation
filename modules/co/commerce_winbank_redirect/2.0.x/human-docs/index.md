# Commerce Winbank (Redirect) — manual setup guide

**Commerce Winbank (Redirect)** (`commerce_winbank_redirect`) adds a **Winbank
(Piraeus Bank)** redirect payment gateway to Drupal Commerce. Winbank provides
card and internet payment services for Piraeus Bank in Greece, and this module is
the common way to accept those payments in a Greek Commerce store.

Because it uses **redirection**, your customers are sent to the bank's hosted page
to enter their card details and then returned to your site. Credit‑card data is
never stored in Drupal's database — which is more secure and avoids the cost of
heavier PCI compliance on your own server.

The callback handling is done correctly: the return/callback route is public
(the bank posts the result to it), but the controller **verifies the response
signature** — it recomputes an **HMAC‑SHA256 `HashKey`** over the returned values
using your transaction ticket and rejects the callback if it does not match. So a
forged callback cannot mark an order as paid. (Two minor, protocol‑dictated
details: the hash comparison uses `!==` rather than `hash_equals`, and the request
password uses the bank‑required MD5 format.)

It depends on **Commerce** (`commerce`) and Commerce **Payment**
(`commerce_payment`). The gateway does **not** work on enable — you must add and
configure a Winbank gateway with your merchant credentials. The 2.0.x release also
includes a first attempt at restoring the site language after returning from the
Winbank redirect.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Winbank gateway and enter
   your merchant credentials.

## Where it lives in the admin menu

Commerce Winbank adds no top‑level admin page. As a Commerce payment gateway you
configure it under **Administration → Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`), choosing **Winbank** as
the plugin. See [Configuration](configuration/index.md); the README also lists the
URLs you must register with the bank for proper communication with your site.
