# Commerce Shipping Best Rate — manual setup guide

**Commerce Shipping Best Rate** (`commerce_shipping_best_rate`) tidies up the
shipping choices your customers see at checkout. Instead of confronting them with
a long list of similar options with cryptic names, you **group several shipping
services together and show only the best (cheapest) price in each group** under a
single, friendly label. So "UPS Ground", "FedEx Ground" and "USPS Ground" can
collapse into one line — "Ground 3–5 days" — priced at whichever is lowest.

It exists to simplify checkout and reduce cart abandonment caused by choice
overload. The rates themselves are still computed by **Commerce Shipping**; this
module only filters and relabels what gets displayed. It depends on
`commerce_shipping` and supports **Drupal 10.2+ and 11**.

A nice touch for staff: grouping can be **disabled per role**. A "Sales" role,
for instance, can be allowed to see the full list of individual rates and pick
from them, and you can even show best-rate *and* regular rates together for
selected roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create a best-rate shipping method,
   group your services, and get the sort order right.

## Where it lives in the admin menu

You configure it as a shipping method under **Administration → Commerce →
Configuration → Shipping methods** (`/admin/commerce/shipping-methods`): add a
shipping method that uses the **Best rate** plugin. See
[Configuration](configuration/index.md).
