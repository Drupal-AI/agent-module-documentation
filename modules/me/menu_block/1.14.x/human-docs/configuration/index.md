# Configuration

Menu Block has **no global settings form** — you configure each menu block when
you place it. Everything below lives on an individual block's configuration form.

## Place a menu block

1. Log in as a user who can administer blocks (an administrator by default).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Click **Place block** on the region where you want the menu, then find your
   menu in the **Menus** category and click **Place block** next to it. (Each menu
   appears as its own Menu Block entry.) If your site uses **Layout Builder**, you
   can add the same block to a section there.

The block's configuration form opens with all the options below.

## Menu levels

- **Initial visibility level** — the level of the menu tree the block starts
  showing from. `1` (the default) is the top level, always visible; a higher value
  shows only deeper items, and the block appears only when the active trail
  reaches that depth. This is how you build an "in this section" submenu that only
  shows once the visitor is inside a section.
- **Number of levels to display** — how many levels to show from the initial
  level. `0` (the default) means **unlimited**; `2` would show the initial level
  plus one more, and so on. Use it to keep a footer or sidebar menu shallow.
- **Expand all menu links** — when ticked, every child link is rendered
  regardless of the active trail, so the whole subtree is always visible rather
  than only the branch the visitor is currently on.

## Follow the active menu item

- **Make the initial visibility level follow the active menu item** — when
  ticked, the starting level is calculated relative to the page the visitor is on,
  so the block always shows menu items *around* their current location as they
  browse.
- **Initial visibility level will be** — appears when "follow" is on. Choose
  whether the block shows the **active menu item** itself, or its **children**.

## Fixed parent item

- **Fixed parent item** — instead of following the active trail, root the block
  at a specific menu link you choose from this dropdown. The block then always
  shows that item's subtree, which is ideal for a persistent section navigation
  that doesn't change as the visitor moves around.

## Parent, empty, and non‑menu pages

- **Render parent item** — also show the chosen parent link at the top of an
  otherwise children‑only tree.
- **Hide block if the current page is not in the menu** — suppress the block
  entirely on pages that don't appear in this menu.
- **Show block if the menu is empty** — when unticked (the default behavior for
  empty trees), the block is hidden if it has no links to show, so you don't get
  empty region markup; tick it to render the block anyway.

## Block title

- **Use menu title as block title** / dynamic title options — instead of a fixed
  label, the block title can be driven by the menu itself. The available sources
  are: the plain **block** label you type, the **menu** title, the **active
  item**, the active trail's **parent** or **root**, the parent at the visibility
  level, or the **fixed parent** item's title.
- **Link the block title** — when a dynamic, item‑based title is used, turn it
  into a link to that menu item.

## Theme hook suggestion

- **Theme hook suggestion** — an optional machine name that adds a
  `menu__<suggestion>` theme suggestion for this block. Fill it in when you want to
  give one particular block its own Twig template and CSS — for example a mega‑menu
  or a specially styled sidebar — without affecting every menu on the site.

## Save

Fill in the block title and any visibility settings as usual, then click **Save
block**. Your configured menu block appears in its region immediately. Because all
of these settings are stored as configuration, the block can be exported and
deployed to other environments like any other block.
