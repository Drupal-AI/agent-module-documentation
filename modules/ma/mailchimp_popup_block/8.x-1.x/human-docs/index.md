# Mailchimp Popup Block — manual setup guide

**Mailchimp Popup Block** (`mailchimp_popup_block`) provides a Drupal block that
triggers **Mailchimp's own hosted subscriber pop-up** — the signup form Mailchimp
generates for you. You place the block in a region, feed it a few identifiers from
your Mailchimp pop-up snippet, and it either shows a button that opens the pop-up
when clicked (**manual** mode) or opens the pop-up automatically on page load
(**automatic** mode).

Importantly, this module handles **no API keys and makes no server-side calls to
Mailchimp**. The only values it needs — the pop-up base URL, your account UUID,
and a list ID — are the *public* front-end identifiers that already appear in
Mailchimp's own embed snippet. Subscription itself is handled entirely by
Mailchimp's hosted form, so there's nothing sensitive stored on your site. The
block comes with deliberately unstyled markup so it's easy to fit into your theme.
It depends only on Drupal core's **Block** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## ⚠️ This module is deprecated

As of mid-2023, **Mailchimp no longer provides the pop-up configuration values**
this module depends on, so the project is deprecated — only existing
configurations are maintained. It also predates Mailchimp's GDPR pop-up handling.
The maintainers note that Mailchimp's subscriber pop-up was historically the only
GDPR-compliant embedding option, but that the current API/module does not
implement Mailchimp's GDPR feature — so for sites with an EU audience, don't rely
on it unless you capture consent another way. For new sites, prefer a
currently-supported subscription approach.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no central settings page — everything is configured **per block**
when you place it, described in "How to use it" below.

## Where it lives in the admin menu

You place and configure the block from **Structure → Block layout**
(`/admin/structure/block`). There is no separate module settings page.

## How to use it

1. Gather the values from your **Mailchimp pop-up snippet**: the pop-up **base
   URL**, your account **UUID**, and the **list ID**.
2. Go to **Structure → Block layout**, choose a region, and **place** the
   "Mailchimp Popup Block".
3. In the block's settings, enter the **base URL**, **UUID**, and **list ID**, then
   choose a **method**:
   - **Manual** — the block renders a **button** (with your custom button text and
     an optional description above it) that opens the pop-up when clicked.
   - **Automatic** — the pop-up opens on page load. In this mode you can set a
     **reappear offset** (in seconds) controlling how long after a visitor
     dismisses the pop-up it may show again. Common choices are a day, a week, or a
     month; set it to **0** to show the pop-up on every page load.
4. Use the block's normal **visibility conditions** to target specific pages (for
   example, only a landing page).
5. Save the block.

You can place **multiple instances** with different pop-up configurations — handy
for running different signups for different audiences or campaigns. The button and
description text can be localised per block.
