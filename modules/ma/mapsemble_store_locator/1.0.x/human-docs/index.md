# Mapsemble Store Locator — manual setup guide

**Mapsemble Store Locator** (`mapsemble_store_locator`) gives you a working
store‑locator out of the box. It ships a ready‑made [Mapsemble](../../mapsemble/2.0.x/human-docs/index.md)
configuration for store locations — a searchable map paired with a list of
stores, plus a **Store** content type to hold each location — so a multi‑location
site gets a functioning locator without building the map from scratch.

It builds on two other modules: [Mapsemble](../../mapsemble/2.0.x/human-docs/index.md)
(the map engine) and [Geofield Map](https://www.drupal.org/project/geofield_map)
(for entering and displaying coordinates). It supports Drupal 10 and 11.

> **Heads up — this module is no longer supported.** Its maintenance status on
> drupal.org is *Unsupported / Obsolete*. It still installs on Drupal 10 and 11,
> but it will not receive further updates, so weigh that before relying on it for a
> production store locator. Consider building your own map directly with the
> actively maintained [Mapsemble](../../mapsemble/2.0.x/human-docs/index.md) module
> instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its Mapsemble and Geofield Map dependencies.

This module is a pre‑built configuration rather than a settings form, so there is
no Configuration page to document. The setup is guided from the locator page
itself, described under "How to use it" below.

## Where it lives in the admin menu

Mapsemble Store Locator does not add its own settings form under **Configuration**.
After you enable it, visit **`/mapsemble-store-locator`** and follow the on‑screen
instructions to finish wiring up the locator. Store locations are managed as
content of the new **Store** content type under **Content**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) — this brings in
   the Store content type and the pre‑built map configuration.
2. Go to **`/mapsemble-store-locator`** and follow the on‑screen setup steps.
3. Add your stores as **Store** content, giving each one its location so it appears
   on the searchable map and in the list.

> **Tip:** Want sample stores to see the locator working straight away? The
> companion **Mapsemble Store Locator: Demo content** module seeds a set of example
> store locations for evaluation.
