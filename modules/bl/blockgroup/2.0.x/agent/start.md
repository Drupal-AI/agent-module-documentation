<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# blockgroup — agent start

Group multiple blocks into a single placeable block. Creating a **`block_group_content`**
config entity registers a derived block (`block_group:<id>`) *and* a theme region named
after the group id; blocks dragged into that region render together inside the group block.
No dependencies beyond core `block`; no services or Drush commands of its own.

- Manage block groups: config entity shape, create/edit/delete, drush → [configure/block-groups.md](configure/block-groups.md)
- The derived `block_group` block plugin, its deriver, regions & rendering → [plugins/block-group.md](plugins/block-group.md)

Key facts:
- Config entity type id: `block_group_content` (config name `blockgroup.block_group_content.<id>`; only `id` + `label` exported).
- Admin UI: `/admin/structure/block_group_content` (tab on the Block layout page). Permission: `administer blockgroups`.
- Placing a group: on `/admin/structure/block`, place the "Block group: <label>" block, then move blocks into the group's region.
