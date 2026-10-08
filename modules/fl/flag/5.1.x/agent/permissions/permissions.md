# Permissions

Static permissions in `flag.permissions.yml`; per-flag permissions generated dynamically
by `Drupal\flag\Permissions\FlagPermissions::permissions()` (from each flag's
`actionPermissions()`).

| Permission | Gates |
|---|---|
| `administer flags` | Define and manage flags and flag settings (`restrict access: TRUE`). Also the entity `admin_permission`. |
| `administer flaggings` | Delete flaggings belonging to other users (`restrict access: TRUE`). |
| `flag <flag_id>` | Use (set) the given flag. Generated per flag. |
| `unflag <flag_id>` | Remove the given flag. Generated per flag. |

Each flag you create adds its own `flag NAME` / `unflag NAME` permissions, letting you
grant flagging of a specific flag to specific roles.

## Extra (ownership) permissions
When a flag's entity type implements `EntityOwnerInterface` and the flag enables the
**owner** extra-permission set, four finer permissions are generated and checked in
`EntityFlagType::actionAccess()`:
`flag NAME own items`, `unflag NAME own items`, `flag NAME other items`,
`unflag NAME other items`. The comment flag type adds a `parent_owner` set for comments on
own parent entities.

## Access flow
Flag/unflag routes use the `_flag_access` / `_unflag_access` checks
(`FlagAccessCheck` / `UnFlagAccessCheck`), which call `$flag->actionAccess($action, …)`
→ the flag type plugin. That combines `hook_flag_action_access()` results with the
per-flag permission (and owner permissions) via `orIf`.
