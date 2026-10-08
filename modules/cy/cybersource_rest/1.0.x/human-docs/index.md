# Cybersource REST (Microform) — manual setup guide

**Cybersource REST (Microform)** (`cybersource_rest`) is a payment gateway for
**Drupal Commerce** that takes card payments through Cybersource's REST API using
**Flex Microform v2**. The card number and CVV are typed into Cybersource‑hosted
iframes on your checkout page, so the raw card data never reaches your Drupal
server — the browser instead receives a single‑use transient token, which the
site charges server‑to‑server. Because your server never handles the PAN or CVV,
this integration typically qualifies for a reduced PCI scope (SAQ A / A‑EP —
confirm with your acquirer or QSA).

It also offers optional **3‑D Secure 2.x / Strong Customer Authentication** via
built‑in Payer Authentication (EMV 3DS 2.x, with Cardinal Commerce built into
Cybersource — no separate Cardinal account). Frictionless authentications carry
the result straight into the authorization; challenges open in a modal iframe and
are validated server‑to‑server. The integration **fails closed**: with 3‑D Secure
enabled, a payment that skipped or tampered with the authentication steps is
refused before any charge is attempted.

A defining feature of this module is that it keeps **API credentials out of your
site configuration entirely** — they live in a private `.yml` file outside the
web root, never in config exports, the database, or git. The charged amount and
currency always come from the order (never from client input), and capture, void,
and refund all verify the Cybersource status before recording money movements. It
requires **Drupal 10.3+ or 11, Commerce 3**, and the official Cybersource PHP SDK
(installed by Composer).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set up the private filesystem.
2. [Configuration](configuration/index.md) — place the credentials file and add
   the payment gateway in Commerce, field by field.

## Where it lives in the admin menu

Cybersource REST registers itself as a Commerce payment gateway. You add and
configure it under **Administration → Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`) by adding a new gateway of
type **Cybersource REST**. Its credentials, however, are *not* entered in that
form — they come from a private `.yml` file you place on the server (see
[Configuration](configuration/index.md)). The gateway panel shows a status
warning when that file is missing.

## A note on the return route (security)

3‑D Secure uses a small set of routes. The device‑data and enrollment routes are
session‑authenticated — the caller must own the order, the gateway must be an
enabled Cybersource REST gateway with 3‑D Secure on, and a valid CSRF header
token is required. The ACS **challenge‑return** route is intentionally open
(`_access: TRUE`) because it is the cross‑site return posted by the card issuer
with no Drupal session; it is side‑effect‑free, reads no request data, and only
signals the parent window that the challenge finished. The authentication result
itself is validated **server‑to‑server** during the payment request, and it is
session‑bound, single‑use, and never travels through the browser. This posture
was reviewed and found sound.
