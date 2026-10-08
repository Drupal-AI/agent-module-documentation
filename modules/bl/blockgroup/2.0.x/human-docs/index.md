# Block Group — manual setup guide

**Block Group** (`blockgroup`) lets you bundle several blocks together into a
single, placeable block. Instead of positioning a header logo, a search box, and
a menu individually — and repeating their visibility rules on each — you create
one "Header" group, drop your blocks into it, and place the whole thing as a
unit.

Each block group you create does two things at once behind the scenes: it becomes
a new **block** you can place on the Block layout page, and it adds a new **theme
region** named after the group. You place the group's block into a normal region,
then drag any other blocks into the group's own region. When the group renders, it
collects every enabled block assigned to its region — in weight order, with access
checks applied — and outputs them together.

Because the group is itself a block, its placement, weight, and visibility
conditions cascade to all of its children. Set one path or role condition on the
group and the whole cluster follows it. You can even nest a group inside another
group's region to build multi-level layout structures, and special core blocks
(the main page content and the page title) render correctly inside a group.

Groups are stored as simple configuration (just an id and a label), so they
travel cleanly through configuration sync between environments. The module needs
nothing beyond core's Block module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create block groups, place them, and
   move blocks into them.

## Where it lives in the admin menu

Block groups are managed at **Structure → Block layout → Block groups**
(`/admin/structure/block_group_content`), a tab alongside the normal Block layout
page (`/admin/structure/block`).

## How to use it

1. Create a block group (an id + label) on the Block groups screen.
2. On the Block layout page, place the **"Block group: <label>"** block into a
   real theme region.
3. Drag any other blocks into that group's own region so they render inside the
   group.

See [Configuration](configuration/index.md) for the details.
