# Condition plugins & the `condition_group` visibility plugin

The module does **not** define its own plugin type/manager. It reuses Drupal core's **Condition**
plugin system (`plugin.manager.condition`) two ways.

## The `condition_group` Condition plugin

`src/Plugin/Condition/ConditionGroup.php` (`@Condition(id = "condition_group")`) is the block
visibility plugin the module adds to every block. Its config form (`buildConfigurationForm`) renders
a **Block Visibility Groups** select listing all `block_visibility_group` entities; the chosen id is
stored as `block_visibility_group` in the block's `visibility.condition_group` config
(schema `condition.plugin.condition_group`).

`evaluate()` loads that group and delegates to the `block_visibility_groups.group_evaluator`
service (returns TRUE when no group is selected, FALSE when the referenced group is missing). The
plugin also forwards the group's cache tags, contexts, max-age and config dependency, so a block
correctly depends on and invalidates with its group.

If a group is passed in the request query string, the select is pre-filled and disabled (used by the
group-scoped "Place block" flow).

## Conditions inside a group

A group's `conditions` are ordinary core Condition plugins resolved through the same core manager, so
**any** condition plugin is usable: core's Request Path, Node Type, User Role, plus contrib-provided
ones. Installing **CTools** adds entity-bundle and other conditions; **Menu Condition**,
**Term Condition** and **Token Conditions** add theirs. No code in this module is required to use
them — they appear automatically in the "Add new condition" modal.

## Adding your own condition

To offer a new condition to groups, implement a standard core Condition plugin in any module
(`src/Plugin/Condition/MyCondition.php` with the `#[Condition]` attribute / `@Condition` annotation).
It will show up in a group's condition list with no Block Visibility Groups-specific glue.

The group's AND/OR combination is handled by `GroupEvaluator` (see
[../api/api.md](../api/api.md)) via core's `ConditionAccessResolverTrait`.
