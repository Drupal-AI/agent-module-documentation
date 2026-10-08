# Commerce Configurable Order Total — manual setup guide

**Commerce Configurable Order Total** (`commerce_configurable_order_total`) gives
you control over how the order-total summary is displayed for Drupal Commerce
orders. Instead of the fixed subtotal / adjustments / total block that Commerce
renders by default, it provides a **Views area handler** you can drop into a View
and configure to show exactly the lines you want.

The problem it solves is presentation. Commerce calculates the order total
perfectly well, but the built-in summary is not something a site builder can
easily tailor — you cannot hide the subtotal line, drop the adjustment rows, or
strip trailing zeroes from prices without custom code. This module turns those
choices into per-View options and renders the result through a Twig template you
can override in your theme.

It is purely a display enhancement. It has no payment role, adds no access
control, and does nothing until you add its area handler to a View. It depends
only on **Drupal Commerce** (`commerce`) and requires Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no standalone settings page** for this module. You configure it inside
the Views UI on the area handler itself, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. Everything happens in the Views UI at
**Structure → Views** (`/admin/structure/views`), on whichever View renders your
order summary — typically the **Checkout order summary** view.

## How to use it

1. Go to **Structure → Views** and edit the **Checkout order summary** view (or
   any View where you want a configurable total).
2. In the **Footer** section, remove the default **Order total** area and click
   **Add** to add the **Commerce Configurable Order Total** area instead.
3. In the area handler's settings, choose which parts of the summary to show:
   - **Disable Subtotal** — hide or show the subtotal line.
   - **Disable Adjustments** — hide or show all adjustment lines (taxes,
     discounts, fees).
   - **Disable Totals** — hide or show the grand total line.
   - **Strip Trailing Zeroes** — remove trailing zeroes after the decimal point
     for cleaner price formatting.
4. The area handler uses an **Order ID** argument to know which order to
   summarize, so make sure the View provides one.
5. Save the View.

> **Theming tip:** the summary renders through
> `commerce-configurable-order-total-summary.html.twig`. To restyle it, create a
> `templates/commerce_configurable_order_total` folder in your theme and copy the
> template there to override it.
