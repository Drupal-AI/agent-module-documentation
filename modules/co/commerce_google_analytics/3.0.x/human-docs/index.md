# Commerce Google Analytics — manual setup guide

**Commerce Google Analytics** (`commerce_google_analytics`) sends your Drupal
Commerce order data to Google Analytics so you can see completed purchases in
GA's e-commerce reports. It is a contribution to Drupal Commerce that handles the
plumbing between a placed order and GA's e-commerce tracking.

When a customer completes checkout and the order is *placed*, the module builds a
GA e-commerce transaction — order total, currency, store, the billing
city/region/country, and one line per order item (SKU, name, category, price,
quantity) — and hands it to the **GA Push** module, which does the actual
delivery to Google Analytics. In the 3.0.x version it tracks the **purchase
(order placed) event only**; it does not track product views, add-to-cart, or
individual checkout steps, and it no longer uses Rules (older Drupal 7 versions
did).

Because it sends order, product and billing data to Google, treat it like any
analytics integration: obtain the appropriate consent, wire it into your
cookie-consent mechanism, and disclose the tracking as your jurisdiction requires.
It depends on Commerce Order and GA Push, and runs on Drupal 10 and 11.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its GA Push dependency.

There is **no dedicated settings page** for this module. All configuration
happens in **GA Push** (your Google Analytics account and how transactions are
delivered), described below.

## Where it lives in the admin menu

Commerce Google Analytics has **no settings form of its own** and adds no
permissions. The relevant configuration lives in the module it builds on:

- **GA Push** global settings at **Configuration → System → GA Push**
  (`/admin/config/system/ga-push`) — where your Google Analytics account and the
  dispatch method (for example the PHP-GA library) are set up.

## How to use it

1. First set up **Google Analytics** and **GA Push** for your site — configure
   your GA account in GA Push at **Configuration → System → GA Push**
   (`/admin/config/system/ga-push`). Configuring GA Push to work with the PHP-GA
   library (or UTMP-PHP) is recommended, as it sends transactions server-side and
   reduces the chance of a purchase not reaching GA.
2. With this module enabled, a GA e-commerce transaction is sent automatically
   whenever a Commerce order is placed (checkout completion) — there is nothing
   to switch on and no Rules reaction to configure.
3. Confirm consent and disclosure are in place before you rely on the data, since
   order and billing information is being sent to Google.
4. Place a test order and confirm the transaction appears in your GA e-commerce
   reports.

## Customising the data (for developers)

If you need to change what is sent, the module exposes three alter hooks —
`hook_commerce_google_analytics_transaction_alter()`,
`hook_commerce_google_analytics_item_alter()`, and
`hook_commerce_google_analytics_items_alter()` — documented for agents in
[`agent/hooks.md`](../agent/hooks.md).
