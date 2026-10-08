# CSS Grid — manual setup guide

**CSS Grid** (`css_grid`) brings native CSS Grid layouts into Drupal's **Layout
Builder**. It adds a "CSS Grid" layout to the list of options you can choose for
a section, and lets you shape that section with the real CSS Grid properties —
`grid-template-columns`, `grid-template-rows`, and gaps — so editors can build
genuine grid‑based sections rather than being limited to fixed one/two/three‑column
layouts. It depends on core's **Layout Builder** and **Layout Discovery** modules
and works on Drupal 8.8 through 11.

Because it is a theming/layout integration, there is nothing to configure at the
module level — the grid settings live on each Layout Builder section where you
choose the CSS Grid layout. This is a beta release, and it has no security
surface of its own.

The one thing worth checking after you build a grid is **responsive behavior**:
grid configurations are where layouts most often need tuning across breakpoints,
so preview your sections at different screen sizes before you rely on them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Layout Builder.

There is **no module settings page** — you configure a grid directly on each
Layout Builder section, as described in "How to use it" below.

## Where it lives in the admin menu

CSS Grid adds no admin settings page. You use it inside **Layout Builder**, which
is enabled per entity display under **Structure → Content types → *(type)* →
Manage display**.

## How to use it

1. Enable **Layout Builder** for the entity display you want (for example a
   content type: **Structure → Content types → *(type)* → Manage display**, then
   tick **Use Layout Builder**).
2. Edit the layout and **add a section**. In the layout chooser, pick **CSS Grid**
   from the list of layout options.
3. Configure the section's grid — set the columns, rows, and gaps to build the
   structure you want.
4. Place blocks into the grid areas, save, and **preview across breakpoints** to
   confirm the responsive behavior is what you expect.
