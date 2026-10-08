# Flat Menus — manual setup guide

**Flat Menus** (`flat_menus`) stops menu items from being nested, so a chosen menu
stays **flat** — a single level of links, with no parent/child hierarchy. It's
useful when a theme, a design, or an integration expects a flat menu and you want
to stop editors from accidentally creating sub‑menus.

Rather than applying globally, it works **per menu**: it adds a **Flat menu**
checkbox to each menu's edit form (available to users who hold its permission).
When a menu is marked flat, the module:

- hides the parent‑selection fields in the menu link forms, so editors can't pick
  a parent;
- automatically moves any nested items back to the top level when a link is saved;
- disables drag‑and‑drop indentation on the menu administration screen; and
- shows clear feedback about the flat‑menu restriction.

It's essentially a port of the *flat_taxonomy* module, applied to menus. It has no
content or access role beyond its own permission — it just constrains how menus can
be structured.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.
2. [Configuration](configuration/index.md) — grant the permission and mark
   individual menus as flat.

## Where it lives in the admin menu

There's no central settings page. You mark a menu as flat from that menu's own
edit form under **Structure → Menus** (`/admin/structure/menu`), and you control
who can do so with the **Enable flat menu option** permission at
**People → Permissions** (`/admin/people/permissions`).
