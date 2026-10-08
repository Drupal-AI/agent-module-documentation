# Advanced Menu Condition — manual setup guide

**Advanced Menu Condition** (`advanced_menu_condition`) adds a new *visibility
condition* to Drupal — a rule you can attach to a block (or anything else that
uses Drupal's condition system, such as Layout Builder) to control **where** it
appears. Instead of matching on the URL path, this condition matches on the
**active menu trail**: which menu links are "active" for the page a visitor is
looking at.

The advantage over a plain path check is that it understands menu *structure*.
You can select several menu items at once, and turn on inheritance so the
condition also matches every child link beneath a chosen parent. That means you
can show a sidebar, banner, or block across an entire section of your site — a
parent page and all its descendants — without having to list every individual
path by hand.

It is purely a display/visibility helper. It governs where things appear; it does
not control access to content or restrict what anyone can reach. The module also
ships some Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Advanced Menu Condition adds no admin pages or menu items of its own. It surfaces
as an extra option wherever Drupal lets you set visibility conditions — most
commonly in the **block configuration** form (when you place or edit a block under
**Structure → Block layout**) and in **Layout Builder** blocks.

## How to use it

1. Place or edit a block (**Structure → Block layout**, then *Place block* or
   *Configure* on an existing block).
2. In the block's configuration form, find the **Visibility** settings. Advanced
   Menu Condition appears there as a menu-trail condition alongside the built-in
   conditions (pages, content types, roles, and so on).
3. Select one or more **menu items** that should make the block appear. Turn on
   **inheritance** if you want the block to show not just on the selected item's
   page but across all of its child links too — the whole menu branch.
4. Save the block.

The block now appears on every page whose active menu trail matches your
selection. For example, selecting a top-level "Products" menu item with
inheritance enabled shows the block on the Products landing page and every product
page filed beneath it — no path lists to maintain.
