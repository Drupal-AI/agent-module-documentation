# The Better Mega Menu — manual setup guide

**The Better Mega Menu** (`tb_megamenu`), also known as TB Mega Menu, turns any
Drupal core menu into a rich, multi-column mega menu with a drag-and-drop back-end
builder. Instead of a plain list of dropdown links, you get flyout panels laid out
on a Bootstrap-style 12-column grid, where each column can hold menu links *and*
Drupal blocks — views, custom HTML, images, promotional panels, and more — plus
icons, captions, animations, and built-in color styles.

Importantly, it builds *on top of* your existing menus rather than replacing them.
You pick an existing core menu (say, Main navigation) and a theme, and the module
stores the mega-menu layout for that pairing. Because it reads the live core menu
tree, any links you add or edit in Drupal's normal menu UI stay in sync
automatically. You can even maintain different mega-menu layouts for the same menu
across different themes.

Each configured menu-plus-theme combination becomes a block you place in a region
like any other block. From the visual builder you arrange items into rows and
columns, drop blocks into columns, and set options at every level — per menu item
(custom CSS class, Font Awesome icon, caption, alignment, hide-when-collapsed), per
column (grid width, show/hide block titles), and per block (animation effect,
duration, color style, off-canvas mobile mode, forced column count, and more).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the config entity
model and theming hooks — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create a mega menu, build its layout,
   place its block, and tune the per-item, per-column, and block-level options.

## Where it lives in the admin menu

Mega menus are managed at **Structure → TB Mega Menu**
(`/admin/structure/tb-megamenu`), gated by the single **Administer tb_megamenu**
(`administer tb_megamenu`) permission. Once you create a mega menu, its block
appears on the **Block layout** page (`/admin/structure/block`) under the "TB Mega
Menu" category.

## How to use it

1. Go to **Structure → TB Mega Menu** and click **Add a Mega Menu**, then pick an
   existing menu and a theme.
2. On the builder, drag menu items into rows and columns, drop in any blocks, and
   set options in the toolboxes. Save.
3. Go to **Block layout** and place the resulting block into a region (typically the
   header).

See [Configuration](configuration/index.md) for the full walkthrough and every
option.
