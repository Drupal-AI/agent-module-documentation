# MKC Accelerator Fashion — manual setup guide

**MKC Accelerator Fashion** (`mkc_accel_fashion`) is a vertical accelerator for
clothing and apparel stores built on **MonkeysCommerce**. It adds the pieces a
fashion store typically needs: interactive **size charts**, editorial
**lookbooks**, and a built-in **return/exchange** workflow (with fit
recommendations as part of the vertical's focus).

It introduces two main entities — **SizeChart** (a configurable measurement table
of rows and columns, assignable per product or category) and **Lookbook** (an
editorial collection with a cover image, tagged products and publish scheduling) —
backed by services for size-chart management, lookbook lifecycle, and return/exchange
processing with reason codes and resolution tracking. Two blocks help you surface
this on the storefront: a **Size Guide** block that renders the relevant chart on
product pages, and a **Lookbook** carousel block for landing pages.

As an add-on it depends on MonkeysCommerce core and catalog (`mkc_core`,
`mkc_catalog`) and targets Drupal 11.3+ on PHP 8.2+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module on your MonkeysCommerce store.
2. [Configuration](configuration/index.md) — create size charts and lookbooks,
   place the blocks, and handle returns.

## Where it lives in the admin menu

Once enabled, the module's screens sit under **Commerce → Fashion**:

- `/admin/commerce/fashion/size-charts` — manage size charts.
- `/admin/commerce/fashion/lookbooks` — manage lookbooks.
- `/admin/commerce/fashion/returns` — process return/exchange requests.
- `/admin/commerce/fashion/settings` — module configuration.

Customers submit returns at `/fashion/return-request/{order_id}`.
