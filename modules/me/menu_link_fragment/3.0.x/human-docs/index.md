# Menu Link Fragment — manual setup guide

**Menu Link Fragment** (`menu_link_fragment`) adds a **Link fragment** field to the
menu‑link edit form so editors can append an anchor (a `#fragment`) to a menu
link's URL. That lets a single menu item point not just at a page, but at a specific
section *within* a page.

The problem it solves is in‑page navigation. Say you have a long "About" page with
headings that each carry an HTML anchor. With this module an editor can add a menu
link that jumps straight to, for example, `/about#our-history`, without needing to
hand‑edit the URL or understand how fragments work. When a visitor clicks such a
link, the page scrolls smoothly to the anchored section.

It's a small, focused enhancement with no settings page. The fragment field is
validated to plain anchor characters (letters, numbers, hyphens, and underscores —
no spaces or special characters), and the module attaches its smooth‑scroll behavior
only where needed. It depends on core's **Menu Link Content** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings page** for this module. You use it directly on the menu‑link
form, described in "How to use it" below.

## How to use it

1. Go to **Structure → Menus** (`/admin/structure/menu`), open a menu, and add or
   edit a link.
2. In the new **Link fragment** field, enter the anchor you want to jump to —
   *without* the `#` (for example, `our-history`). Use only letters, numbers,
   hyphens, and underscores.
3. Save. The menu link's URL now ends in `#our-history`, and clicking it scrolls
   smoothly to that anchor on the target page.

For this to work, the target page must actually contain an element with a matching
`id` (or a named anchor) — that's what the fragment points at.
