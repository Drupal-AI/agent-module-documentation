# Commerce Stock Notifications — manual setup guide

**Commerce Stock Notifications** (`commerce_stock_notifications`) adds a "notify me when
this is back in stock" feature to Drupal Commerce. When a product is out of stock, the
module modifies the *Add to cart* form so a shopper can enter their email address and ask
to be told when the product becomes available again. When stock is replenished — tracked
through the [Commerce Stock](https://www.drupal.org/project/commerce_stock) module — the
people who registered interest are notified.

It solves the problem of lost demand: instead of a shopper hitting an out-of-stock product
and leaving for good, you capture their interest and re-engage them the moment the product
returns. Both logged-in and anonymous users can subscribe. Logged-in users can unsubscribe
themselves from `/user/{user}/stock_notifications`; anonymous users cannot unsubscribe on
their own, so an administrator can fetch and share an unsubscribe link from the
administration page.

The module depends on **Commerce** (core, **Cart**, and **Product**), **Commerce Stock**
and its **Stock Field**, and the **Token** module (used to build the notification
messages). It provides its own permissions and requires PHP 7.0+. Because it collects email
addresses for the sole purpose of sending a notification, handle that data with appropriate
consent and privacy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module and
   its dependencies.
2. [Configuration](configuration/index.md) — edit the on-form and email message text, set
   permissions, and manage subscriptions.

## Where it lives in the admin menu

The message settings form is at **Commerce → Configuration → Stock → Stock notifications**
(`/admin/commerce/config/stock/stock-notifications`). Subscription records are managed at
`/admin/structure/commerce_stock_notification`, and permissions are set at
**People → Permissions** (`/admin/people/permissions`).
