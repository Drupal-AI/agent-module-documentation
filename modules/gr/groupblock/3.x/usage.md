<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Block enables custom block (block_content) entities to be related to a Group, so blocks can be owned by a group and access-controlled through the Group module's permission system.

---

The Group module models memberships and per-group content, but out of the box it does not know about core's custom blocks. Group Block supplies a `group_block` group-relation plugin (with a deriver that produces one plugin per `block_content` bundle) so a site can say "these custom blocks belong to this group". Once a group type installs the relation for a block bundle, blocks of that bundle can be added to a group and are subject to the group's create/view/update/delete permissions (the plugin sets `entity_access = TRUE` and forces `entity_cardinality` to 1).

The module clones core's group-relationship add/create pages to friendly paths (`group/{group}/block/add` and `group/{group}/block/create`), adds a **Blocks** operation link to each group (backed by the shipped `views.view.group_blocks` view, gated by the `access group_node overview` group permission and requiring Views), and provides group-scoped permissions via `GroupBlockPermissionProvider`. It also auto-attaches referenced blocks to a group when a group is created through the group creation wizard.

Setup: enable the module, then on each group type install the desired **Group block (<bundle>)** relation plugin and grant the relevant group permissions to roles/memberships. Access to blocks is entirely delegated to Group.

---

- Associate custom blocks with a specific group
- Let group editors manage their own blocks without site-wide block permissions
- Install a per-bundle group_block relation on a group type
- Restrict who can create blocks in a group via group permissions
- Control view/update/delete of group blocks per membership role
- Add a block to a group at `group/{group}/block/add`
- Create a new block directly inside a group at `group/{group}/block/create`
- Show a group's blocks overview via the shipped `group_blocks` view
- Add a "Blocks" operation link to each group's operations row
- Grant `access group_block overview` to let members see the block list
- Use the derived plugin for a particular custom-block type only
- Keep block cardinality at one-per-relationship (enforced by the plugin)
- Auto-attach referenced blocks when a group is created via the wizard
- Support unpublished-block viewing with the backward-compatible permission
- Scope block content to affiliate/department groups on a multi-team site
- Delegate all block access decisions to the Group permission system
