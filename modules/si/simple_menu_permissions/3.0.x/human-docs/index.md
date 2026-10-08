# Simple Menu Permissions — manual setup guide

**Simple Menu Permissions** (`simple_menu_permissions`) replaces Drupal core's
single, all‑or‑nothing "Administer menus and menu links" permission with
fine‑grained, **per‑menu** permissions. Out of the box, core only lets you grant
a role full control over *every* menu on the site. This module lets you hand a
role rights over just one specific menu — and even split viewing, editing links,
and deleting the menu itself across different roles.

For every menu that exists, the module automatically generates six permissions —
view the menu in the overview list, edit the menu, delete the menu, add new links
to it, edit its links, and delete its links — plus one global **Create new menu**
permission. New permissions appear on their own whenever a menu is created, and
disappear when a menu is deleted.

This makes least‑privilege menu delegation easy: let a "Footer editor" role touch
only the Footer menu, give a department control of its own sub‑menu, or allow
editors to reorder links without letting them rename or delete the menu. The
module also filters the parent‑menu dropdown on node and menu‑link forms so users
only see menus they may actually manage. There is **no settings UI** — you simply
assign the generated permissions on the Permissions page. (The core `administer
menu` permission still grants full control and bypasses these per‑menu checks, so
keep it reserved for true site administrators.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the generated permissions and how to
   assign them.

## Where it lives in the admin menu

There is no settings page. Everything is done on **People → Permissions**
(`/admin/people/permissions`), where the module's per‑menu permissions appear
alongside core's.

## How to use it

Enable the module, then go to **People → Permissions** and grant a role exactly
the per‑menu permissions it needs. See [Configuration](configuration/index.md) for
the full list of what each permission controls.
