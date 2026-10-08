# Mapsemble Store Locator: Demo content — manual setup guide

**Mapsemble Store Locator: Demo content** (`mapsemble_store_locator_demo_content`)
seeds a set of sample store locations so you can see the
[Mapsemble Store Locator](../../mapsemble_store_locator/1.0.x/human-docs/index.md)
working the moment it is installed. It uses the
[Default Content](https://www.drupal.org/project/default_content) module to import
example stores as content, giving evaluators a populated, clickable locator without
having to enter any data first.

This is a **demo module** — it exists for evaluation and getting‑started purposes
and is **not meant for production sites**. It depends on Default Content and on
Mapsemble Store Locator, and it supports Drupal 10 and 11.

> **Heads up — this module is no longer supported.** Like the Store Locator it
> accompanies, its drupal.org status is *Unsupported / Obsolete*. Use it to explore
> the locator, then uninstall it before going live.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it to import the sample stores.

This module simply imports demo content on install; it has no settings form, so
there is no Configuration page to document.

## Where it lives in the admin menu

The demo module adds no admin page of its own. Once enabled, the sample stores
appear as **Store** content under **Content** (`/admin/content`) and on the locator
at **`/mapsemble-store-locator`**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) — the sample store
   locations are imported automatically via Default Content.
2. Visit **`/mapsemble-store-locator`** to see the locator populated with the demo
   stores.
3. When you are done evaluating, **uninstall this module** (it is not for
   production) and replace the sample stores with your own.
