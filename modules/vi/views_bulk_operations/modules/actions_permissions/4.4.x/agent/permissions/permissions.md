# Permissions

Provided dynamically via `permission_callbacks: \Drupal\actions_permissions\ActionsPermissions::permissions`
(no static `*.permissions.yml` list). Shown on `/admin/people/permissions`.

## Generated permission names
For each VBO action definition:
- `execute <action_id> all` — action whose `type` is `''` (applies to all entity types).
- `execute <action_id> <entity_type>` — action limited to a specific entity type
  (e.g. `execute views_bulk_operations_delete_entity node`).

Title format: *"Execute the %action action on %type."*

## How it enforces access
`ActionsPermissionsEventSubscriber` subscribes to
`ViewsBulkOperationsActionManager::ALTER_ACTIONS_EVENT` at priority **-999** (last). For each
offered action it removes the definition from the available list unless the current user has
the matching `execute …` permission.

Exceptions:
- Actions that declare their own non-empty `requirements` in the `#[Action]` definition are
  **skipped** (their own access rules apply).
- The internal permissions-building pass sets `skip_actions_permissions`, so generating the
  permission list does not itself filter actions.
