<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Block — configuring and operating

Group Block plugs core `block_content` (custom block) entities into the
[Group](https://www.drupal.org/project/group) module as a group relationship, so
custom blocks can be owned by (and access-controlled per) a group.

## Enable the relation on a group type
1. Go to a group type's *Content* / relationship plugins UI
   (Administration > Groups > Group types > [type] > *Set available content*).
2. Install the **Group block (<block type>)** plugin. One plugin is derived per
   `block_content` type (see `GroupBlockDeriver`), so you pick the specific
   custom-block bundle to relate.
3. `entity_cardinality` is forced to 1 and disabled in the plugin config form —
   the module relies on one block per relationship.

## Routes added
`GroupBlockRouteSubscriber` clones core's group-relationship create/add pages:
- `entity.group_relationship.group_block_add_page` → `group/{group}/block/add`
- `entity.group_relationship.group_block_create_page` → `group/{group}/block/create`

These reuse core's group-relationship access checks. A **Blocks** operation link
is also added to each group's operations (`hook_entity_operation`), linking to the
`view.group_blocks.page_1` view, shown only to members with the
`access group_node overview` group permission and when Views is enabled.

## Permissions
Group-scope permissions are provided through `GroupBlockPermissionProvider` (create/
view/update/delete per relationship, plus a backward-compatible `view unpublished`
name). There is also a global-ish group permission `access group_block overview`.

## Auto-add on group creation
`hook_form_alter` + `groupblock_content_entity_submit`: when a group is created
through the group wizard, any entity-reference field on the new group that targets
`block` entities and whose block type is an installed `group_block:<bundle>`
relationship is automatically added to the group as group content.
