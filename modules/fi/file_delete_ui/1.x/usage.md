File delete (file_delete_ui) adds a working "Delete" operation for file entities to Drupal's admin Files listing, letting trusted admins delete managed files from the UI — something core does not allow out of the box.

---

Core Drupal has no UI route for deleting a `file` entity, so the admin Files view (`/admin/content/files`) offers no delete link. This module fills that gap entirely through hooks and a permission — it has no settings form or configuration. `hook_entity_type_alter()` augments the `file` entity type: it sets a generic `EntityListBuilder`, adds a `delete-form` link template at `/file/{file}/delete`, registers a delete form class (`FileEntityDeleteForm`, a thin `ContentEntityDeleteForm` subclass), and overrides the file access control handler with `FileAccessControlHandler`. The routing file exposes `entity.file.delete_form` guarded by `_entity_access: file.delete`. The overridden access handler grants `delete` access when the account has the module's `delete any file` permission (a `restrict access: true` permission) or owns the file. On install, `hook_install()` edits the core `views.view.files` configuration to add an Operations field, so the Delete link appears in the Files listing. The module deliberately trusts the admin: it will delete a file even when its usage count is non-zero, and core then cleans up references from other entities. There are no plugins, Drush commands, config schema, or config entities.

---

- Give administrators a Delete link in the `/admin/content/files` Files listing.
- Delete an orphaned managed file that core leaves undeletable through the UI.
- Remove a file that is still referenced (non-zero usage) when you deliberately want it gone.
- Grant a specific role permission to delete any file via the `delete any file` permission.
- Let users delete files they own without granting the site-wide `delete any file` permission.
- Clean up test or junk uploads from the file admin screen without writing code or using Drush.
- Provide a delete confirmation form at `/file/{file}/delete` for any file entity.
- Add a delete operation to file-listing Views because the file entity now has a `delete-form` link template.
- Bulk-manage files by deleting them one by one from the standard operations dropdown.
- Remove a file whose physical copy you already deleted, tidying the `file_managed` records.
- Purge leftover files after uninstalling a module that created them.
- Delete a stale private-file upload from the admin UI while keeping an audit-minded, permission-gated flow.
- Reclaim disk space by removing large unused files through the admin listing.
- Let a content team delete their own uploaded media source files (ownership-based access).
- Enforce restricted access to file deletion via a permission flagged `restrict access: true`.
- Delete a file referenced by a broken entity, relying on core to strip the dangling reference.
- Offer an editor a one-click delete instead of a Drush/DB operation for file cleanup.
- Wire the file `delete` operation into custom administrative dashboards or Views.
- Remove files uploaded during a migration dry-run from the UI.
- Provide file deletion capability on Drupal 8.8 through 11 sites without a heavier file-management module.
