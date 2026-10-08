# Moderation state permissions — agent index

Adds per-workflow, per-state `view`/`update`/`delete` permissions for content-moderated
entities via `hook_entity_access()`. No config UI (`configure` null), no schema, no Drush.
Depends on `workflows` (Content Moderation supplies the moderated entities).

- **Permission naming, how they are generated, and the fail-safe access logic** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Permission string: `workflow <workflow_id> - <operation> entities in <state_id> state`
  (`PermissionsGenerator::getPermissionName()`), operations = `view`, `update`, `delete`.
- Permissions are generated dynamically from all `Workflow` config entities × states ×
  operations (`.permissions.yml` → `permission_callbacks` → `PermissionsGenerator::getPermissions`).
- Access check keys off the entity's **current** moderation state, returns `forbidden` when
  the permission is missing else `neutral` — additive deny only, never grants access.
