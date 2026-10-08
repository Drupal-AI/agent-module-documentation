<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expose actions — operating & configuration

There is **no settings form and no config object** for this module. All configuration is done with
Drupal core screens; expose_actions only wires enabled actions into the entity UI.

## Install / enable

- `drush en expose_actions` (or via Extend). Hard dependency: core **`action`** module
  (`expose_actions.info.yml`).
- Core requirement `^10 || ^11`, PHP `>=8.1`. No composer requirements beyond php.

## Which actions get exposed

- On cache rebuild, `hook_menu_local_actions_alter()` (`expose_actions.module`) iterates all
  `action` config entities and exposes only those where `$action->status()` is TRUE.
- Manage the action list at **`admin/config/system/actions`** (core Actions UI). Simple actions
  can be added there; advanced/plugin actions come from core and contrib (Rules, VBO, etc.).
- Each exposed action appears as a **local action button** on the canonical route of the entity
  type it targets — `entity.<entity_type>.canonical` (e.g. `entity.node.canonical`). The target
  type comes from `$action->getType()`.
- Buttons only render where the **Local actions** (primary/help actions) region is placed in the
  active block layout for that view. If you don't see a button, check block placement first.

## Permissions (one per action)

- `Permissions::generate()` (registered via `expose_actions.permissions.yml` →
  `permission_callbacks`) creates a permission **`access exposed action <action_id>`** for every
  action entity.
- Grant them per role at **`admin/people/permissions#module-expose_actions`**. Each permission's
  title links to that action's config page.
- A user must hold the specific `access exposed action <id>` permission to reach the trigger form
  for that action (checked in `Confirm::checkAccess`).

## The trigger flow

- Route **`expose_actions.confirm`**: `/trigger/{action}/{entity_type}/{entity_id}`.
- It renders a core `ConfirmFormBase` (`Confirm`): question "Are you sure?", description naming the
  action, entity type and entity label, cancel link back to the entity (`$entity->toUrl()`).
- On confirm (submit), `Confirm::submitForm()` runs `$action->execute([$entity])`, adds a
  "%action completed!" status message, and redirects to the entity's canonical URL.
- If an action defines `confirm_form_route_name` in its plugin definition, the local action links
  to **that** route instead of `expose_actions.confirm` (core actions that ship their own confirm
  form are used as-is).

## Notes

- Execution and access are per single entity (the one being viewed) — this is not a bulk-operation
  UI; use Views Bulk Operations for multi-entity runs.
- Uninstalling removes the buttons and the generated permissions; the underlying action entities
  are core config and remain.
