# Menu Child Item — manual setup guide

**Menu Child Item** (`menu_child_item`) streamlines building menu hierarchies. On
the menu overview screen it adds an **"add child"** link beside each existing menu
item, so you can create a child link under a specific parent in one click — and it
drops you straight into editing that new child to set its title and link before
you save.

The problem it solves is friction. On a site with a large or frequently-edited
menu, adding a nested item the normal way means creating a link and then hunting
through the parent-link dropdown to place it correctly. Menu Child Item removes
that step: the child is created under the right parent from the start.

It is an **editorial convenience** — it adds no access control of its own and
respects the existing menu-administration permissions (it just speeds up an action
editors could already perform). Its only dependency is core's **Menu UI**
(`menu_ui`) module. There is no settings page; the feature simply appears on the
menu overview once the module is enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — Menu Child Item has no settings form. The
"add child" link appears automatically on the menu overview once the module is
enabled.

## Where it lives in the admin menu

It works from the standard menu overview at **Structure → Menus → Edit menu**
(`/admin/structure/menu/manage/{menu}`, where `{menu}` is the menu's machine
name).

## How to use it

1. Go to **Structure → Menus** and click **Edit menu** on the menu you are
   building.
2. On the overview, find the parent item you want to nest under and click its
   **add child** link.
3. You are taken into the new child link's edit form — set its **title** and
   **link**, then **Save**.

The new item is placed under the chosen parent automatically, so you skip the
manual parent-selection step.
