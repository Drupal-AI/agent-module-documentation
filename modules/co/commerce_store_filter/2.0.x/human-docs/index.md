# Commerce Store Filter — manual setup guide

**Commerce Store Filter** (`commerce_store_filter`) adds store-based filtering for Drupal
Commerce sites that run **multiple stores**. It provides a Drupal **block** that lets an
end-user switch the current store, and a **Views contextual filter** that lets you scope
listings — such as the Cart and Order summary views — to a specific store. After switching,
the products tied to a specific store are the ones shown or accessible.

It solves an awkward part of multi-store setups: on their own, Commerce listings do not
give users an easy way to pick which store they are looking at. This module makes that
switch a placeable block and makes "filter by store" available as a reusable condition in
Views.

The module depends on **Commerce** and **Commerce Store**, and uses core **Views**. It
provides its own permissions. Importantly, it is a management/storefront convenience — it
scopes listings by store but does **not** change store access itself; access to stores is
still governed by the standard Commerce permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module and
   its dependencies.

The module has a small settings page with a single field — the message shown to a user when
they switch store — but most of the work is done by placing its block and adding its
contextual filter to your views, described below.

## Where it lives in the admin menu

The store-switch **block** appears in **Structure → Block layout**
(`/admin/structure/block`) once the module is enabled — place it in a region like any other
block. The **store contextual filter** becomes available when you edit a View at
**Structure → Views** (`/admin/structure/views`). The **settings page** lives at
**Configuration → System → Commerce Store Filter Settings**
(`/admin/commerce/commerce_store_filter/config`) and needs the *Administer commerce_store_filter
configuration* permission.

## How to use it

1. **Place the store-switch block.** Go to **Structure → Block layout**, find the Commerce
   Store Switch block, and place it in the region where you want users to change store.
2. **Add the contextual filter to a view.** Edit a View (for example the Cart or Order
   summary view) at **Structure → Views**, and add the store contextual filter so the
   listing is scoped to the selected/current store.
3. **(Optional) Set the switch message and permissions.** The module's one permission,
   *Administer commerce_store_filter configuration* (**People → Permissions**,
   `/admin/people/permissions`), controls who can open the settings page and edit the
   "store switched" confirmation message. Switching store itself is available to any visitor
   who can see the block or follow a `?commerce_store_filter=<id>` link — it changes which
   store's catalog/prices are shown, not which stores a user is allowed to access.
