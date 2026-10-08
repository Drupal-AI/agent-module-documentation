# Configuration

Setting up Responsive Layout Builder happens in two stages: first you define the
**breakpoints** (media queries) the module offers, then you apply those
breakpoints to individual blocks inside a **Layout Builder** layout.

## Open the settings form

1. Log in as a user with permission to administer site configuration (an
   administrator by default).
2. Open the module's settings form, registered as
   `responsive_layout_builder.settings`, under **Configuration**.

This is where you set up the breakpoints — the media queries — that will be
available when you configure blocks. Define the screen sizes your design cares
about (for example a mobile, tablet, and desktop breakpoint), then save.

## Apply breakpoints to blocks in Layout Builder

1. Go to a layout you manage — either a content type's default layout
   (**Structure → Content types → *(your type)* → Manage display → Manage
   layout**) or an individual entity's layout override.
2. Add or edit a block in the layout.
3. In the block's configuration, use the **responsive / breakpoint** options this
   module adds to choose which breakpoints the block should display at (or be
   hidden at).
4. Save the block, then save the layout.

The block will now be shown only at the screen sizes you selected, and blocks
scoped to a breakpoint are loaded dynamically as required for that size.

## Important: display, not access control

Controlling a block by breakpoint changes **whether it is shown**, not **whether
it is delivered**. A block hidden for a given screen size via media queries is
still present in the page's HTML — it is simply not displayed. Never use this to
conceal sensitive content; rely on each block's own access rules and permissions
for that. This module has no access‑control role.
