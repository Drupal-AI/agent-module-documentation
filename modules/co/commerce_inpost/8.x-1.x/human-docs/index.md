# Commerce InPost — manual setup guide

**Commerce InPost** (`commerce_inpost`) adds **InPost** as a shipping option for
Drupal Commerce. InPost is best known in Poland for its **parcel lockers**
(*Paczkomaty*) — self-service pickup points where a courier drops a parcel and
the customer collects it with a code. This module lets your store offer that
option at checkout: shoppers choose InPost as their shipping method and then
**pick the locker** they want to collect from, on an interactive map.

Two things are worth understanding up front about how it works:

- The **price is a flat amount you set yourself** on the shipping method (a rate
  label and a fixed amount, just like Commerce's built-in Flat Rate). The module
  does **not** fetch live quotes from InPost.
- The **locker map is InPost's own "easyPack" widget**, which runs in the
  shopper's **browser** and loads directly from InPost (`geowidget.easypack24.net`).
  It needs **no API key or account credentials**, and Drupal itself does not call
  InPost's servers. When a shopper selects a locker, its name and address are
  saved on the order so you can see where to send the parcel.

It builds on Drupal Commerce's shipping framework, so it depends on **Commerce**
(`commerce`), **Commerce Checkout** (`commerce_checkout`), **Commerce Shipping**
(`commerce_shipping`) and **Commerce Order** (`commerce_order`). Once enabled,
InPost appears alongside your other shipping methods and is configured the same
way.

One scope note: the module **captures and displays** the shopper's locker choice
(and a delivery phone number). It does **not** create InPost shipping labels or
track parcels. You complete fulfilment outside Drupal — for example in InPost's
own ManagerPanel — using the locker and phone shown on the order.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the Commerce Shipping dependency.
2. [Configuration](configuration/index.md) — add the InPost shipping method, set
   its flat rate, and enable the InPost panes on your checkout flow.

## Where it lives in the admin menu

InPost is a **shipping method**, not a payment gateway. After you enable the
module, add and configure it under **Administration → Commerce → Configuration →
Shipping methods** (`/admin/commerce/config/shipping-methods`). From there you
create a new shipping method, select **InPost Shipping** as its plugin, and fill
in the rate options described in [Configuration](configuration/index.md). You
then enable the InPost checkout panes on your checkout flow so the locker picker
appears at checkout.
