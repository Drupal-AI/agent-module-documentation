# Commerce Cookie Condition — manual setup guide

**Commerce Cookie Condition** (`commerce_cookie_condition`) adds a reusable
Drupal Commerce condition called **"Current user has cookie"**. It evaluates to
true when a named cookie is present on the visitor's request and matches a value
you configure. Because it plugs into Commerce's condition system, you can use it
anywhere conditions apply — promotions, payment gateways, shipping methods, and
other condition‑driven business rules.

The problem it solves is targeting. Marketing campaigns often drop a cookie (a
promo code, a UTM tracking value, an A/B‑test flag), and you want to react to it:
unlock a discount, steer pricing, or show a partner offer only to visitors who
carry that cookie. This module lets you express that as a normal Commerce
condition, with no custom code.

One thing to be clear about up front: this is a **marketing / targeting tool, not
a security control**. Cookies are supplied by the browser and can be set or
spoofed by the client, so never use this condition to gate anything that must be
tamper‑proof. Treat it as a way to personalize offers, not to protect access.

The condition plugin (`user_cookie_condition`) appears under the **Customer**
category, targets `commerce_order`, and is designed to be added inside a
`commerce_promotion`. It depends only on **Drupal Commerce** (`commerce`) and
runs on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
configure it per‑instance when adding the condition to a promotion, described in
"How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You reach the condition from wherever
Commerce conditions are configured — most commonly a promotion at **Commerce →
Promotions** (`/promotion`), on its **Conditions** section.

## How to use it

1. Go to **Commerce → Promotions** and add or edit a promotion (or open any other
   host that supports Commerce conditions).
2. In the **Conditions** section, add a new condition and choose **Current user
   has cookie** (under the **Customer** category).
3. Enter the **cookie name** (for example `promo_code`) and the **expected value**
   (for example `SUMMER2025`). The condition matches when both the presence and
   the value line up.
4. Save the promotion.

The condition composes with other Commerce conditions using the promotion's
own AND/OR logic, so you can layer cookie targeting on top of order‑total,
product, or customer conditions.
