<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Import — agent index

Bulk-creates or updates **nodes** from an uploaded **CSV**, one node per row, via an admin
form. Depends only on `node`. **No** Drush, **no** plugins, **no** real config of its own.

- **The import form: route, permission, import types, mandatory columns, running it, log/sample** →
  [configure/import.md](configure/import.md)
- **CSV column → field-type value formats (images, taxonomy/user/node refs, dates, geo, …)** →
  [api/csv-format.md](api/csv-format.md)

Key facts:
- Form/route `contentimport.admin_settings` at `/admin/config/content/contentimport`; permission
  is core **`administer site configuration`**.
- CSV first row = destination **field machine names**. Every CSV needs **`title`** and
  **`langcode`** (defaults to `en`); **Update** mode also needs a **`nodeid`** column.
- Import runs a batch calling `contentimport_import_node($file, $content_type, $import_type)`
  (`import_type`: `1` = create, `2` = update). Log at
  `sites/default/files/contentimportlog.txt`; needs write access to `sites/default/files/`.
