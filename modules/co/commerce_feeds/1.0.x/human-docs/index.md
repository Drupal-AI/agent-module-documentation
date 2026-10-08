# Commerce Feeds — manual setup guide

**Commerce Feeds** (`commerce_feeds`) is a small bridge that wires Drupal Commerce
into the Feeds module, so you can bulk-import Commerce products — and their prices,
weights, and dimensions — from CSV, XML, JSON, or RSS sources. If you have a supplier
spreadsheet or a remote product feed, this is what lets you turn it into real
`commerce_product` entities without writing custom migration code.

It has **no configuration screen of its own**. Instead it contributes plugins that
show up inside Feeds' normal feed-type builder. The key piece is a Feeds **processor**
called **Product** (`entity:commerce_product`), which creates and updates Commerce
products the same way core Feeds creates nodes. Alongside it are three **field target**
mappers for Commerce's specialised field types: a **Commerce price** target (with a
per-target **Currency** selector), a **physical measurement** target for things like
product weight (with a **Unit** selector), and a **physical dimensions** target for
length/width/height (with a shared unit).

You drive it entirely through Feeds' own UI at **Structure → Feeds**: create a feed
type, choose the Product processor, map your source columns to product fields and to
these Commerce targets, then upload files or fetch a remote URL — one-off or on a cron
schedule. Re-running an import can update existing products in place rather than
duplicating them.

This guide is written for a **human**. For a terse, token-cheap reference aimed at an
AI coding agent — including the processor/target ids and the feed-type config shape —
read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Feeds and Commerce.

There is no separate configuration page for this module: you configure it by building
a Feeds feed type, as described below.

## How to use it

Commerce Feeds has no admin page of its own — all the work happens in the Feeds UI:

1. Go to **Structure → Feeds** (`/admin/structure/feeds`) and click **Add feed
   type**.
2. Choose a **Fetcher** (for example **Upload** for files or **Download** for a
   remote URL) and a **Parser** (**CSV**, **XML**, **JSON**, or **RSS**).
3. Set the **Processor** to **Product** (`entity:commerce_product`). In its settings
   pick the product **type/bundle** to create and choose how existing and missing
   items are handled (skip, replace, or update).
4. On the **Mapping** step, map each source column to a product field. For a price
   field, choose the **Commerce price** target and set its **Currency**; for weight or
   dimensions, choose the physical-measurement or physical-dimensions target and its
   **Unit**.
5. Save the feed type. Then add a feed (**Content → Feeds → Add feed**, or
   `/feed/add`), upload your file or set the URL, and click **Import**.

Tips: map a unique column such as SKU and use the processor's "update existing"
option so re-imports refresh products instead of creating duplicates. For a working
storefront you will also want at least one Commerce store — the importer does not
create one for you.

## Where it lives in the admin menu

Commerce Feeds adds no menu items of its own. Its plugins appear inside the Feeds
administration at **Structure → Feeds** (`/admin/structure/feeds`) when you build or
edit a feed type.
