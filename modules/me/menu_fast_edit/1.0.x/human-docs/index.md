# Menu Fast Edit — manual setup guide

**Menu Fast Edit** (`menu_fast_edit`) exposes the **Title** and **URL** fields for
menu links directly on the menu management page, so you can rename a link or
change where it points without opening each link's separate edit form. It turns
the menu overview into a quick, inline editing surface.

The problem it solves is the click-heavy round trip of core menu editing: to fix a
title or URL you normally open the link, change it, save, and return to the
overview. Menu Fast Edit lets you edit those two most-common fields right there in
the list and save them together.

Under the hood it alters the core menu edit form to add and process the inline
fields, and it also lets the "add link" form accept a default **Parent Link** from
a query parameter, so links can be pre-parented. A `menu-fast-edit` class is added
to the overridden form for your own CSS/JavaScript to hook into. One limitation:
the fast-edit form is **not** applied to a **locked** menu (for example core's
*admin* menu), so those continue to use the standard edit form.

It is an **administration/UI convenience**: it adds no access control of its own
and respects the existing menu-administration permissions. Its only dependency is
core's **Menu UI** (`menu_ui`) module, and it sits in the Administration package.

As the project itself states, **there are no configuration settings and no
database changes** — install it and it automatically affects all (unlocked) menu
manage forms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — Menu Fast Edit has no settings form and makes
no database changes. It works automatically once enabled.

## Where it lives in the admin menu

It works from the standard menu system at **Structure → Menus**
(`/admin/structure/menu`).

## How to use it

1. Go to **Structure → Menus** (`/admin/structure/menu`) and click **Edit menu**
   on any unlocked menu.
2. Edit the **Title** and **URL** fields shown inline on the menu overview.
3. Click **Save** to store your changes.

Remember that locked menus (such as the *admin* menu) are not affected and keep
the standard per-link edit form.
