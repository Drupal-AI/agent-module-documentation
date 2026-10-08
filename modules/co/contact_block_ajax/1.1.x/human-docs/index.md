# Contact Block AJAX — manual setup guide

**Contact Block AJAX** (`contact_block_ajax`) lets you place a core Contact form
inside a block that loads **lazily via AJAX** — the form isn't rendered with the
rest of the page, but fetched only when it scrolls into view (using the browser's
Intersection Observer API). Submissions then post via AJAX too, so the visitor
never sees a full page reload.

The point is performance and user experience. Deferring the form until it's
actually visible trims the initial page weight (the project reports a 15–30 %
reduction) and improves Core Web Vitals, which matters most on long pages and on
mobile. It depends on core's **Block** and **Contact** modules.

Beyond lazy loading, the block includes configurable **IP-based rate limiting**
built on Drupal's Flood API, so a single visitor can't hammer the form-load
endpoint. It also plays nicely with the usual anti-spam tools — CAPTCHA, Image
CAPTCHA, reCAPTCHA v2/v3, and Honeypot — and with the Flood Control module. The
form itself still follows core Contact's own access and spam handling; this module
adds no access bypass, only its own permission and rate-limit settings.

Getting started is quick: enable the module, place the block, and pick which
contact form and display mode it should show. The rate-limiting settings are
optional tuning on top of a sensible default.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the block, choose the form and
   display mode, and optionally tune the rate limiting.

## Where it lives in the admin menu

You place the block at **Structure → Block layout**
(`/admin/structure/block`). The optional rate-limiting settings live under
**Configuration → People → Form load rate limit**. Both are covered in
[Configuration](configuration/index.md).
