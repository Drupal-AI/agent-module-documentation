<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Export CSV — agent index

Downloads nodes of a chosen content type as a CSV file. One admin form + one service. No
config entity, no schema, no plugins, no Drush, no hooks. Only permission: `access content
export` (restricted).

- **The export form: route, path, permission, options** →
  [configure/export-form.md](configure/export-form.md)
- **Programmatic export: the `content_export_csv.export` service and its methods** →
  [api/export-service.md](api/export-service.md)

Key facts:
- Form route `content_export_csv.export` at **/admin/content/content-export** (action link
  "Export Content" on `/admin/content`). Permission `access content export`.
- Service id `content_export_csv.export` → class `Drupal\content_export_csv\ContentExport`.
  Main method: `getNodeCsvData($type, $status, $fields, $includeUrls, $stripTags)`.
- Gotcha: info.yml `configure` points at `content_export_csv.data-export`, a route that does
  **not exist**; the working form route is `content_export_csv.export`.
