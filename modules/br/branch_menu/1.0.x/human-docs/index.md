# Branch Menu — manual setup guide

**Branch Menu** (`branch_menu`) renders a Drupal menu as a visual branching tree
diagram. Instead of showing a menu as the usual nested list of links, it draws
the menu's hierarchy as an interactive tree — branches fanning out from parents
to children. That makes it a handy way to present a sitemap, give visitors a
navigation overview, or simply visualize a large or deeply nested menu structure
at a glance.

It is purely a display feature. Branch Menu adds no content of its own and has no
access-control role — it takes an existing menu and shows it differently. It
requires Drupal 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — installing with Composer and enabling
   the module.

## Where it lives in the admin menu

Branch Menu is a rendering/visualization feature that works with your existing
menus (managed under **Structure → Menus**). It provides its own permission to
control who can use its visualization, and it draws whichever menu you point it
at as a tree.

## How to use it

Enable the module, then use it to render one of your site's menus — a main menu,
a footer menu, or any custom menu — as a branching tree graph rather than a
nested list. This is most useful where the shape of the navigation matters to the
reader: a sitemap page, a "where am I" overview, or a working view of a large
menu you are maintaining. Because it only changes how an existing menu is
displayed, nothing about your menu's content or permissions changes.
