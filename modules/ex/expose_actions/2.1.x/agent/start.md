<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expose actions as local actions (expose_actions) — agent index

Exposes enabled core **Action** config entities as **local action buttons** on entity canonical
pages. Clicking one opens a **confirm form** that executes the action against the viewed entity.
Very lightweight: no settings form, no config objects, no services, no Drush. Version **2.1.0**.
Core `^10 || ^11`. PHP `>=8.1`. License GPL-2.0-or-later. Depends on core **`action`**.

- **How it works, routes, permissions, and how to operate it** → [config/settings.md](config/settings.md)
- **The internals: hook, plugin class, confirm form, permission callback** → [api/internals.md](api/internals.md)

## What it actually is (from source)

- `expose_actions.module` implements **`hook_menu_local_actions_alter()`**: loads every `action`
  config entity via `entity_type.manager`; for each **enabled** (`$action->status()`) action it
  registers a local action keyed `action_<id>` that `appears_on` `entity.<action-type>.canonical`,
  with `class => ExposeAction`, `route_name => expose_actions.confirm` (or the action's own
  `confirm_form_route_name` when the plugin defines one), and `route_parameters => {action: <id>}`.
- One route, **`expose_actions.confirm`**, path `/trigger/{action}/{entity_type}/{entity_id}`,
  `_form => Drupal\expose_actions\Form\Confirm`, access via `_custom_access`
  `Confirm::checkAccess`.
- **Dynamic permissions** via `permission_callbacks` → `Permissions::generate()`: one
  `access exposed action <action_id>` per action, shown on the core Permissions page.
- **Plugin class** `ExposeAction` (`src/Plugin/Menu/LocalAction/ExposeAction.php`) extends core
  `LocalActionDefault`; `getRouteParameters()` adds `entity_type`/`entity_id` from the current
  route's entity so the confirm link is entity-specific.
- **No** config/install, **no** config/schema, no settings form, no third-party libraries.

## Provides

- Route: `expose_actions.confirm`.
- Local action menu plugin class: `ExposeAction`.
- Dynamic permissions: `access exposed action <action_id>` (one per action entity).
- Hook: `hook_menu_local_actions_alter()`.

## Setup (from README)

1. Enable the module (requires core `action`).
2. Review/create actions at `admin/config/system/actions`.
3. Grant the relevant `access exposed action <id>` permissions per role at
   `admin/people/permissions#module-expose_actions`.
4. Ensure the "Local actions" region is placed in block layout for the entity views where buttons
   should appear.
