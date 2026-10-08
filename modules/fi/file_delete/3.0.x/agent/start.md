# file_delete — agent start

Adds usage-aware deletion of managed `file` entities to the Drupal admin UI. It replaces
core's file delete form (via `hook_entity_type_build()` setting the `file` entity's `delete`
form class to `FileDeleteForm`) so deleting a file marks it `Temporary` for `file_cron()`
cleanup, and — with the right permissions — can delete immediately or override a usage check.
Also ships two bulk `file` action plugins. Depends only on core `file`. No config UI, no
Drush commands.

- Delete form, delete route, bulk action plugins → [configure/file_delete.md](configure/file_delete.md)
- Permissions (immediate / override-usage) → [permissions/file_delete.md](permissions/file_delete.md)
- Delete / mark a managed file in code → [api/file_delete.md](api/file_delete.md)
