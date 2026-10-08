<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extension points and the transition access model

A transition may reference three kinds of pluggable logic by id. Two of the plugin types are defined by
this module; the third reuses core Actions.

## Guard plugins (module-defined)
- Type dir: `src/Plugin/Guard`. Discovery attribute `Drupal\field_states\Attribute\Guard`
  (legacy annotation `Annotation/Guard` also present). Interface `GuardInterface`, base `GuardPluginBase`.
  Manager service `plugin.manager.states.guard` (`GuardPluginManager`).
- Contract: `allowed(&$transition, $workflow, $entity = NULL): bool`. Receives the transition by
  reference so it can also set `class`/`attributes` on the button. Returning it makes the guard the
  **sole** authority for that transition (see access order below).
- Example: `Plugin/Guard/UserGuard.php` (`user_guard`) — always returns TRUE and decorates the button.

## Workflow plugins (module-defined, pre-save)
- Type dir: `src/Plugin/Workflow`. Attribute `Drupal\field_states\Attribute\Workflow`.
  Interface `WorkflowInterface`, base `WorkflowPluginBase`. Manager `plugin.manager.states.workflow`.
- Contract: `action(&$transition, $workflow, &$entity)`. Called by `applyTransition()` **before** the
  entity is saved (the entity is passed by reference, so it can mutate it).
- Example: `Plugin/Workflow/NotificationWorkflow.php` (`notification_workflow`) — if the optional
  `pwa_firebase` module exists, pushes a state-change message to the entity owner.

## Action plugins (core Action, post-save)
- Not a new plugin type — uses core `plugin.manager.action`. A transition's `action` id(s) are
  instantiated and their `execute($entity, $transition, $workflow)` is called **after** save.
- Example: `Plugin/Action/EmailAction.php` (`email_action`) — emails the entity owner. Its `access()`
  method is an unfinished stub (`@todo`, returns nothing), so do not rely on it for access control; the
  action only runs from `applyTransition()`, not as a general VBO action.

## Access decision — `StatesTransitionService::isTransitionAllowed(&$transition, $entity)`
Evaluated per transition to decide whether the button shows / the move is permitted:
1. If `transition['guard']` is set → return the guard's `allowed()` result (**short-circuits all of the
   below**).
2. Else if `transition['permission']` is set → hasPermission (any of a comma list).
3. Else if the current user has `access states` → TRUE.
4. If `transition['group']` is set → TRUE when the user is a member of one of the listed Groups.
5. Administrator role → always TRUE.
6. If `transition['role']` is set → TRUE when the user's roles intersect the listed roles.
7. Otherwise FALSE.

Note the breadth of step 3: the `access states` permission (labelled merely "see all states") is enough
to pass any transition that does not set its own `permission`/`guard`.
