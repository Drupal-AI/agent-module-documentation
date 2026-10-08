# DSFR Menus — manual setup guide

**DSFR Menus** (`dsfr_menu`) lets you build navigation menus that render with the
correct markup and styling of the DSFR — *Système de Design de l'État*, the
French State Design System. It generates standard DSFR‑styled menus and places
them **directly in your theme's assigned regions**, so a French government site
gets compliant navigation without hand‑building the DSFR menu markup. It also
works with DSFR child themes.

It builds on **DSFR Core** and uses Drupal's core menu machinery: it depends on
the core **Block**, **Menu Link (content)**, and **Text** modules, plus
**DSFR Core** (`dsfr_core`). Because it renders menus as blocks, you set it up the
same way you place any menu — by placing the DSFR menu block into the region where
you want the navigation to appear, using the menu whose links you manage in the
usual place.

The module provides its own permission(s); review them at **People → Permissions**
after enabling. Its one dedicated screen is an **Import menus** form at
**/admin/dsfr/import/menus**, which creates a set of ready-made DSFR menus (and
optionally their blocks) for you; from there you place the menu block(s) and
manage menu links through Drupal's standard menu UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it requires DSFR Core).

Its only dedicated screen is the **Import menus** form at
**/admin/dsfr/import/menus**; the rest of the work is done through Drupal's
standard **Menus** and **Block layout** screens, described below.

## Where it lives in the admin menu

Apart from the Import menus form, DSFR Menus works through the core
tools: manage menu links at **Structure → Menus** (`/admin/structure/menu`), and
place the DSFR‑styled menu block(s) at **Structure → Block layout**
(`/admin/structure/block`). Review its permissions at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

1. Make sure the base **DSFR theme** is in use, so the DSFR menu markup is styled
   correctly.
2. Create or choose a menu and add its links at **Structure → Menus**
   (`/admin/structure/menu`).
3. Go to **Structure → Block layout** (`/admin/structure/block`) and place the
   DSFR menu block for that menu into the region where the navigation should
   appear.
4. Configure the block's visibility if needed, save, and view the site to confirm
   the menu renders with DSFR styling.
