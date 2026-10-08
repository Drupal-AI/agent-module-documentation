# Workbench Menu Access — manual setup guide

**Workbench Menu Access** (`workbench_menu_access`) extends
[Workbench Access](https://www.drupal.org/project/workbench_access) from content to **menus**,
so you can delegate individual menus to editorial teams. A "Marketing" section can be given
control of the Marketing menu while other teams can't touch it — all without granting anyone
site‑wide menu administration.

You pick one Workbench Access **access scheme** as the active scheme on a small global settings
form, then on each menu's *Workbench menu access* tab you assign the editorial **section(s)**
allowed to edit that menu and its links. Enforcement is real, not cosmetic: the module replaces
the access handlers for menus and menu links, so editing or deleting a menu (or a link in it) is
denied unless the editor belongs to one of the menu's assigned sections. It also trims the
menu‑parent dropdowns on menu‑link and node forms so editors only see menus they may write to.

Two behaviors are worth understanding up front. First, this module only **adds** restrictions on
top of Drupal core — it can never grant access beyond core's `administer menu`, so your editors
still need that core permission. Second, a menu with **no sections assigned is left
unrestricted** (only core's `administer menu` applies) — so you must assign sections to every
menu you actually want to lock down. Users with `administer workbench menu access` or `bypass
workbench access` skip the section checks entirely.

This guide is written for a **human** clicking through the admin UI. If you want the exact config
objects, the enforcement resolution and permission details for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module (with Workbench Access) and enable
   it.
2. [Configuration](configuration/index.md) — pick the active access scheme, assign sections per
   menu, and understand the permissions.

## Where it lives in the admin menu

- **Active scheme (site‑wide):** **Configuration → Workflow → Workbench Access → Menu settings**
  (`/admin/config/workflow/workbench_access/menu_settings`).
- **Per‑menu sections:** each menu's **Workbench menu access** tab, e.g.
  `/admin/structure/menu/manage/{menu}/access` (also reachable from the *Access settings*
  operation on the menu list at *Structure → Menus*).
