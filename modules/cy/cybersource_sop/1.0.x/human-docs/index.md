# Cybersource SOP — manual setup guide

**Cybersource SOP** (`cybersource_sop`) is a payment gateway for **Drupal
Commerce** that takes credit and debit card payments through **Cybersource Secure
Acceptance in Silent Order POST (SOP)** mode. Shoppers enter their card details on
your own styled checkout page — there's no redirect to a hosted page — but the
card number and CVV are POSTed **straight from the browser to Cybersource** and
never touch your server. Cybersource then returns a digitally signed result,
which the module verifies before recording the payment against the order.

The security model rests on **HMAC‑SHA256 signatures**. The outbound Secure
Acceptance form fields — including the amount, currency, and reference number —
are signed with your profile's shared secret, so the customer's browser cannot
tamper with the signed values. On the way back, a reply is **rejected unless its
signature verifies**, and verification additionally requires that the signature
*covers* every field the payment logic acts on (decision, reason code, reference
number, transaction id, amount, currency) — so a reply that appends an unsigned
amount is refused. The recorded amount and currency always come from the order,
never from the returned POST, and the same transaction is never recorded twice
(replay guard).

Like its sibling module, Cybersource SOP keeps credentials in an external `.yml`
file (one test profile for all currencies, one live profile per currency), never
in Drupal configuration. It supports **Authorize** and **Sale** transaction
types, records Decision Manager reviews as pending authorizations, and warns you
on the status report before a security key expires. It requires **Drupal 10.3+ or
11** and Drupal Commerce; no third‑party PHP libraries are needed (signing uses
PHP's built‑in `hash_hmac()`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set up the private filesystem.
2. [Configuration](configuration/index.md) — place the credentials file, add the
   gateway in Commerce, and set up the Secure Acceptance profile.

## Where it lives in the admin menu

Cybersource SOP registers itself as a Commerce payment gateway. You add and
configure it under **Administration → Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`) by adding a new gateway of
type **Cybersource (Secure Acceptance SOP)**. Credentials come from a private
`.yml` file rather than the form; the gateway panel reports whether that file is
present.

## A note on the return and cancel routes (security)

Cybersource POSTs its signed reply back to two routes,
`/cybersource-sop/return/{order}` and `/cybersource-sop/cancel/{order}`. These are
intentionally open (`_access: TRUE`) because they receive a cross‑site POST with
no Drupal session — **the authentication is the HMAC signature, not a login**. The
gateway verifies that signature inside `onReturn()` / `onCancel()` using
constant‑time comparison (`hash_equals`), enforces that the signature covers all
the fields it acts on, and refuses to record a payment whose signed amount or
currency does not match the order total. This callback‑verification posture was
reviewed and found sound.
