# Menu Bulk Add Items — manual setup guide

**Menu Bulk Add Items** (`menu_bulk_add_items`) lets you add several menu links to
a menu in one operation, instead of creating them one at a time. If you have ever
built out a large menu link by link — filling in the title and URL, saving,
returning to the overview, adding the next one — this module collapses that into a
single bulk-add form.

The problem it solves is purely one of speed and tedium when populating menus. It
is an administration/navigation convenience: it does not add any access control of
its own and it respects the existing menu-administration permissions — it simply
speeds up an action a menu administrator could already perform.

The module has no site-wide settings page; you use it directly from the menu
management screens, as described under "How to use it" below. It works on Drupal
9, 10, and 11, and has no dependencies beyond core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — Menu Bulk Add Items has no settings form.
You use its bulk-add form directly from the menu management area.

## Where it lives in the admin menu

It works from the standard menu system at **Structure → Menus**
(`/admin/structure/menu`) — the bulk-add option appears when you manage a menu.

## How to use it

1. Go to **Structure → Menus** and choose the menu you want to fill.
2. Use the module's **bulk-add** form to enter several menu links at once, rather
   than adding each link individually.
3. Save. The items are added to the menu in one operation.

Because it respects the standard menu permissions, only users who can already
administer menus will see and use the bulk-add form.
