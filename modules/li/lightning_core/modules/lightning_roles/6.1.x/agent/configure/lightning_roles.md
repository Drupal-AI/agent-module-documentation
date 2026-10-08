# Configure — Lightning Roles

## Content-role templates (`lightning_roles.settings`)
Templates live under the `content_roles` key. Each entry:
```yaml
content_roles:
  creator:                 # role key
    enabled: true          # deploy this template to node types?
    label: '? creator'     # ? -> node type label
    permissions:           # ? -> node type id
      - 'create ? content'
      - 'edit own ? content'
      - 'view ? revisions'
      - 'view own unpublished content'
      - 'create url aliases'
      - 'access in-place editing'
      - 'access contextual links'
      - 'access toolbar'
  reviewer:
    enabled: true
    label: '? reviewer'
    permissions:
      - 'access content overview'
      - 'edit any ? content'
      - 'delete any ? content'
```
Ships with `creator` and `reviewer` templates (above). Schema:
`lightning_roles.content_role` = `{enabled: bool, label: string, permissions: sequence}`.

## How roles are deployed
- On `hook_node_type_insert`, for every **enabled** template a `user_role` is created/loaded
  with id `{node_type_id}_{role_key}` (e.g. `article_creator`, `page_reviewer`),
  label = template label with `?` → node type label, and each permission with `?` →
  node type id. Only permissions that actually exist are granted (missing ones skipped).
- On `hook_node_type_delete`, the matching `{node_type}_{role_key}` roles are deleted.
- Config sync is skipped (no auto-deploy during import).
- Read a deployed role: `drush cget user.role.article_creator permissions`.

## Editing templates
UI: `/admin/config/system/lightning/roles` (`SettingsForm`, gated `_is_administrator`).
In code, edit `content_roles.*` on `lightning_roles.settings`. Adding a permission to a
template does not retroactively grant it to existing per-type roles unless you use the
internal `ContentRoleManager::grantPermissions($role_key, $permissions)`, which appends to
the template **and** back-fills the permission onto every existing per-type role
(`@internal` — may change without notice).
