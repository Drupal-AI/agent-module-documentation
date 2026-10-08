# Configuration

There is no central settings page. Everything lives on two blocks you place from
**Structure → Block layout** (`/admin/structure/block`): the **menu** block (the
panel) and the **trigger** block (the button). Place the menu block first, then
the trigger and point it at the menu.

## 1. Place and configure the menu block

At **Structure → Block layout**, click **Place block** in the region you want and
choose **Cheeseburger menu**. Its settings form is where most of the work happens.

### Aggregated sources — which menus and vocabularies to show

The heart of the form is a two-list ("Disabled" / "Enabled") drag-and-drop area.
Drag any of your **menus** and **taxonomy vocabularies** into the Enabled list and
order them — that order (weight) is the order they appear in the panel. For each
enabled source you can set:

- **Max depth** — how many levels deep this source renders (0 = no limit).
- **Initial visibility level** — which level is shown when the panel first opens.
- **Expanded by default** — whether its child items start open.
- **Title options** — show the source's title in the top navigation, make the
  title collapsible, show it above the menu, or override it with your own text.
- **Show links in navigation** — surfaces the source's links in the top nav (this
  forces a shallow, non-expanded rendering).
- **Icon** — upload an SVG to display next to this source in the panel.

Mixing a menu (say *Main navigation*) with a vocabulary (say *Product categories*)
in one panel is exactly what this is designed for.

### Behavior toggles

- **Use default CSS** / **Use default JS** *(both on)* — load the module's own
  styles and scripts. Turn these off if you want to theme the menu entirely
  yourself.
- **Show navigation** *(on)* — render the in-panel top navigation bar for quick
  section jumping.
- **Parent menu item as link** *(off)* — show a parent item as a clickable link
  rather than only a toggle.
- **Track active trail** *(on)* — highlight the currently active menu item (this
  adds the appropriate cache contexts).
- **Invoke hooks** *(off)* — enable the module's three alter hooks. Leave it off
  for best performance unless you (or a developer) actually use those hooks.

### Colors

A set of color + opacity pairs let you brand the menu independently: **left panel
background/text**, **right panel background/text**, **trigger**, **trigger
background**, and **scrollbar**. Each takes a hex color plus an opacity from 0 to 1.

Save the block. Note its **block id** (visible in the URL when editing it, or in
the block list) — you'll need it for the trigger.

## 2. Place and configure the trigger block

Place a second block, this time **Cheeseburger menu trigger**. Its settings:

- **Block to trigger** *(required)* — choose the menu block this button should
  open. This is what links the button to the panel.
- **Breakpoints** — if core's Breakpoint module is enabled, pick the breakpoints
  at which the trigger should be visible (for example show it only on small
  screens to make a mobile-only hamburger).
- **Custom media query** — as an alternative to named breakpoints, supply a raw
  CSS media query for precise control over when the trigger appears.

Save the trigger block. Visit the front end and the trigger button now opens your
off-canvas menu.

## Multiple menus

You can repeat this — place several menu blocks (each with its own aggregated
sources and styling) and a matching trigger for each — to run more than one
independent cheeseburger menu on the same site.

## Deployment

All settings are stored on the placed blocks' configuration
(`block.block.<id>`), so they export and import with the rest of your site
configuration. You can inspect a placed block with
`drush cget block.block.<id> settings`.
