# Role grants and install-time behavior

The module defines the per-bundle document-media permissions in
`acquia_cms_document.permissions.yml` (see [permissions/permissions.md](../permissions/permissions.md))
and grants them to the Acquia CMS roles via an alter hook. It also runs one side effect on install.

## `acquia_cms_document_content_model_role_presave_alter(RoleInterface &$role)`

In `acquia_cms_document.module`. Implements `hook_content_model_role_presave_alter()` — an alter hook
**invoked by `acquia_cms_common`** while it builds/saves the distribution's roles. It grants:

| Role id | Permissions granted |
|---|---|
| `content_author` | `create document media`, `edit own document media`, `delete own document media` |
| `content_editor` | `edit any document media`, `delete any document media` |

The hook only fires within the `acquia_cms_common` role-presave flow, so on a non-Acquia-CMS site these
grants do not happen automatically — assign the permissions manually (see permissions doc). It matches
each role by `$role->id()` and calls `$role->grantPermission(...)`; other roles are untouched.

## `acquia_cms_document_install($is_syncing)`

In `acquia_cms_document.install` (implements `hook_install()`). When the module is installed **not**
during a config sync (`!$is_syncing`) it calls `_acquia_cms_common_editor_config_rewrite()` — an
`acquia_cms_common` helper that rewrites CKEditor/text-format config (so documents can be embedded via
the `embedded` view mode in text formats). During a config sync it does nothing.

There are no `hook_update_N` update hooks and no uninstall logic in this module.
