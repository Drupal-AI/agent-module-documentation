# Content Hub Tree — manual setup guide

**Content Hub Tree** (`content_hub_tree`) gives you an alternative **content administration**
screen. Instead of the flat list at **Admin → Content**, it shows your nodes as a hierarchical
**tree** built from a menu: every menu link that points at a piece of content becomes a row —
with its title, content type, status, author and updated date — nested in the same parent‑child
shape as the menu that links it.

You choose which menus get this treatment with an **"Include in Content tree"** checkbox on the
menu's edit form. Each opted‑in menu then gains a **"Content tree"** tab under **Admin →
Content**. The screen lives at `/admin/content/content-tree/{menu}` and is available to users
with the **"administer menu"** permission. From it you can switch between opted‑in menus, use
each row's operations to edit or delete the referenced node, and run **bulk node operations**
(the same node actions offered on the core content list) against the rows you select. Menu links
that don't resolve to a node still appear, shown as plain menu links.

It depends on core's **Menu Link Content** module, which is where the menu links it reads come
from.

This is a lightweight module with no dedicated settings form; the one thing you "configure" is
which menu (or menus) the tree is based on, by building and maintaining that menu in the usual
Drupal menu UI and ticking the "Include in Content tree" checkbox. Note this release is an early
beta (1.0.0‑beta2).

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

This module has **no dedicated configuration form**. What shapes the tree is the menu it's based
on, which you manage through Drupal's normal menu tools, as described in "How to use it" below.

## How to use it

1. Enable the module and its Menu Link Content dependency (see
   [Installation](installation/index.md)). On enable, the site's **main** menu is opted into the
   content tree automatically.
2. Open **Structure → Menus** (`/admin/structure/menu`) and edit the menu whose structure should
   drive the tree. Tick **"Include in Content tree"** and save. Build the menu's parent‑child
   arrangement of links as you want the tree to look.
3. Go to **Admin → Content** and open the **"Content tree"** tab. Rows whose menu links point at
   nodes show the node's fields and operations; use the **Action** select plus **"Apply to
   selected items"** to run bulk node operations on the rows you check.
4. To change the hierarchy, adjust the menu — reorder, nest, or add links — and the tree reflects
   those changes. Use the **"Select menu"** dropdown on the screen to switch between opted‑in
   menus.
