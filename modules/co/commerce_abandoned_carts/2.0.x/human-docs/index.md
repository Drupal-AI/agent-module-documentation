# Commerce Abandoned Carts — manual setup guide

**Commerce Abandoned Carts** (`commerce_abandoned_carts`) helps you recover lost
sales. When a shopper adds items to a Drupal Commerce cart but leaves without
completing checkout, the module notices that idle cart (a *draft* order) and
emails the customer a friendly reminder to come back and finish their purchase —
no marketing SaaS or custom code required.

It runs quietly on Drupal **cron**. On each cron run it looks for draft orders
that have items, have a customer email on file, went idle longer ago than your
*timeout* but more recently than your *history limit*, and haven't already been
reminded. It sends the reminder through Drupal Commerce's own mail handler, using
a Twig template you can override to match your store's voice, and it records which
orders it has emailed so nobody gets pestered twice.

One safety feature is important to understand up front: **test mode is on by
default**. While test mode is on, every reminder is redirected to a single test
address and orders are *not* marked as sent — so nothing reaches real customers
until you deliberately turn test mode off. That lets you tune the timing and the
email template safely first. Everything — the timeout, the history and per-run
limits, the sender name and address, the subject, an optional support phone
number and BCC, and test mode — is configured on one settings form.

The module requires **Drupal Commerce** (specifically its Checkout submodule).
It has no manual "send now" button; sending happens only on cron, so make sure
real cron is running on a schedule.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside
   Commerce and enable the module.
2. [Configuration](configuration/index.md) — the settings form field by field,
   test mode, and the checklist for going live.

## Where it lives in the admin menu

The settings form is at **Commerce → Configuration → Abandoned carts**
(`/admin/commerce/config/abandoned_carts`). Access is gated by the **Administer
commerce abandoned carts** permission.

## How to use it

1. Enable the module and confirm cron runs on a real schedule (see
   [Installation](installation/index.md)).
2. Open the settings form and tune the timing, sender, and subject — while **test
   mode stays on** so nothing reaches customers yet.
3. Preview the reminder by letting cron run with test mode on (all mail goes to
   your test address; the same carts re-send each run so you can iterate on the
   template).
4. When you're happy, turn **test mode off** to go live. From then on real
   customers receive reminders and each order is recorded so it's never emailed
   twice.
