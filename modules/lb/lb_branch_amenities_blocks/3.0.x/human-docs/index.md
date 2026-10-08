# Y Layout Builder — Branch Amenities — manual setup guide

**Y Layout Builder — Branch Amenities** (`lb_branch_amenities_blocks`) adds a
placeable Layout Builder block that shows the facilities available at a branch
location — a pool, a gym, childcare, parking, and so on — as structured,
icon-and-label data rather than a paragraph of prose. It is part of the YMCA
Website Services family of Layout Builder components (the `y_lb` package).

Presenting amenities this way answers the first question a visitor has about a
location at a glance, and because the data is structured (each amenity is a
Paragraph carrying an icon and a label) the same information stays consistent
across dozens of branch pages and can be reused elsewhere — for example to power
location filtering. Icons are lazy-loaded through Blazy, and amenities are
modelled with the Paragraphs and Media modules.

This module is designed to be used **with the YMCA's Website Services
distribution**. Its hard dependency on **Y Layout Builder (`y_lb`)** means it is
not a standalone install — see [Installation](installation/index.md) for the
important note about where `y_lb` actually comes from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, the Composer/Drush
   commands, and the `y_lb` dependency caveat.

This module has **no configuration page** of its own. You place and edit the
amenities block from within the Layout Builder interface, described below.

## Where it lives in the admin menu

There is no dedicated settings page (`configure` is null). Everything happens in
**Layout Builder**: edit a branch page's layout, add the Branch Amenities block
to a section, and fill in each amenity (icon/media and label) as Paragraph items.
For general Layout Builder mechanics, see Drupal core's Layout Builder — this
module simply contributes one more block type to that toolbox.

## How to use it

1. Enable the module (and the rest of the YMCA Website Services / `y_lb` stack it
   belongs to).
2. Open a Branch page and enter its **Layout** (Layout Builder) editing screen.
3. **Add block** to the section where amenities should appear and choose the
   Branch Amenities block.
4. Add each amenity as a Paragraph item — pick or upload its icon (Media) and
   give it a label. Media images are lazy-loaded by Blazy.
5. Save the layout. The amenities render as a consistent icon-and-label grid.

Keeping amenities as structured items (rather than free text) is what lets the
same data drive location comparison or filtering features later, and keeps every
branch page presenting facilities the same way.
