# Menu Link Weight — manual setup guide

**Menu Link Weight** (`menu_link_weight`) replaces the numeric "Weight"
drop-down on menu-link forms with a friendly **drag-and-drop** table. Instead of
guessing a weight number between −50 and 50 to position a menu item among its
siblings, editors simply drag the item up or down into place. It works both on
the dedicated menu-link forms and on the **Menu settings** section of the node
edit form, so authors can order a page's menu item while they are editing the
page.

Under the hood it hides core's weight select and shows a small tabledrag table
listing the chosen parent's existing children plus the item being edited. When
you change the parent, the sibling list refreshes (via AJAX, with a no-JavaScript
fallback button) so you always drop the item into the right group. On save it
converts your drag order back into clean menu-link weights automatically — so two
items can no longer end up fighting over the same number.

The module has a single optional setting: which **parent menu-link selector**
the form uses. Left at *default*, you keep core's parent picker and simply gain
the drag widget. Set to *cshs* — and with the separate
[Client-side hierarchical select](https://www.drupal.org/project/cshs) (`cshs`)
module installed — the parent picker becomes a nicer hierarchical select, handy
for deep menu trees. It depends on core's **Menu UI** (`menu_ui`) and **Node**
(`node`) modules and defines no permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is nothing to switch on beyond enabling the module — the drag widget
appears automatically:

- **On the node edit form:** expand **Menu settings**, tick *Provide a menu
  link*, choose the parent, then drag the row for this page into position within
  the list of siblings shown. Save the node.
- **On the menu UI:** editing or adding a link at **Structure → Menus →
  (menu) → Add/Edit link** shows the same drag table.

Disabled links appear in the list marked as disabled, and a brand-new link can
be dropped at an exact position relative to the existing items.

## The one setting — parent menu-link selector

Go to **Configuration → User interface → Menu link weight**
(`/admin/config/user-interface/menu-link-weight`); you need the **Administer
site configuration** permission. The form has a single choice:

- **default** *(default)* — keep core's parent menu-link selector. You still get
  the drag-and-drop weight widget.
- **cshs** — use the **Client-side hierarchical select** parent picker for a
  nicer experience on deep menus. This only takes effect if the separate `cshs`
  module is installed; the form will not let you pick it otherwise.

To use the `cshs` option, first install that module
(`composer require drupal/cshs` then `drush en cshs -y`), then return here and
choose **cshs**.
