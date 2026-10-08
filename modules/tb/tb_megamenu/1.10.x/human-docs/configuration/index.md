# Configuration

Building a mega menu takes three steps: create it (choose a menu and theme), lay it
out in the visual builder, then place its block. All of the admin pages below
require the **Administer tb_megamenu** permission.

## 1. Create a mega menu

Go to **Structure → TB Mega Menu** (`/admin/structure/tb-megamenu`) and click
**Add a Mega Menu**. You choose two things:

- **Menu** — an existing Drupal core menu, such as Main navigation.
- **Theme** — the theme this layout applies to.

Because a layout is tied to a specific menu/theme pair, you can build one mega menu
for your front-end theme and a different one for another theme using the same
underlying menu.

## 2. Build the layout

Saving takes you to the drag-and-drop builder. Here you arrange the menu's items
into rows and columns, drop Drupal blocks into columns, and set options through
toolboxes. Changes are saved over AJAX. There are four levels of options:

### Block-level settings (the whole menu)

These control the overall behavior and look of the menu:

- **Animation** — the open/close effect: none, fading, slide, zoom, or elastic.
- **Duration** — animation length in milliseconds (default 400).
- **Delay** — animation delay in milliseconds (default 200).
- **Style** — a built-in color style: Default, black, blue, or green (no custom CSS
  needed).
- **Auto-arrow** — show an arrow indicator on items that have children (on by
  default).
- **Always show submenu** — keep submenus visible, which is friendlier for
  tap/touch navigation (on by default).
- **Off-canvas** — use an off-canvas presentation for the mobile menu.
- **Number of columns** — force a fixed column count for submenus (0 means
  automatic).

### Per-item settings (each menu link)

- **Class** — extra CSS class(es) for theme-specific styling.
- **Icon (xicon)** — a Font Awesome icon to show beside the item.
- **Caption** — a non-linking heading/caption to group links within a column.
- **Alignment** — align the submenu panel relative to its parent.
- **Group** — wrap submenu columns in a group/panel for complex layouts.
- **Hide when collapsed** — hide this item when the menu collapses to its
  mobile/off-canvas state.
- **Label** — override the displayed label.

### Per-column settings

- **Width** — the column's width on the 12-column grid.
- **Class** — extra CSS class(es) for the column.
- **Show block title** — show or hide the title of a block placed in the column.
- **Hide when collapsed** — hide the column in the collapsed/mobile state.

### Adding blocks

Drop any accessible Drupal block into a column — a view, custom HTML, a form, media,
and so on. (Blocks provided by TB Mega Menu itself are excluded from the picker.)

When you are done, **save** the layout.

## 3. Place the block

Go to **Structure → Block layout** (`/admin/structure/block`) and place the block
named after your menu, found under the **TB Mega Menu** category, into a region —
usually the header. Each configured menu/theme pair is its own block, so you can
place the header menu, a footer menu, and so on independently.

## Keeping in sync and exporting

Because the module reads the live core menu tree, links you add or edit through
Drupal's normal menu UI show up in the mega menu automatically. The finished layout
is stored as configuration, so you can export it and deploy it across environments
like any other config.
