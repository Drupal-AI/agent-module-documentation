# Commerce Cart Reminder — manual setup guide

**Commerce Cart Reminder** (`commerce_cart_reminder`) helps you **recover lost
sales by automatically emailing customers who abandon their carts**. When a shopper
adds items and then leaves without checking out, the module — after a delay you
configure — sends them a reminder email containing a secure, personalized link.
Clicking that link restores their cart exactly as they left it, on any browser or
device, so they can pick up where they stopped instead of hunting for the products
again.

The emails are built from a template you control, with a rich‑text editor and
token support (for example `[user:name]`, `[user:mail]`, and a secure
`[cart:link]`). Clicking the restore link validates the link's per‑cart token and
then restores the cart into the visitor's session — whether they are logged in or
anonymous — merging its items with any cart they already have. Beyond
the automated reminders, admins can generate a **secure referral link from any
past order** — share it with a customer (or let a customer share it with a friend)
and clicking it pre‑fills a cart with that order's items, which is handy for
reorders, referrals, and bundle promotions.

Operational features include configurable send timing, CC/BCC copies to
administrative addresses for monitoring, a **test mode** that diverts all reminder
mail to a single test address, **bulk sending** from the Commerce order list (with
an option to resend), and automatic deletion of old abandoned carts to keep the
database tidy.

Because the module **emails your customers using their cart and account data**,
treat this as personal data: honour marketing‑consent and privacy rules, respect
unsubscribe expectations, and keep the send frequency sane so reminders don't read
as spam. Always exercise the built‑in **test mode** before pointing reminders at
live customers. The module depends on Commerce **Cart** (`commerce_cart`) and the
**Token** module, and works on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Cart and Token.
2. [Configuration](configuration/index.md) — the settings form (timing, email
   template and tokens, CC/BCC, test mode, cart cleanup) and the bulk‑send flow.

## Where it lives in the admin menu

The settings form is at
`/admin/config/commerce/cart-reminder/settings`. Bulk reminder actions appear on
the Commerce **order listing** page, and referral links are generated from an
individual **order's detail page**.
