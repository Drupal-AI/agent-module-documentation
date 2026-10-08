# Menu Level Permission — manual setup guide

**Menu Level Permission** (`menu_level_permission`) lets you lock down the *top
levels* of chosen menus so that only trusted users can edit, move, or delete the
menu links there — while everyone else with menu-editing rights can still manage
the deeper child links. Drupal core treats menu administration as all‑or‑nothing:
if a user can edit a menu, they can edit every item in it, top‑level navigation
included. This module adds the missing middle ground.

The problem it solves shows up on large sites. You want junior editors to be able
to slot new pages into the navigation without giving them the power to rearrange
or delete the primary menu items that hold the whole site structure together. With
this module you pick which menus are protected and how many levels down the
protection reaches (just the top level, the top two levels, and so on). Links at
or above that depth can then only be changed by users who hold an extra
permission, **Administer restricted menu levels** — in addition to the core
*Administer menus* permission (or a per‑menu permission from Menu Admin per Menu).

The enforcement is real, not cosmetic. As well as disabling the menu widgets on
the node and menu‑edit forms and showing a read‑only notice, the module denies the
underlying edit, delete, and translation routes for restricted links — so a
protected item cannot be reached by typing its URL directly. It focuses on
**Menu Link Content** links (the custom links editors create); links defined in
code by modules or install profiles are not restricted in the same way. It depends
on core's Menu Link Content module and pairs well with
[Menu Admin per Menu](https://www.drupal.org/project/menu_admin_per_menu).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which menus are restricted, set
   the depth, and grant the permission.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Menu level
permissions** (`/admin/config/user-interface/menu-level-permissions`). The module
does **nothing** until you visit it and select at least one menu to restrict — see
[Configuration](configuration/index.md).
