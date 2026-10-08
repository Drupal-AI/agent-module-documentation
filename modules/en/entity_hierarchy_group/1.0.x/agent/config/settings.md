<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & configuration

## Install / enable

`drush en entity_hierarchy_group` (or via the UI). It depends on `entity_hierarchy` and `group`,
so those are enabled first. Requires Group 3.x and Entity Reference Hierarchy 5.x. After enabling,
visit the settings form and turn on the restrictions you want — the module does nothing until then.

## Settings form

- Class: `Drupal\entity_hierarchy_group\Form\EntityHierarchyGroupSettingsForm` (extends
  `ConfigFormBase`), form id `entity_hierarchy_group_entity_hierarchy_group_settings`.
- Route: `entity_hierarchy_group.entity_hierarchy_group_settings`, path
  `/admin/group/entity-hierarchy-group-settings`, requirement
  `_permission: 'administer site configuration'` (see `entity_hierarchy_group.routing.yml`).
- Menu link: `entity_hierarchy_group.links.menu.yml` places it under `system.admin_group`
  (Administration -> Groups), weight 20, titled "Entity hierarchy group settings".

## Config object `entity_hierarchy_group.settings`

Schema in `config/schema/entity_hierarchy_group.schema.yml` (type `config_object`). Three boolean
keys, all read by `EntityHierarchyGroupHelper`:

- **`limit_group`** — "Limit selection of parents to recent group". When editing content that
  belongs to a group, restrict selectable parents to entities in the *same* group. Read via
  `getLimitGroup()`.
- **`limit_no_group`** — "Limit selection of parents to content without group connection when not
  in group context". When editing content that is *not* in any group, restrict parents to entities
  that have no group connection. Read via `getLimitNoGroup()`.
- **`limit_group_hierarchy_count`** — "Limit selection of parents in recent group to one
  hierarchy". Enforced by the `GroupHierarchyParent` constraint (see
  [../api/integration.md](../api/integration.md)); allows only a single hierarchy root per group.
  Read via `getLimitGroupCount()`.

There is no `config/install/` default file; unset keys default to `FALSE` (`?? FALSE` in each
getter), so a fresh install is inert until saved through the form.

## Notes

- The module declares no `configure` key in its `.info.yml`; the settings link is provided only
  through the menu link above.
- No permissions are defined by this module; access to the form uses core's
  `administer site configuration`.
