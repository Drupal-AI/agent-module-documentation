# Commerce CIB — manual setup guide

**Commerce CIB** (`commerce_cib`) provides an **off‑site payment gateway** for
Hungary's **CIB Bank**. It's the integration Hungarian Drupal Commerce merchants
use to accept card payments through CIB, exchanging DES‑encrypted **SAKI** protocol
messages with the bank and confirming each payment with a server‑to‑server query
rather than trusting the customer's browser on return.

At checkout the shopper is redirected to CIB's hosted SAKI payment page. When they
come back, the module decrypts the response and — crucially — issues its **own
server‑side "close transaction" query** to CIB, inspects the authoritative reply,
and **verifies the returned amount matches the stored payment amount** before
marking the order completed. Anything else voids or leaves the payment pending. It
also implements **refunds** (full and partial, HUF only, with a 100‑HUF minimum),
handles timeouts and communication failures, and ships event subscribers that email
or notify on outcomes such as failed payments, timeouts, and order‑paid.

On security, the confirmation path is sound: payment state and amount are confirmed
server‑side, and amounts derive from the order, so there's no client‑set‑amount or
unverified‑callback exposure. One transport detail is worth noting (covered in
[Configuration](configuration/index.md)): the bank's server‑to‑server "market"
channel is contacted over **cleartext HTTP** on a non‑standard port — this is by
CIB's protocol design, since the payloads are DES‑encrypted at the application
layer, and the customer‑facing channel uses HTTPS.

Setup differs from most gateways in that CIB gives you **DES keyfiles** that must
be placed on your server (separate test and live files), and you configure the
absolute paths to them. Commerce CIB depends on Commerce **Payment**
(`commerce_payment`) and works on Drupal 8, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Payment.
2. [Configuration](configuration/index.md) — adding the CIB gateway, placing the
   DES keyfiles, refunds, and the transport note.

## Where it lives in the admin menu

Like every Commerce payment method, CIB is set up under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). You add a gateway there and choose the
**CIB** plugin.
