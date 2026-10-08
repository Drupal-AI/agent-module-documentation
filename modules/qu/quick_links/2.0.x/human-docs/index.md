# Quick Links Kit — manual setup guide

**Quick Links Kit** (`quick_links`) is a configuration‑only kit that gives you a
ready‑made system for managing a block of **quick links** — curated links with SVG
icons, meant for the home page (or anywhere you like). Rather than cluttering your
content listings, the links are saved as **Storage entities**, and you can add and
reorder them (drag‑and‑drop) right from the home page inside Drupal's settings tray.

The 2.x branch renders the links through a **Responsive Grid** view display (new in
Drupal 10), so you get all of that display's formatting options to tune how the grid
looks. On its own, Quick Links Kit provides the links system and the block; **you
place the block** into your layout (ideally in a content‑prefix region) and set it to
show on the home page. If you'd rather not do that by hand, the companion
**Quick Links Format – Olivero** (`quick_links_format_olivero`) module adds Olivero
styling and automatically places the block at the top of the home page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with its
   dependencies) and enable the module.

There is **no central settings form** for this module — you manage the links
directly from the block (in the settings tray or on the home page) and tune their
formatting through the view's Responsive Grid display.

## How to use it

1. Enable the module (its dependencies are pulled in by Composer; see
   [Installation](installation/index.md)).
2. **Place the block:** at **Structure → Block layout**
   (`/admin/structure/block`), place the Quick Links block into your layout — ideally
   in the content‑prefix region or equivalent — and configure it to display only on
   the home page. (If you install **Quick Links Format – Olivero**, this placement is
   done for you on the Olivero theme.)
3. **Add and order links:** open the home page and use the settings tray to add
   links, each with a label, URL and SVG icon, and drag them into the order you want.
   Links are stored as Storage entities, so they stay out of your regular content
   lists.
4. **Adjust the formatting:** the links render through a Responsive Grid view
   display, so you can edit that view to change columns, spacing, and responsive
   behaviour to suit your design.

> **Tip:** If you are on Olivero (or want a styled starting point), also install
> **Quick Links Format – Olivero** for ready‑made formatting and automatic block
> placement. On a custom theme you can use that module as a reference for equivalent
> CSS.
