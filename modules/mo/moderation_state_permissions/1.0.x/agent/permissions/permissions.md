# Permissions & access logic

## Generated permissions

Registered via `.permissions.yml`:

```yaml
permission_callbacks:
- Drupal\moderation_state_permissions\PermissionsGenerator::getPermissions
```

`PermissionsGenerator::getPermissions()` loops every `Workflow` config entity
(`Workflow::loadMultiple()`), each state in `type_settings.states`, and the three operations
in `PermissionsGenerator::$OPERATIONS = ['view', 'update', 'delete']`, emitting one
permission each. The machine string is built by `getPermissionName()`:

```
workflow <workflow_id> - <operation> entities in <state_id> state
```

e.g. `workflow editorial - update entities in draft state`. Titles read like
`Workflow: Editorial - update entities in the Draft state`. Because the set is derived from
live workflow config, permissions appear/disappear on `admin/people/permissions` as workflows
and states change. None are marked `restrict access: true`.

Static helpers (all on `Drupal\moderation_state_permissions\PermissionsGenerator`):
- `getWorkflows()` → `Workflow::loadMultiple()`.
- `getWorkflowStates(Workflow $workflow)` → `$workflow->get('type_settings')['states']`.
- `getPermissionName($operation, $workflowId, $moderationStateId)` → the string above.

## Access enforcement (`hook_entity_access`)

In `moderation_state_permissions_entity_access()`:

1. Uses `content_moderation.moderation_information` to check `isModeratedEntity($entity)` and
   that `$operation` is one of view/update/delete; otherwise returns `AccessResult::neutral()`.
2. Resolves the entity's current state: `moderation_state->value` → `getState(...)`, falling
   back to the workflow's `getInitialState()` for entities with no value yet.
3. Builds the permission name for `(operation, workflow id, state id)` and returns
   `AccessResult::forbiddenIf(!$account->hasPermission($permission))` with the
   `user.permissions` cache context.

Semantics to rely on:
- The hook only ever returns **forbidden** (permission missing) or **neutral** — it is a pure
  additive restriction and **cannot grant** access. No fail-open path exists here.
- Gating is by the entity's **current stored state**, not by the transition a user is
  attempting. A user editing a Draft needs `update ... in draft state`; the target state is
  irrelevant to this check.
- Standard `hook_entity_access` caveats apply: contexts that bypass entity access (Views
  without an access filter, certain listing/render paths) are not covered by this module.
- Grant the relevant per-state permissions to each role on `admin/people/permissions`; with no
  permission granted, moderated entities become inaccessible for that operation to that role.
