# Mollie donations — manual setup guide

**Mollie donations** (`mollie_donations`) gives your site a ready-made public
donation form. A visitor opens the form, chooses (or types) an amount, and is
sent to Mollie's hosted checkout to pay by iDEAL, card, or any other method your
Mollie account offers. When they return, the module confirms whether the payment
actually went through. It is the quickest way to collect one-off donations
without building a whole Commerce store.

The form lives at **`/mollie_donations`** and is meant to be linked from a menu
item or block. Behind it, a small service creates the payment through the Mollie
PHP API, remembers the pending payment id in the session's private tempstore, and
sends the donor off to Mollie. After payment Mollie returns the donor to
`/mollie_donations/callback`, where the module decides success or failure.

This module needs configuration before it works: you must enter your Mollie
**API key** and set up your donation amounts on the settings form. The API key is
a live financial credential, so this guide covers storing it safely. Note that
this is a standalone donation form — it uses the Mollie PHP API directly and does
not require the separate "Mollie for Drupal" module or Drupal Commerce.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter the Mollie API key safely, set
   your donation amounts, and publish the form.

## Where it lives in the admin menu

The settings form is at **`/admin/config/services/mollie_donations`** (config
route `mollie_donations.settings_form`), gated by the
`access mollie_donations admin` permission. The public-facing donation form is at
**`/mollie_donations`**.

## A note on the payment callback

When a donor returns from Mollie, the callback route
(`/mollie_donations/callback`) is reachable by anyone (it is gated only by the
"access content" permission), but it is **sound**: the module confirms the
outcome by **re-fetching the authoritative payment status from Mollie's API**
using the stored payment id, rather than trusting anything in the callback
request. In other words, a forged return request cannot make a donation look
paid. Keep the site on HTTPS.
