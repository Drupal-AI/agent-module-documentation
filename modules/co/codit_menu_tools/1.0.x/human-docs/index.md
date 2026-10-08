# Codit: Menu Tools — manual setup guide

**Codit: Menu Tools** (`codit_menu_tools`) is a **developer utility**: it gives
you a tested set of PHP helper methods for creating, moving, renaming, and
querying **menu links in code**. It offers nothing by itself and has no end-user
UI — the point is to save developers from writing their own menu-manipulation
code by hand every time a deployment needs to add or rearrange menu items.

The problem it solves is a familiar one. Placing a menu item precisely (under a
particular parent, next to a particular sibling) or reorganising a menu during a
deployment means fiddly, error-prone code against Drupal's menu link APIs. Codit:
Menu Tools wraps that work in a `MenuManipulator` class with clear methods you
call from `hook_update_N()`, post-update hooks, Drush deploy hooks, or scripts.

Available actions include: add a menu item in a specific location relative to a
parent and sibling (`addMenuItem()`), change an item's title
(`changeMenuItemTitle()`), change its parent (`changeMenuItemParent()`), move it
next to a different sibling (`moveMenuItem()`), rename/reparent/re-sibling in one
call (`changeMenuItem()`), create space in the weights of all items so a new one
fits cleanly between two others (`menuSeparate()`), re-arrange items to match a
pattern (`matchPattern()`), find items by name and parent
(`loadMenuItemByNameAndParentName()`), and list all menus
(`getAllMenuNames()`).

It depends only on core's **Menu Link Content** (`menu_link_content`) module and
supports Drupal 10 and 11. There is nothing to configure — you install it and use
its class from your own code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** and no UI — this is a developer toolkit used
from code, as shown in "How to use it" below.

## How to use it

After enabling the module, use the `MenuManipulator` class from an update hook,
deploy hook, or script. For example, to add a node to a menu in a precise spot:

```php
use Drupal\codit_menu_tools\MenuManipulator;

$node->save();

$menuManipulator = new MenuManipulator('MENU_MACHINE_NAME');
$menuManipulator->addMenuItem(
  'Some title',                       // menu item title
  "entity:node/{$node->id()}",        // destination
  'I am the description',             // description
  TRUE,                               // enabled
  'News and Events',                  // parent title
  'Stories',                          // adjacent sibling
  TRUE,                               // place below the sibling
);
```

Other common calls follow the same pattern — for example
`$menuManipulator->changeMenuItemTitle($title, $new_title, $parent_title);` to
rename an item, or `$menuManipulator->menuSeparate();` to spread out item weights
before inserting new items. See the project's README and examples for the full
method list and signatures.
