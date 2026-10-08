<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Porter (content_migration_porter) — agent index

**Admin JSON export/import of selected content entities with their references.**

- **Version:** 1.0.x  **Core:** ^10 || ^11  **Depends:** serialization
- **Machine name:** `content_porter` (project `content_migration_porter`).
- **Routes:** `/admin/content-export` (`ContentExportForm`) and `/admin/content-import` (`ContentImportForm`) — both `_permission: 'administer site configuration'`.
- **Service:** `content_porter` / `EntityExporter` (`exportEntities`) serializes entity + referenced paragraphs/media/files, adds each file's absolute `download_url`.
- **Import order:** paragraphs → taxonomy_term → file → media → node → block_content, then `fixEntityReferences()` re-maps refs by UUID.
- **Security:** admin-only (`administer site configuration`).

See [api/formats.md](api/formats.md).
