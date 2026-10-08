# Advanced Mega Menu — manual setup guide

**Advanced Mega Menu** (`advanced_mega_menu`) is a **grid-based layout builder for
mega menus**. It lets site builders turn an ordinary menu into rich, multi-column
dropdown panels — arranged on a grid and populated with **Views** and **Blocks** —
so navigation can carry featured content, images, and columns of links rather than
just a flat list.

The menu content is supplied by the Views and Blocks you place into the grid, and
those continue to respect their own access rules — the module itself has no role
in access control beyond the permission it provides for managing mega menus.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — build the mega-menu grid and fill it
   with Views and Blocks.

## Where it lives in the admin menu

The mega-menu content is configured at the module's settings route
(`advanced_mega_menu.megamenu_content.settings`), and it provides its own
permission (set on **People → Permissions**) for who may build mega menus. See
[Configuration](configuration/index.md).
