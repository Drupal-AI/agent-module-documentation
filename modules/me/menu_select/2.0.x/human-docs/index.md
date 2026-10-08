# Menu Select — manual setup guide

**Menu Select** (`menu_select`) fixes a long‑standing pain point in Drupal: the "Parent
item" control on menu‑link and node menu‑settings forms is a plain drop‑down `<select>`,
which becomes unusable on sites with hundreds of menu links. Menu Select replaces that
drop‑down with an **expandable, clickable menu tree** — editors browse and expand
branches to find the right parent — plus an optional **autocomplete search box** so they
can just type a link's title and jump to it.

It works everywhere Drupal renders a parent‑item selector: the node edit form's "Menu
settings" section and the menu‑link add/edit forms under Structure → Menus. Behind the
scenes it decorates core's parent‑selector service, so the value the form submits is
exactly what core would have submitted — nothing downstream changes. It also respects the
same access rules core does, so editors only see links they're allowed to reach, and a
link is never offered as its own parent.

The tree widget is always on once the module is installed — there's nothing to switch it
on. The **only** setting is a single checkbox that turns the autocomplete search box on
or off site‑wide, and the search feature is additionally gated by a dedicated permission.
Menu Select depends only on core's **Menu UI** module and works on Drupal 10.1+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — the single search toggle and the search
   permission.

## Where it lives in the admin menu

The one setting is at **Configuration → Content authoring → Menu Select**
(`/admin/config/content/menu_select`). The improved parent‑picker itself shows up
automatically on the node edit form and on the menu‑link forms under **Structure →
Menus** (`/admin/structure/menu`) — no per‑form setup needed.

## How to use it

1. Enable the module. The tree‑based parent picker is active immediately on every menu
   and node menu form.
2. If you want the autocomplete search box too, leave the **search** setting on (it is on
   by default) and grant the *Use menu select search* permission to the roles that
   should have it.

See [Configuration](configuration/index.md) for the details.
