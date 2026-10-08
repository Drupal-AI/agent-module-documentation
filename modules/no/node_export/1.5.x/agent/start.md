# Node Export — agent index

Exports nodes to **JSON** and imports them back (same site or another install). Config in
`node_export.settings`; UI forms plus Drush and a node action. Depends only on core node/json.

- **Settings (import strategy + format), the routes, and the three permissions** →
  [configure/settings.md](configure/settings.md)
- **Drush commands `ne-export` / `ne-import`** → [drush/commands.md](drush/commands.md)
- **The `NodeExport::export` / `NodeImport::import` services and the JSON shape** →
  [api/export-import.md](api/export-import.md)

Key facts:
- Config `node_export.settings`: `node_export_import` (`replace` = new revision of existing node
  [default], `new` = always create, `skip` = leave existing), `node_export_format` (`JSON`).
- Configure route `node_export.config` → `/admin/config/content/node_export`.
- Permissions: `node_export.export_node`, `node_export.import_node`, `node_export.administer`.
- Drush: `node-export-export` (alias `ne-export`), `node-export-import` (alias `ne-import`).
- Node action `bulk_node_export` ("Node Export") for the content listing. Only JSON is implemented.
