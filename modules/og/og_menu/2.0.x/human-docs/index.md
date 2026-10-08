# OG Menu — manual setup guide

**OG Menu** (`og_menu`) gives each [Organic Group](https://www.drupal.org/project/og)
its own menu — one that the group's own administrators can edit, without needing
the site‑wide *Administer menus* permission.

Organic Groups turns a single Drupal site into many small ones — a department, a
project, a club — each with its own members, roles, and content. The gap it leaves
is navigation: in core, menus are global configuration, so a group can't arrange
its own section unless someone with `administer menu` (a powerful site‑wide
permission you can't safely hand to a group lead) does it for them. OG Menu closes
that gap by making a menu **instance** a content entity attached to a group. Access
is decided by Organic Groups' own group‑role system, so a group administrator can
manage *their* menu and only theirs.

It lets you create one or more menus per group, add and edit menu links directly
from the node form, and place menu blocks — an **OG Menu: single** block (the first
available menu for the current group) and an **OG Menu: multiple** block (all
available menus for the current group). It depends on core's **Menu UI**
(`menu_ui`) and the **Organic Groups** (`og`) module.

> **Version note:** this is the **2.0.0‑alpha4** release. Treat it as pre‑release,
> and check the state of the Organic Groups release you're building against before
> planning production work around it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Organic Groups and Menu UI.

Access is managed through permissions and Organic Groups' group roles rather than a
single settings form; usage is described in "How to use it" below.

## How to use it

1. Make sure Organic Groups is already set up with at least one group type. OG Menu
   builds on top of it.
2. Enable `og_menu` (see [Installation](installation/index.md)).
3. Create one or more menus for a group — administer them from within the group, or
   from the global admin page. Group administrators can manage their own group's
   menus once they hold the relevant group role.
4. Add and edit menu links directly from the group content (node) form.
5. Place an **OG Menu: single** or **OG Menu: multiple** block at **Structure →
   Block layout** to display the current group's menu(s).

> **Permissions:** `administer og menu` is a restricted, site‑wide permission. Day
> to day, who can edit which group's menu is controlled by Organic Groups' group
> roles, plus per‑instance add/edit/delete/view permissions and a permission for
> adding links.

> **Caching caveat:** a per‑group menu is a per‑group cache context. Confirm that
> your menu blocks vary by group, otherwise one group could be served another
> group's navigation from cache.
