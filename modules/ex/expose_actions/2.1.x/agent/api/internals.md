<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expose actions — internals (hook, plugin, form, permissions)

All code lives in four small units. No services.yml; classes use `\Drupal::` static calls or the
core `_form`/`_custom_access` wiring.

## `hook_menu_local_actions_alter()` — expose_actions.module

`expose_actions_menu_local_actions_alter(array &$local_actions)`:

- Loads all `action` config entities: `\Drupal::entityTypeManager()->getStorage('action')->loadMultiple()`.
- For each with `$action->status()` TRUE, builds a local action definition keyed `action_<id>`:
  - `title` = `$action->label()`.
  - `route_name` = `$def['confirm_form_route_name']` if the plugin definition sets it, else
    `expose_actions.confirm`.
  - `route_parameters` = `['action' => $id]` (entity_type/entity_id are added later by the plugin).
  - `appears_on` = `['entity.' . $action->getType() . '.canonical']`.
  - `class` = `ExposeAction::class`, `provider` = `expose_actions`.

## `ExposeAction` — src/Plugin/Menu/LocalAction/ExposeAction.php

- Extends core `LocalActionDefault`.
- Overrides `getRouteParameters(RouteMatchInterface $route_match)`: takes the parent params, then
  scans `$route_match->getParameters()->all()`; for the first value that is an `EntityInterface`,
  sets `entity_type = $entity->getEntityTypeId()` and `entity_id = $entity->id()`. This makes the
  confirm link point at the specific entity currently being viewed.

## `Confirm` — src/Form/Confirm.php (ConfirmFormBase)

- `create()` injects `entity_type.manager`. The constructor eagerly reads `action`, `entity_type`,
  `entity_id` from the request attributes and calls `loadAction()` / `loadEntity()` (each guarded
  so it loads once), catching `InvalidPluginDefinitionException | PluginNotFoundException`.
- `loadAction($id)` / `loadEntity($type, $id)`: load the action / target entity via the entity type
  manager storage.
- `checkAccess(AccountInterface $account, $action_id, $entity_type, $entity_id)` — the route's
  `_custom_access`: loads the action, requires the account to hold
  `access exposed action <action_id>`, and checks the target entity's access before the confirm step.
- `getFormId()` = `confirm_expose_action`. `getQuestion()` = "Are you sure?".
  `getDescription()` names `%action`, `@type` (entity type label), `%entity` (entity label) via
  `t()` placeholders. `getCancelUrl()` = `$entity->toUrl()`.
- `submitForm()`: `$this->action->execute([$this->entity])`; adds a `%action completed!` status
  message; `setRedirectUrl($this->getCancelUrl())`.

## `Permissions` — src/Permissions.php

- `generate()` (registered in `expose_actions.permissions.yml` via `permission_callbacks`): loads
  all action entities and returns a permission `access exposed action <id>` per action, whose title
  is a `t()` string linking to `$action->toUrl()`. Wrapped in try/catch for
  `InvalidPluginDefinitionException | PluginNotFoundException | EntityMalformedException`.

## Behavioural notes

- Rebuild caches (`drush cr`) after adding/enabling actions or changing status so the local action
  set is regenerated.
- The action's `execute()` semantics are entirely core/contrib action logic; expose_actions only
  provides the button and the confirm wrapper.
