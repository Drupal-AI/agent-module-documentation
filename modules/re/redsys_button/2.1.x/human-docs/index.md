# Redsys payment — manual setup guide

**Redsys payment** (`redsys_button`, version 2.1.x — renamed from "Redsys Button
to Drupal") provides secure **off‑site Redsys** payments for Drupal, and it does
so **without requiring Drupal Commerce**. Customers enter an amount, email,
description, and payment method in a configurable **Redsys payment form** block,
then get redirected to the Redsys hosted payment page — so Drupal never collects
card or wallet credentials. It supports **card, Bizum, PayPal, and xPay** (Apple
Pay / Google Pay), in both test and production environments.

Every attempt is stored as an auditable `redsys_payment` entity, listed under a
permission‑protected admin page, and a confirmation email can go to the customer
and/or an administrator once a payment is confirmed. Version 2.1 adds **payment
requests** (`redsys_payment_request`): fixed‑amount, token‑protected payment links
with an immutable amount and concept, allowed methods, an optional payer email,
and an optional expiry — handy for donations, invoices, and fees. Optional
submodules add a **Webform** payment handler and **Drupal Commerce** gateways that
reuse the same signing and validation core.

**Security posture (this is a payment gateway).** Merchant secrets are stored
through the **Key** module — a hard dependency — and never in exported config.
Requests are signed with **HMAC‑SHA512 V2** by default (legacy terminals can use
**HMAC‑SHA256 V1**). The bank posts results to `/redsys/notify`; that callback is
intentionally public (the bank is unauthenticated) but it is **safe**: the module
verifies the Redsys `Ds_Signature` with a timing‑safe comparison **and** matches
the amount, currency, merchant, terminal, and transaction type against the local
operation **before** anything is marked paid. Processing is **idempotent** (repeat
notifications don't double‑fulfil), and the confirmation email is sent only after
a signed success. The public return/cancel pages are protected by unguessable
per‑operation tokens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and the Key dependency (plus optional submodules).
2. [Configuration](configuration/index.md) — the Redsys settings form field by
   field, the Key‑backed merchant secret, environments, and submodule wiring.

## Where it lives in the admin menu

- **Settings:** **Configuration → System → Redsys settings**
  (`/admin/config/system/redsys-settings`, route
  `redsys_button.redsys_config_form`).
- **Payment audit log:** `/admin/content/redsys-payments`.
- **Payment requests:** `/admin/content/redsys-payment-requests`.
- **Keys** (for the merchant secret): `/admin/config/system/keys`.
- **Commerce gateways** (with the Commerce submodule):
  `/admin/commerce/config/payment-gateways`.

## How to use it

1. Create a **Key** holding the Redsys merchant secret, configure the Redsys
   settings, and place the **Redsys payment form** block where you want to accept
   payments (see [Configuration](configuration/index.md)).
2. For fixed‑amount links, create a **payment request** at
   `/admin/content/redsys-payment-requests` — set the amount, concept, allowed
   methods, optional payer email, and optional expiry, then share the tokenized
   link. Only one attempt is active at a time; rejected/canceled attempts can be
   retried, a confirmed payment permanently closes the request, and every attempt
   stays in the audit log.
3. Review payments any time at `/admin/content/redsys-payments`.
