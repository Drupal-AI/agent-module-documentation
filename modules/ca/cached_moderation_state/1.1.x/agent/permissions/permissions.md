# Cached moderation state — permission

One permission, defined in `cached_moderation_state.permissions.yml`:

- **`access cached_moderation_state update_form`** — grants access to the batch update form at
  `/admin/cached-moderation-state/update` (route `cached_moderation_state.batch_update_form`), used
  to back-fill the cached field on existing moderated content. Restricted to trusted admins.

```bash
drush role:perm:add content_admin 'access cached_moderation_state update_form'
```

Note: the `cached_moderation_state` field itself has **no** per-field permission — its access is
hard-forbidden in the UI by `hook_entity_field_access` (it is read programmatically / in Views
only). The Drush commands run with the CLI user's privileges and are not gated by this permission.
