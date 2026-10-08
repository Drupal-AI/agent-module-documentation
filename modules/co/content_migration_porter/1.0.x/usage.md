<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Porter exports selected content entities to a JSON file and re-imports them on
another site, carrying paragraphs, taxonomy terms, media and files along with the parent
nodes/blocks. (The module's machine name is `content_porter`; the project is
`content_migration_porter`.)

---

Two admin forms drive it: **Export Content** (`/admin/content-export`) uses `EntityExporter`
to serialize chosen entities plus their referenced paragraphs, media and files (recording each
file's absolute `download_url`), and **Import Content** (`/admin/content-import`) uploads that
JSON, validates that required bundles/fields/paragraphs/terms exist, then recreates
paragraphs → terms → files → media → nodes → block content in dependency order, re-wiring
entity references by UUID afterwards. Both routes require **"administer site configuration"**.

During import, files missing on the target are fetched from the URL embedded in the JSON. Typical use: move a
content tree (article + its paragraphs + images) from staging to production without a full
migration framework.

---

- Export selected nodes to a portable JSON file.
- Include a node's paragraphs in the export.
- Include referenced media and image files in the export.
- Export block content for Layout Builder reuse.
- Import a content JSON file into another site.
- Validate missing bundles/fields before importing.
- Abort import when dependencies are missing.
- Recreate paragraphs, terms, files, media, nodes in order.
- Re-link entity references by UUID after import.
- Download missing files from their recorded source URL.
- Move a content tree from staging to production.
- Mark imported block content reusable for Layout Builder.
- Duplicate structured content across environments.
- Seed a new site with sample content.
- Restrict export/import to site administrators.
