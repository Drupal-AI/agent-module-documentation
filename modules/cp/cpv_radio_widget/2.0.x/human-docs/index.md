# Commerce Product Variation Radio Widget — manual setup guide

**Commerce Product Variation Radio Widget** (`cpv_radio_widget`) replaces the default
dropdown that customers use to pick a product variation in Drupal Commerce with a set
of **radio buttons**. When a product has a handful of variations — a few sizes, a
couple of colors — radios lay all the options out in the open, so a shopper sees every
choice at a glance instead of opening a select box, which usually makes the
add-to-cart step clearer and quicker.

It works as an **add-to-cart form widget** for the *Purchased entity* (product
variation) field, and it is themable — a nicer bonus over the stock select. It depends
on **Commerce** and **Commerce Product**, and has no access-control or pricing role;
it only changes how the variation selector is presented.

There is no site-wide settings page. You switch it on per order-item type by choosing
it as the widget on the *Add to cart* form display, and its one option — the display
mode used to render each radio option — is set right there on the widget. That setup
is described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Commerce.

There is **no configuration page** for this module — you configure it directly on the
*Add to cart* form display, described below.

## How to use it

1. Go to **Commerce → Configuration → Order → Order item types**, choose your order
   item type (usually *Default*), and open its **Add to cart** form display. (This is
   the *Manage form display* for the order item's "Add to cart" form mode.)
2. On the **Purchased entity** field, select the **Product variation radio** widget in
   the Widget column.
3. Click the field's **gear icon** to configure the widget. The key option is the
   **display mode** used to render each radio option — pick the view mode you want each
   variation to be shown with next to its radio button.
4. Click **Update**, then **Save** the form display.

View a product on the storefront: the variation selector should now be a group of
radio buttons rendered with your chosen display mode, instead of a dropdown.
