# Node Menu Placer — manual setup guide

**Node Menu Placer** (`node_menu_placer`) makes it faster to position a node
within a large menu, straight from the node edit form. Core Drupal's "Menu
settings" section offers a **Parent link** dropdown that loads the *entire* menu
tree — on a site with a big, deeply nested menu that dropdown is slow to render
and awkward to scan. This module replaces that dropdown with **"Move to"
placement buttons**, so an editor can drop the node into the right spot in the
menu structure quickly, without waiting for the whole tree to load.

It is a content‑editing / navigation convenience: it changes only *how* you place
a node in a menu, not *who* may do so — it respects Drupal's existing menu
permissions and adds no access‑control role of its own. It is most worthwhile on
sites where the default parent selector has become unwieldy because the menu is
large or many levels deep.

Node Menu Placer builds on the **Menu Link Weight** module, which it requires and
which supplies the finer‑grained placement mechanics. Make sure your content types
have menus enabled in their menu settings so the "Move to" buttons have somewhere
to place nodes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Menu Link
   Weight dependency) with Composer and enable it.

## How to use it

1. Confirm the content type you edit has one or more **available menus** configured
   in its **Menu settings** (**Structure → Content types → *(your type)* → Edit →
   Menu settings**). Node Menu Placer only helps where menu placement is allowed.
2. Edit (or add) a node of that type. In the node form's menu settings section, the
   usual "Parent link" dropdown is replaced by **Move to** buttons.
3. Use the buttons to place the node at the desired position in the menu structure.
   Save the node as normal.
