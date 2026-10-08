# Create Menus Permission — manual setup guide

**Create Menus Permission** (`create_menus_permission`) does one thing: it splits the
ability to **create menus** out of core's coarse `administer menu` permission, so a
role can add menus without being handed control of the site's entire menu structure.

Core's `administer menu` is all-or-nothing. It covers creating and deleting menus,
editing **every link in every menu** — including the administration menu — and, since
menu links can point anywhere, rearranging the site's navigation however the holder
likes. That is genuinely an administrative permission, which makes the common
delegated case awkward: a department that needs its own menu for its own section, an
editor building navigation for a microsite, a team whose menu is theirs but whose
site's main menu is not. Today the only choice is all of it or none of it, and "all of
it" usually gets granted because the alternative is a support ticket every time.

This module adds a narrower permission so you can grant just menu **creation**. It
generates the permission through a `permission_callbacks` mechanism rather than a fixed
list, which keeps the permissions page manageable even on sites with many menus and
roles. It was originally designed to complement **Workbench Menu Access**, but it works
without it and does not depend on it. It requires core's **Menu UI** module.

Two things are worth establishing before you rely on it, because a partial permission
that leaks is worse than none:

- **What creating a menu implies.** Whoever creates a menu usually ends up
  administering it — so confirm on your site whether the new permission also lets the
  holder edit the menu they created, and where that stops.
- **Menu links are navigation, and navigation is trust.** A link is site chrome
  pointing wherever its author chose. A delegated menu that can be placed in a shared
  region is, in effect, a delegated ability to put arbitrary links in front of every
  visitor — so pair this permission with control over where those menus can be placed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   alongside core Menu UI.

There is **no configuration page** — this module only contributes a permission, which
you assign under **People → Permissions**, described below.

## How to use it — the permission model

1. Enable the module (see [Installation](installation/index.md)). This adds a
   menu-creation permission to the permissions list.
2. Go to **People → Permissions** (`/admin/people/permissions`).
3. Find the new menu-creation permission (provided by Create Menus Permission) and
   grant it to the role(s) that should be able to **create** menus — for example a
   department-editor role — **without** granting them core's broad `administer menu`.
4. Save permissions. Those roles can now create menus while remaining unable to
   administer the rest of the site's menu structure.

Confirm the exact scope on your own site (per the two cautions above), and, if you use
**Workbench Menu Access**, this pairs naturally with its per-menu access control.
