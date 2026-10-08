# Configuration

Superfish is configured entirely **per block** — there is no site-wide settings
page. You place a Superfish block, choose the menu it renders, and set its
behavior on the block's own form. Every option below lives on that form, and the
values are saved as block configuration (so they export and deploy with your
config).

## Place a Superfish block

1. Log in as a user who can administer blocks and go to **Structure → Block
   layout** (`/admin/structure/block`).
2. Find the region where you want the menu (for example *Primary menu* or a
   sidebar) and click **Place block**.
3. In the block browser, pick the **Superfish** block for the menu you want —
   there is one Superfish block per menu (Main navigation, Footer, and so on).
4. The block's configuration form opens. Configure the settings described below,
   then **Save block**.

You can place several Superfish blocks — for instance a horizontal navbar built
from the main menu in the header and a vertical fly-out built from a secondary
menu in a sidebar — each with its own settings.

## Menu layout and depth

- **Menu type** — choose **horizontal**, **vertical**, or **navbar**. Horizontal
  is the classic top navigation bar with dropdowns; vertical is a stacked list
  with side fly-outs; navbar renders a bar whose items open dropdown sub-items.
- **Starting level** — the menu level to begin rendering from. Leave it at the top
  to show the whole menu, or start deeper to show only sub-menus of the current
  section.
- **Depth** — how many levels below the starting level to display. Cap this if you
  only want, say, two levels of a deep menu tree.
- **Expand all items** — show every menu item regardless of the active trail,
  rather than only expanding the branch the visitor is currently in.

## Appearance

- **Style** — pick one of the module's built-in visual style presets for the menu.
- **Arrows** — add a small arrow indicator to any item that has children, so
  visitors can see where sub-menus exist.
- **Drop shadows** — add a drop shadow beneath open sub-menus for a layered look.

## Animation and hover behavior

- **Speed** — how fast sub-menus animate open and closed.
- **Delay** — the mouse hover delay before a sub-menu reacts, which helps prevent
  menus flickering open as the cursor passes over items.
- **Slide** — add a slide-in effect to sub-menus as they appear.
- **Supposition** — enable jQuery Supposition, which nudges sub-menus that would
  otherwise open off the edge of the screen back into view.
- **hoverIntent** — enable hoverIntent for smarter hover detection, so menus only
  open on a deliberate pause rather than on every quick pass of the mouse.

## Touchscreen and responsive behavior

Superfish includes a comprehensive touchscreen mode for phones and tablets, where
"hover" does not exist. The touch options let you:

- **Enable touchscreen support** so the first tap opens a sub-menu and the second
  follows the link.
- Choose the **touch behavior** and whether hover is disabled on touch devices.
- Set a **breakpoint** so the menu switches to touch/small-screen behavior below a
  given screen width.
- Configure **user-agent detection** (and a custom user-agent list) to decide
  which devices are treated as touch devices.

Additional **small-screen** options control how the menu adapts on narrow
viewports.

## Save

Click **Save block**. The menu renders with your chosen behavior immediately.
Because everything is stored as block configuration, you can export it with
`drush config:export` and deploy the exact same menu styling to another
environment. To fine-tune the markup itself, copy the module's Twig templates
(`superfish.html.twig`, `superfish-menu-items.html.twig`) into your theme and
override them.
