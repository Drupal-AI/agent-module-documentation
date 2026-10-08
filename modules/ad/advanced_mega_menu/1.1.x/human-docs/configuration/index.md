# Configuration

Advanced Mega Menu turns a menu into a grid you can fill with content. The work
happens on the module's mega-menu content settings.

## Who can build mega menus

The module provides its own permission. Grant it on **People → Permissions**
(`/admin/people/permissions`) to the roles that should be able to build and edit
mega menus, then work as one of those users.

## Build the mega-menu grid

Open the mega-menu content configuration (route
`advanced_mega_menu.megamenu_content.settings`). There you:

1. Choose the menu / menu item whose dropdown you want to turn into a mega-menu
   panel.
2. Lay out a **grid** — the multi-column structure the panel will use.
3. Populate the grid cells with content:
   - **Views** — to show dynamic lists (for example recent articles or featured
     products) inside the menu.
   - **Blocks** — to drop in images, promotional content, or extra link columns.

Arrange these across the grid to compose the dropdown — featured content in one
area, columns of links in another.

## Access is inherited from the content

The Views and Blocks you place keep enforcing their own access rules, so a View
that is restricted, or a Block with visibility conditions, behaves the same inside
the mega menu as it does anywhere else. The mega menu is a layout wrapper — it does
not grant access to anything its content would not otherwise show.

## Verify

Save, then view the site and hover (or focus) the menu item you configured to
confirm the mega-menu panel renders with the grid and content you expect.
