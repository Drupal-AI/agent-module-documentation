<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Navigation Menu Role — manual setup guide

**Navigation Menu Role** (`navigation_menu_role`) adds menu blocks for Drupal 11's
**Navigation** (the left sidebar) whose visibility can be limited to selected user
**roles**. With it, different roles can see different menus in the navigation — you
might show the admin menu only to editors, give a reviewer role its own moderation
menu, or offer anonymous users a minimal menu while logged-in users get a richer one.

The module provides one menu block that is automatically available for every menu on
your site — main, admin, account, footer, tools, and any custom menus. Each block has
the usual level and depth controls plus an extra **Roles** setting: tick the roles that
should see it. Leave the roles empty and the block is visible to everyone; tick one or
more and only users with at least one of those roles will see it. That is all the
access logic — no permissions to wire up, no visibility conditions to configure.

These blocks are designed specifically for the Navigation sidebar. They are flagged so
they can be placed in the Navigation region, and deliberately hidden from the standard
Block layout UI to keep things tidy — you manage them through the Navigation editing
interface, not the classic Block layout page. Their configuration is saved as normal
block config (`block.block.*`), so per-role navigation setups deploy cleanly between
environments.

There is no central admin settings page — the configuration lives on each block you
place. This module is experimental and requires Drupal 11.1 with the core Navigation,
Block, and System modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — placing a role-restricted Navigation menu
   block and its settings (Roles, Level, Depth), field by field.

## Where it lives in the admin menu

The module adds no admin page of its own. You place and configure its blocks through
the **Navigation** editing interface (the left sidebar's menu management), where the
role-aware menu blocks appear under the "Menus per role (Navigation)" category.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. In the Navigation editing UI, add one of the **Navigation menu (role visibility)**
   blocks, choosing the menu you want (main, admin, and so on).
3. Set the starting **level** and **depth**, and tick the **Roles** that should see
   the block — or leave roles empty for everyone.
4. Repeat for each role/menu combination you need. See
   [Configuration](configuration/index.md) for the details of each setting.
