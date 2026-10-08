# Commerce Product Menu UI — manual setup guide

**Commerce Product Menu UI** (`commerce_product_menu_ui`) brings core's familiar
"Provide a menu link" section to the **Commerce product** add/edit form. Content
nodes have had this ever since Drupal grew a menu system — you write a page, tick a
box, and it lands in the navigation without a second trip to the menu
administration. Commerce products never had that convenience, so getting a product
into a menu meant copying its path and pasting it into the menu UI afterwards,
which editors routinely forget.

This module is a small, deliberate bridge between two things that both already
exist: core's `menu_ui` behaviour and the Commerce product form. Enable it and a
featured product, a category landing product, or a service offering becomes
navigable from the moment it is saved — no new concepts, no configuration screen to
learn. It also adds token support for `[commerce_product:menu-link:...]`, which is
handy for Pathauto patterns that follow your menu structure.

It depends on **Commerce**, **Commerce Product**, and core's **Menu UI**, and it
works the instant you turn it on — there is nothing you *must* configure.

One thing worth deciding as an editorial matter: a product form with a menu section
quietly invites *every* product to be added to a menu, and menus that anyone can
add to grow unmanageable fast. The control for this is core's own per-bundle
setting for which menus are available on a content form — apply the same discipline
here so merchandisers only see the menus you actually want products placed in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce and core Menu UI.

There is **no configuration page** for this module. Once enabled, everything
happens on the standard product form and on core's per-bundle menu settings,
described below.

## Where it lives in the admin menu

Commerce Product Menu UI adds no admin page of its own. The menu-link section
appears directly on each product's add/edit form (under **Commerce → Products**).
Which menus a product may be placed in is controlled by core's per-bundle menu
settings, the same mechanism nodes use.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Create or edit a Commerce product. You will now see a **Menu settings** section
   on the form — tick "Provide a menu link", give it a title, and choose a parent
   item, exactly as you would for a content page.
3. Save the product. It is immediately reachable from the chosen menu.
4. To keep menus tidy, restrict which menus editors can pick from per product type,
   the same way you would for a content type.
