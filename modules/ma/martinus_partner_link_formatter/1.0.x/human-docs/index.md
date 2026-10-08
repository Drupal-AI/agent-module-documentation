# Martinus Partner Link Formatter — manual setup guide

**Martinus Partner Link Formatter** (`martinus_partner_link_formatter`) is a small
field formatter for the core **Link** field type. When you display a link that
points at the Martinus eshop (a Slovak online bookstore), this formatter appends
your Martinus **partner (affiliate) ID** to the URL, so that any purchase a visitor
makes after clicking is attributed to your partner account and earns the referral
commission.

It does one focused job: format an existing link so it carries your tracking ID.
It adds no pages, blocks, or blocks of its own — you simply pick this formatter on
a Link field's display and enter your partner ID in the formatter's settings. To
get a partner ID you must first be registered with the Martinus partner program at
<https://partner.martinus.sk>.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate configuration page** for this module. Everything is set on
a Link field's display, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You configure it on a Link field's
**Manage display** tab, under **Structure → Content types → *(your type)* →
Manage display** (or the equivalent Manage display for any entity that has a Link
field).

## How to use it

1. Make sure the entity you are displaying (a node, for example) has a **Link**
   field that can hold Martinus eshop URLs.
2. Go to that entity bundle's **Manage display** tab.
3. For the Link field, choose **Martinus Partner Link Formatter** from the format
   drop‑down.
4. Open the formatter's settings (the gear icon) and enter your **partner ID** —
   the ID issued to you by the Martinus partner program. Do not skip this step:
   without a partner ID the links cannot be attributed to your account.
5. Save the display. From now on, when that field renders a Martinus link, your
   partner ID is added to the URL automatically.
