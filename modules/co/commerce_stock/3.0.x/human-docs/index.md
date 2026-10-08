# Commerce Stock — manual setup guide

**Commerce Stock** (`commerce_stock`, "Commerce Stock API") is the stock and
inventory framework for **Drupal Commerce**. It tracks stock levels for
purchasable entities (product variations) and stops customers adding more of a
product to their cart than is available. It's the foundation that a real
inventory setup is built on — but on its own the base module ships only an
**"Always in stock"** service; to track actual quantities you enable its **Local
storage** submodule.

The core idea is a pluggable **stock service**: each product (or product
variation type) is handled by a stock service that knows how to check
availability and record movements. The base module registers an availability
checker with Commerce, so out‑of‑stock items are refused at add‑to‑cart and
checkout, and it turns order events into stock transactions — decrementing stock
when an order is placed or completed, and restoring it when an order is
cancelled. You choose which service applies (a site‑wide default plus per‑product
overrides) and how order events drive stock on a single config form.

Because it's a framework, most of the real functionality comes from its
**submodules**: **Local storage** adds a database‑backed service with real stock
levels, locations, and transactions; **Field** exposes a stock‑level field to
editors; **UI** gives warehouse staff transaction forms; and **Enforcement**
blocks out‑of‑stock items in the cart and checkout. Developers can also add
custom stock backends and order events through its plugin system.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — choose the stock service per
   product, configure order events, and set the permissions.

## Where it lives in the admin menu

The stock settings form is at **Commerce → Configuration → Stock → Stock
settings** (`/admin/commerce/config/stock/settings`). The two permissions are
managed at **People → Permissions**.

## How to use it

For real inventory tracking you'll almost always enable the **Local storage**
submodule, then on the Stock settings form set the default stock service (and the
service for your product variation types) to **Local stock**. From there you set
stock levels per product and let Commerce enforce availability. If you only need
to mark some products as never‑out‑of‑stock, the base module's Always‑in‑stock
service covers that without any submodules. See
[Configuration](configuration/index.md) for the walkthrough.
