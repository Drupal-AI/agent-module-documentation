# Menu Firstchild — manual setup guide

**Menu Firstchild** (`menu_firstchild`) lets you create a parent menu link that
has no page of its own and instead points, automatically, at the URL of its first
visible child link. When someone clicks (or a theme links) that parent, they are
sent to the first item beneath it in the menu tree.

The problem it solves shows up in almost every drop‑down or mega‑menu: you want a
top‑level heading like *Products* that reveals child links on hover, but the
heading itself has nowhere sensible to go. The usual workarounds are a dead
`<nolink>` parent (clicking does nothing) or hand‑typing the parent's path and
keeping it in sync by hand. Menu Firstchild removes that chore — the parent always
resolves to its current first child, so when you reorder or retire child links the
parent's destination updates on its own. Access is respected too: the parent only
resolves to children the current user is actually allowed to view, and if none are
viewable it gracefully becomes an unlinked item.

The module works entirely per menu link — there is **no settings page, no
permissions, and no Drush commands**. Enabling it simply adds a **First child**
checkbox to the menu‑link add/edit form. It depends only on core's **Menu Link
Content** module and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Menu Firstchild adds no admin page of its own. Everything happens on the ordinary
menu‑link form under **Structure → Menus** — for example **Structure → Menus →
Main navigation → Add link** (`/admin/structure/menu`).

## How to use it

1. Add or edit a custom menu link (for instance under *Structure → Menus → Main
   navigation → Add link*).
2. Tick the **First child** checkbox — its help text reads "When enabled, this menu
   item will redirect to the first child item." The Link/path field is then
   disabled, because you no longer enter a path.
3. Save the link, and make sure it has child links beneath it in the menu tree.

From then on the parent renders as a link to its first viewable child. A few
things worth knowing:

- **Reordering updates it automatically.** Because the destination is worked out
  when the menu renders, dragging a different child to the top changes where the
  parent points — no editing required.
- **It chains.** If the first child is *itself* a First‑child link, the module
  keeps following the chain until it reaches a real page.
- **It respects access.** Only children the current user may view are considered;
  with no viewable child, the parent becomes an unlinked (routeless) item rather
  than a broken link.
- **It adds a CSS class.** First‑child parents get a `menu-firstchild` class so you
  can style them differently in a theme.
- **It works on any menu** (main, footer, or custom) and carries per translation,
  so multilingual menus keep the behaviour.

Developers can adjust the generated parent item with the
`hook_menu_firstchild_item_alter()` hook — see the [`agent/`](../agent/start.md)
docs for details.
