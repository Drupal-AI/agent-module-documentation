# Menu Force — manual setup guide

**Menu Force** (`menu_force`) makes the core **Menu settings** on the node form
*mandatory* for the content types you choose. Normally, adding a node to a menu
is optional — an editor can leave the "Provide a menu link" box unchecked and
save a page that never appears in any navigation. Menu Force removes that
loophole: for a content type you've flagged, a node cannot be saved until it has
been placed in a menu.

It works entirely by adjusting forms — it defines no new field, entity, or
settings page. On the content-type edit form it adds two checkboxes under the
**Menu settings** tab. When you turn the requirement on, the node add/edit form
for that type opens the menu section automatically, ticks and locks the "Provide a
menu link" checkbox, and makes the menu link title a required field. Optionally,
you can also lock the **Default parent item**, pinning every new node of that type
under one fixed parent — handy for keeping, say, every campaign page under a
"Campaigns" menu item.

A common reason to reach for Menu Force is Pathauto: URL-alias patterns that use
menu-based tokens like `[node:menu-link:...]` / `menupath` only work if the node
actually lives in the menu tree. Making menu placement mandatory guarantees those
tokens always have something to read. It's also useful for menu-driven
breadcrumbs, sitemaps, and mega-menus that assume every relevant node is in the
menu.

The choice is stored as a third-party setting on the content type itself, so it
travels with your exported configuration and can be turned on or off per
environment. A bundled submodule, **menu_force_taxonomy_menu_ui**, extends the
same behavior to taxonomy terms (via the contrib Taxonomy Menu UI module).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose the submodule if you need it.

## Where it lives in the admin menu

Menu Force has **no settings page of its own**. You turn it on per content type,
on that type's edit form: **Structure → Content types → *(your type)* → Edit →
Menu settings tab** (`/admin/structure/types/manage/<bundle>`). The two checkboxes
it adds live in that **Menu settings** vertical tab, right alongside core's
existing menu options.

## How to use it

To make menu placement mandatory on a content type:

1. Go to **Structure → Content types**, and click **Edit** on the type you want
   (for example Article or Landing page).
2. Open the **Menu settings** vertical tab.
3. Tick **Make the Menu Settings mandatory for this content type**.
4. *(Optional)* Tick **Lock the "Default parent item" as well** — this box only
   appears once the first is checked. If you lock the parent, you must also pick a
   real **Default parent item** in the same tab, or the form will refuse to save
   with the message *"If you want to force a Default parent menu item, please
   select which one."*
5. Click **Save content type**.

From now on, anyone creating or editing a node of that type will find the menu
section open, "Provide a menu link" checked and locked, and the menu link title
required — so they cannot save without placing the node in a menu. To undo it,
return to the same tab, untick the boxes, and save.

If you want the same enforcement on taxonomy terms, enable the
**menu_force_taxonomy_menu_ui** submodule (see
[Installation](installation/index.md)).
