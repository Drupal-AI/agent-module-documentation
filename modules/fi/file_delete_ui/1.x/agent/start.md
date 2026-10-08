# File delete (file_delete_ui) — agent index

Adds a **Delete operation for `file` entities** to the admin Files listing — core has no
UI to delete files. Pure hooks + one permission; no settings form, no `configure` route,
no plugins, no Drush, no config schema.

- **How the delete op is wired (entity type alter, route, form, the Files-view field) and
  how to delete a file** → [configure/delete-operation.md](configure/delete-operation.md)
- **The `delete any file` permission and the ownership rule** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Delete route: `entity.file.delete_form` at `/file/{file}/delete` (confirm form
  `FileEntityDeleteForm`), guarded by `_entity_access: file.delete`.
- `hook_entity_type_alter()` adds the `delete-form` link template, the delete form class, an
  `EntityListBuilder`, and overrides the access handler with `FileAccessControlHandler`.
- Access = has `delete any file` **or** is the file's owner. It deletes files even with
  non-zero usage; core removes dangling references.
- `hook_install()` adds an Operations field to the core `views.view.files` view so the link
  shows at `/admin/content/files`.
