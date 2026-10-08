# Simple Mega Menu — manual setup guide

**Simple Mega Menu** (`simple_megamenu`) lets you turn a plain menu dropdown into
a rich, themed **mega-menu panel** — the kind of large navigation flyout with
columns of links, images, promotional banners, and text that you see on many
marketing and e-commerce sites. It does this in a very Drupal-native way: it adds
a fieldable content entity called a "Simple mega menu" that you build out of
ordinary fields, then attach to individual menu links.

Because the mega menu is a real content entity, you get all the usual Drupal
power for free. You define **bundles** (types) of mega menu — say "Products" and
"Resources" — each with its own fields and displays, exactly like content types.
The entities are **revisionable** (full history and rollback) and **translatable**
(per-language content on multilingual sites), can be published or unpublished
independently of the menu link, and can be reused across several links. Editors
pick which mega-menu entity a link uses from a simple autocomplete on the menu link
form.

Each bundle declares which **menus** it applies to, so the mega-menu autocomplete
only shows up on links in the menus you have targeted (your Main navigation, a
footer menu, and so on). Rendering is driven from Twig with two helper functions —
`has_megamenu()` and `view_megamenu()` — and the module ships two view modes
(**before** and **after**) plus a default template that themers override to control
the panel's markup. A bundled example submodule gives you a ready-made "megamenu"
bundle to copy from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the entity types, the
attachment attribute, the Twig functions, and theming hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional example submodule.
2. [Configuration](configuration/index.md) — create a mega-menu type, target it at
   a menu, add fields, and attach an entity to a menu link — plus the permissions.

## Where it lives in the admin menu

Simple Mega Menu has **no global settings page**. Its pieces live in a few places:
mega-menu **types** at **Structure → Simple mega menu type**
(`/admin/structure/simple_mega_menu_type`), the mega-menu **entities** at
**Content → Simple mega menu** (`/admin/content/simple_mega_menu`), and the
**attachment** control on each menu link's edit form under **Structure → Menus**.

## How to use it

The workflow is: create a mega-menu **type** and choose which menus it targets, add
**fields** to that type and arrange its display, create one or more mega-menu
**entities**, then edit a menu link in a targeted menu and pick the entity from the
**Simple Mega Menu** autocomplete. Finally, your theme renders the panel using the
module's template and Twig functions. Each step is covered in
[Configuration](configuration/index.md).
