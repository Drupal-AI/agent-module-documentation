# Tap Payment — manual setup guide

**Tap Payment** (`tap_payment`) accepts payments through **Tap Payments' hosted
checkout**. What sets it apart is that it is built on a small, reusable
payment-gateway plugin API that *any* Drupal module can drive — it does **not**
require Drupal Commerce. You can take a payment straight from your own custom module,
or use one of the optional integration submodules. Card data never touches your site
(the payer enters it on Tap's hosted page), and payment confirmation is
**webhook-authoritative and signed**, so the outcome your site records is the one
Tap actually confirms.

The flow, in plain terms: your code hands the module a payment request (an amount, a
customer, a return URL and a little context about what is being paid for). The module
creates a charge with Tap, records it in a local **transaction ledger** with an
idempotency key, and sends the payer to Tap's hosted checkout page. The browser
coming back is never trusted on its own — the module re-reads the charge from Tap,
and Tap independently posts a **signed webhook** to confirm the real result. Your own
module can subscribe to events (payment created, captured, failed, cancelled) to
fulfil an order once money is actually taken.

The design is deliberately hardened and was reviewed as sound. The webhook endpoint
is necessarily open (Tap posts to it server-side with no session), but it is
authenticated by verifying an HMAC signature *before* any field is trusted, and it is
flood-limited and freshness-bounded; before an outcome is recorded, the charge it
names is matched against the site's own ledger row by charge id, amount and currency.
The payer-return endpoint is addressed by an unguessable UUID and reveals nothing.
Duplicate charges are prevented by a unique idempotency key, replays are harmless
no-ops via a one-way state machine, secret keys are write-only in the settings form
(never shown back), and a log sanitizer strips keys, tokens, cards and emails out of
logs. TLS verification is left at Guzzle's secure default. Which environment you are
in — sandbox or production — is decided purely by which secret key you configure.

It requires **PHP 8.3 or newer** and Drupal 10.3+, 11 or 12, plus a Tap Payments
account and API keys. Optional integration submodules add **Drupal Commerce** and
**Webform** support on the same underlying service (those submodules require the
respective projects). Note the base project is not currently covered by Drupal's
security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## What is new in 1.2.x

Version 1.2.0 is a **compatibility-only** release. It adds **Drupal 12** support
(alongside the existing Drupal 10.3 and 11) and updates how the module reports its
status on the *Status report* page so that it works cleanly across all three Drupal
versions. Nothing about how payments are taken, confirmed or stored has changed, and
no configuration or code you depend on needs any adjustment — update the code, run
`drush updatedb`, and rebuild caches as for any release.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and the integration submodule you need).
2. [Configuration](configuration/index.md) — enter your Tap keys, choose the
   environment, and set permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Tap Payment**
(`/admin/config/services/tap-payment`), and the payment ledger is at the
**transactions** list beneath it (`/admin/config/services/tap-payment/transactions`).
Both are gated by permissions (see Configuration).
