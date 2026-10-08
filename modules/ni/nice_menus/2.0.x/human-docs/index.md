# Nice Menus — manual setup guide

**Nice Menus** (`nice_menus`) provides CSS/jQuery **drop-down**, **drop-right**, and
**drop-left** menus, rendered as configurable blocks. It builds expanding fly-out navigation from
any of your site's menus using the Superfish jQuery plugin (with hoverIntent for smoother
hovering) and falls back to CSS-only behaviour when JavaScript is off. It is the classic way to
turn the Main navigation into a horizontal drop-down bar, or a menu into a vertical sidebar that
flies out to the side.

You use it by placing one or more **Nice Menus** blocks via Block layout. Each block instance
picks a source menu (or a sub-tree of one), a depth (how many child levels to show), a style
(`down`, `right`, or `left`), and whether to respect each link's core "Show as expanded" flag.
A small **global settings form** controls behaviour shared across all the blocks: whether the
Superfish JavaScript loads, whether the module's default CSS loads, and the hover close delay and
animation speed.

Menu access-checking stays intact — the tree is built through core's menu link tree service, so
unpublished or permission-restricted links are filtered out just as they are elsewhere. Blocks
get consistent CSS classes (`nice-menu`, `nice-menu-<menu>`, `nice-menu-<style>`) so you can
theme them, and you can disable the default CSS to style them entirely from your theme. The
module depends on core's **Menu Link Content** module, ships the Superfish/hoverIntent libraries
itself (no CDN), and works from Drupal 8.8 through 11. It provides one permission, *manage nice
menu settings*, for the global settings form.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — the config keys, block settings, and libraries —
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and grant the
   settings permission.
2. [Configuration](configuration/index.md) — the global settings form and the per-block options
   (menu, depth, style, expand).

## Where it lives in the admin menu

- **Global settings:** **Configuration → User interface → Nice Menus**
  (`/admin/config/user-interface/nice_menus`), gated by *manage nice menu settings*.
- **The menu blocks** are placed and configured at **Structure → Block layout**
  (`/admin/structure/block`) — look for the **Nice Menus** block in the *Menus* category.

## How to use it

Enable the module, then place a **Nice Menus** block in the region where you want the navigation
(for example the Main menu as a horizontal drop-down in a header region). Configure the block's
source menu, depth, and style, and — if needed — adjust the global JavaScript/CSS and hover
timing on the settings form. See [Configuration](configuration/index.md) for each option.
