# Meta Pixel — manual setup guide

**Meta Pixel** (`meta_pixel`) brings Meta (Facebook) advertising tracking to
Drupal in a single, cohesive module. It supports both tracking methods at once —
the browser-side **Pixel** (the familiar `fbq` JavaScript) and the server-side
**Conversions API (CAPI)** — and it automatically **deduplicates** events so a
purchase or page view fired through both channels is only counted once. It was
built to unify what used to require juggling the separate `facebook_pixel` and
`meta_conversions_api` modules, and it borrows the plugin-based event approach
from `google_tag`, so developers can register their own custom events.

Out of the box it can track core events such as PageView, CompleteRegistration
(new account creation), and ViewContent (node views). An optional
**Meta Pixel Commerce** submodule (`meta_pixel_commerce`) adds e-commerce events
for Drupal Commerce — ViewContent, AddToCart, InitiateCheckout, AddPaymentInfo,
and Purchase, including AJAX product-variation changes. Server-side tracking (CAPI)
requires the **Facebook PHP Business SDK**, installed via Composer.

Because this module sends visitor and event data to Meta — and CAPI can send
server-side identifiers such as hashed emails, phone numbers, and address data —
it carries real privacy and consent responsibilities. Plan to obtain visitor
consent, integrate it with your cookie-consent mechanism (it can work with EU
Cookie Compliance and respect Do Not Track), disclose the tracking in your privacy
policy, and store the CAPI access token as a secret rather than in exported
configuration. This is an early-stage (alpha) module, so expect its options to
evolve.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (plus the
   Facebook Business SDK for CAPI), enable the module, and add the Commerce
   submodule if you sell online.
2. [Configuration](configuration/index.md) — connect your Pixel/dataset, set up
   the Conversions API token, and handle consent and privacy.

## How to use it

After enabling the module you connect it to your Meta pixel/dataset and choose
which events to send (see [Configuration](configuration/index.md)). The core
events begin firing for the channels you enable; adding the
`meta_pixel_commerce` submodule turns on the e-commerce funnel events for Drupal
Commerce. Developers who need bespoke events can create their own event plugins
following the module's plugin architecture.
