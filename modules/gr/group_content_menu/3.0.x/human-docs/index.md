# Group Content Menu — manual setup guide

**Group Content Menu** (`group_content_menu`) gives each **Group** (from the Group
module) its own menu, or menus. If you run teams, departments, or microsites as
Groups on a single Drupal install, this module lets every group have and manage its
own independent navigation — a main menu, a footer menu, whatever you define — with
links scoped to that group.

Its key design choice is that group menus are stored as **content** entities, not
config. Core menus (and the older Group Menu module) create each menu as a config
entity, which means N groups produce N config entities and a lot of config-ignore
juggling as groups multiply. By modelling menus as content, Group Content Menu lets
menus scale with the number of groups without any config bloat, and group editors
can manage their own menus without touching site configuration.

Setup follows the Group module's familiar pattern: you first define reusable menu
**types** (analogous to menu bundles), then enable the *Group content menu*
relation on the group types that should have menus, and finally each group exposes
its menus under **/group/{group}/menus** for editors to manage. A **Group Menu**
block renders a group's menu in a region, with settings for starting level, depth,
expand-all and relative visibility, and menu types can optionally auto-create a menu
(and a Home link) whenever a new group is created. Access is governed by one global
permission plus three per-group permissions, so you can let group editors run their
own menus while reserving type definition for site admins. The module depends on
**Group** and core's Block, Menu Link Content and Menu UI modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — defining menu types, enabling the
   relation on a group type, managing a group's menu, placing the block, and the
   permissions.

## Where it lives in the admin menu

- **Structure → Group content menu types**
  (`/admin/structure/group_content_menu_types`) — where site admins define the
  reusable menu *types*. This is the module's main configuration page.
- **Group type content configuration**
  (`/admin/group/types/manage/{group_type}/content`) — where you install the
  *Group content menu* relation on a group type.
- **/group/{group}/menus** — where each group's editors manage that group's actual
  menus and links.

The type-definition page is gated by the **Administer group content menu types**
permission; per-group management is gated by group permissions. See
[Configuration](configuration/index.md) for the full walkthrough.
