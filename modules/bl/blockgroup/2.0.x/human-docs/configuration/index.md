# Configuration

There is no global settings form for Block Group — configuring it means creating
block groups and arranging blocks inside them, all from the Block layout area.

## Step 1 — Create a block group

1. Log in as a user with the **Administer blockgroups** permission (see
   [Permissions](#permission) below).
2. Go to **Structure → Block layout → Block groups**
   (`/admin/structure/block_group_content`) — it's a tab on the Block layout
   page.
3. Click **Add group**.
4. Enter a **Label** (e.g. "Header") — a machine name is derived from it. A group
   is nothing more than an id plus a human label.
5. Save. Creating the group immediately gives you two things: a new block called
   **"Block group: Header"**, and a new theme region with the same name.

## Step 2 — Place the group block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find and place the block titled **"Block group: <label>"** into a real theme
   region of your theme (this is the parent block that will render the group).

## Step 3 — Move blocks into the group

1. Still on the Block layout page, notice that the group also appears as its own
   **region** (listed as "Block group: <label>").
2. Assign any other blocks to that region — either by placing new blocks there or
   by changing an existing block's region to the group's region.
3. Those blocks now render inside the parent block, in weight order, with their
   own access checks still applied.

## Working with groups

- **Shared visibility and position:** set visibility conditions (path, role,
  content type), weight, and region on the *parent* group block, and they govern
  the whole cluster at once.
- **Nesting:** place one group's block into another group's region to build
  multi-level layouts as deep as you need.
- **Core blocks:** the main page content block and the page title block render
  correctly inside a group.

## Permission

Block Group defines one permission, set at **People → Permissions**
(`/admin/people/permissions`):

- **Administer blockgroups** (`administer blockgroups`) — gates every block-group
  management route (creating, editing, deleting groups). Grant it to trusted
  site-builder roles.

```bash
drush role:perm:add site_builder 'administer blockgroups'
```

## Deploying groups

Each block group is a `block_group_content` configuration entity storing only its
id and label, so groups export and import cleanly with `drush config:export` /
`config:import`, carrying your layout structure between environments. (The block
*placements* themselves are ordinary Block layout config, exported the same way.)
