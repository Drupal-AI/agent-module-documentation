# Admin Menu Swap — manual setup guide

**Admin Menu Swap** (`amswap`) replaces the toolbar's **"Manage" administration
menu** with a different menu of your choosing, on a **per‑role** basis. This lets
you give each role a tailored admin navigation — editors might see a stripped‑down
menu with just Content and Media, a shop manager might see a Commerce‑focused menu,
and a client role might see a curated, clutter‑free menu — all without writing a
custom module or theme override.

You configure it by building **role‑menu pairs**: each pair maps a user role to the
menu that should appear as that role's administration tray. A pair can also list
**ignored roles** — if the current user *also* has one of those roles, the pair is
skipped. That makes it easy to, say, give Editors a simplified menu but exempt
anyone who is also an Administrator so they keep the full menu. Multiple pairs can
apply to one user (their menus are merged), and if no pair matches, the normal
administration menu is shown. The menu you point at is any menu you've built under
*Structure → Menus*, so you have full control over its links.

Admin Menu Swap plays nicely with the wider toolbar ecosystem: it respects
[Admin Toolbar](https://www.drupal.org/project/admin_toolbar)'s configured menu
depth and Gin Toolbar's active‑trail styling when those are present, and it forces
its own changes to run last so they win over other toolbar‑altering modules. It
depends on core's **Toolbar** and **User** modules, stores everything in a single
config object, and provides one settings form and one permission — no fields, no
Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — building role‑menu pairs, ignored
   roles, and how the swap behaves.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Admin Menu Swap**
(`/admin/config/amswap`), under Configuration. Reaching it requires the
**Administer amswap** permission (`administer amswap`).
