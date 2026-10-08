# Sector Mega Menu — manual setup guide

**Sector Mega Menu** (`sector_megamenu`) turns an ordinary Drupal menu into a
**mega menu** — a wide, multi-column drop-down panel that shows a site's
hierarchical navigation at a glance. It provides two blocks, a **Mega Menu Root**
(the top-level bar) and a **Mega Menu Body** (the drop-down panel), which together
render a menu you choose. It is built on top of the **Menu Block** module, so it
reuses your existing menu and Menu Block's display settings.

The problem it solves is usability on sites with a lot of hierarchical content:
instead of hunting through nested fly-outs, visitors see the structure laid out in
organized columns and can jump straight to deeper pages. The module ships Twig
templates for the root and body (`menu--sector-megamenu-root` and
`menu--sector-megamenu-body`) that you can override in your theme, and it exposes
each link's per-link menu attributes to those templates and flags the current
menu item as active for styling.

It is a pure theming / site-structure module: there are no routes, permissions, or
data storage, and no external calls. You configure it entirely by placing and
setting up the two blocks — there is no separate settings form. It depends on core
**Block** and the contrib **Menu Block** module. This is a Sector add-on that
extends the Sector Starter Kit and has a hard dependency on Sector's "Main menu
block" from the Sector distribution, so it is really intended for Sector sites. It
supports Drupal 10.1+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place a **Mega Menu Root** block where you want the top-level navigation bar,
   and point it at the menu you want to render (Menu Block provides the menu and
   depth settings).
3. Place a **Mega Menu Body** block for the drop-down panel that holds the
   multi-column child links.
4. Optionally override the provided Twig templates in your theme to control the
   markup and styling, and use the exposed per-link attributes and the active-item
   flag for custom presentation.

Because the whole thing is driven by your menu configuration, you build and
reorder the navigation in the usual **Menus** admin, and the mega menu reflects it.
