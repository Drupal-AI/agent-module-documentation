<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# fancy_file_delete — agent start

Admin housekeeping tool to delete files core cannot easily clear: **managed** files by
FID, **orphaned** managed files (referenced only by a `node` that no longer exists), and
**unmanaged** files on disk that were never in `file_managed`. Normal delete uses
`File::delete()` (refuses if still referenced); a **force** delete drops the `file_managed`
+ `file_usage` rows and the entity directly. All work funnels through the
`fancy_file_delete.batch` service. Depends on `views_bulk_operations`, `views`, `block`.

Admin UI: **Admin → Config → Content → Fancy File Delete**
(`/admin/config/content/fancy_file_delete`, route `fancy_file_delete.info`).

- **Admin UI, views, Manual form, force vs normal delete** → [configure/setup.md](configure/setup.md)
- **Drush `fancy:file-delete` / `ffd` (delete by FID, `--force`)** → [drush/commands.md](drush/commands.md)
- **Batch service, VBO actions, orphan/unmanaged query logic** → [api/services.md](api/services.md)
- **Permissions gating the pages and the unmanaged-files entity** → [permissions/permissions.md](permissions/permissions.md)
