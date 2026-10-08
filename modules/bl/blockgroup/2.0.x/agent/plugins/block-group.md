<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — the `block_group` derived block

The module defines **one** block plugin, `block_group`
(`src/Plugin/Block/BlockGroup.php`), with a **deriver** that turns every
`block_group_content` config entity into its own placeable block. It does not define a new
plugin *type* — it plugs into core's Block plugin system.

## The deriver — one block per group

`src/Plugin/Derivative/BlockGroups.php` (a `ContainerDeriverInterface`) loads every
`block_group_content` entity and emits one derivative per group:

- Derivative id = the group's entity id, so the full plugin id is **`block_group:<id>`**.
- `admin_label` is set to the group's label → shown as "Block group: <label>" in the UI.
- A config dependency on the group entity is added, so exporting a placed group block also
  pulls in the group config.

Derived definitions are cached; `BlockGroupContent::clearBlocksCaches()` clears the block
plugin manager on group save/delete so new groups appear without a manual cache rebuild.

## The region — where child blocks live

`blockgroup_system_info_alter()` (in `blockgroup.module`) adds one region per group to
**every theme**, keyed by the group id, labelled "Block group: <label>". That is why child
blocks can be assigned to the group on the normal block-layout page. Region list is rebuilt
via `theme_handler->refreshInfo()` in `clearBlocksCaches()`.

## How a group renders (`BlockGroup::build()`)

When the parent `block_group:<id>` block renders it:

1. Loads all `block` config entities for the **active theme** whose `region` equals the
   group id, sorted by weight (`Block::sort`).
2. For each block:
   - `system_main_block` → renders the injected **main page content** (the plugin
     implements `MainContentBlockPluginInterface`).
   - `page_title_block` → renders a `#type => page_title` element from the title resolver.
   - any other block → access-checked (`view`), runtime contexts applied for
     context-aware plugins, then rendered via the block view builder.
3. Returns the collected render array, wiring up cache tags/contexts of the child blocks,
   the group entity, and the block list.

Nesting works because a group block is itself a block: assign `block_group:<inner>` to the
region of `<outer>`.

## Implementing your own — not needed here

You do **not** write PHP to add a group; you create a `block_group_content` config entity
(see [../configure/block-groups.md](../configure/block-groups.md)) and the deriver produces
the block for you. There is no plugin annotation/attribute for site builders to implement.
