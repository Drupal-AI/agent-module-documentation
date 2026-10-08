# Drush commands

Registered in `drush.services.yml` via `Drupal\access_policy\Commands\AccessPolicyCommands`
(legacy annotated-command style, `tags: [{name: drush.command}]`).

| Command | Alias | Arguments | Purpose |
|---------|-------|-----------|---------|
| `access-policy:check-access` | `apca` | `<entity_type> <entity_id> <username>` | Diagnose a user's access to one entity |

## Behaviour

`checkAccess($entity_type, $entity_id, $username)`:

1. Loads the entity (`entity_type` + `entity_id`) and the user (by `name`); logs an error and
   returns if either is missing.
2. Prints which access policies are assigned to the entity (via
   `access_policy.content_policy_manager`), or "No access policies are assigned to this entity."
3. For each real operation applicable to the entity type (from the operation plugin manager —
   `view`, `view all revisions`, `update`, `delete`, `manage access`; note pseudo-operations like
   `view_unpublished` are not listed separately), calls `$entity->access($op, $account, TRUE)` and
   renders a table of **Operation / Access (Yes/No) / Message**, where Message is the access-result
   reason (the failing access rule or missing permission, including any core reason).

## Example

```
$ drush apca node 123 jsmith

Access policies assigned to this entity: Me only

-------------------- -------- ----------------------------------------------------
Operation            Access   Message
-------------------- -------- ----------------------------------------------------
view                 Yes
view all revisions   No       The 'Authored by current user' access rule failed.
update               No       The 'Authored by current user' access rule failed.
delete               No       The 'Authored by current user' access rule failed.
-------------------- -------- ----------------------------------------------------
```

Read-only and diagnostic — it changes no data.
