# Commerce Promo Link — manual setup guide

**Commerce Promo Link** (`commerce_promo_link`) lets you apply a Commerce promotion
(coupon) code through a **URL**. Instead of asking a customer to type a code at
checkout, you share a link that pre-applies the discount when clicked — ideal for
marketing campaigns, email blasts, and social posts where a single tappable link
converts better than "use code SAVE10 at checkout".

The link format is `/commerce/promotion/{code}` — for example
`/commerce/promotion/10-TEST` applies the coupon `10-TEST`. A request with no
destination is redirected to the front page; you can send the visitor somewhere
specific by adding a `destination` query parameter, for example
`/commerce/promotion/10-TEST?destination=/node/2`.

It is a thin marketing convenience: the actual promotion logic stays entirely with
Drupal Commerce. This module simply applies the code. It depends on **Commerce
Promotion** (`commerce_promotion`) and supports Drupal 8, 9, 10, and 11.

One thing to keep in mind: because the code travels in the URL, it is **shareable and
loggable** — which is exactly the point of a promo link, but it does mean the code is
not secret. Make sure the promotion's own rules still do their job: a URL should not
be able to sidestep a coupon's per-user limits, usage caps, or expiry. Confirm those
constraints behave as expected on your site before running a campaign.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce Promotion.

There is **no settings form** — you use the module simply by sharing the promo URL,
described below.

## Where it lives in the admin menu

The module adds no admin page. It works entirely through the URL
`/commerce/promotion/{code}`. Your coupon codes themselves are managed in the usual
place, under **Commerce → Promotions**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Create a Commerce promotion with a coupon code as normal, under **Commerce →
   Promotions**.
3. Share the link `/commerce/promotion/{code}` (using your real code). Clicking it
   applies the coupon.
4. To land the visitor on a particular page after applying, append
   `?destination=/your/path`. Links without a destination go to the front page.
5. Test the link and confirm the promotion's usage limits, eligibility, and expiry
   still apply as intended.
