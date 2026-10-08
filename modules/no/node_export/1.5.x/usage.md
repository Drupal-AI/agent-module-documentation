Node Export exports Drupal content nodes to JSON and imports that JSON back — on the same site or into another Drupal installation — so you can move or replicate content between environments.

---

Node Export serializes nodes to JSON (the only implemented format) via a `NodeExport::export($ids, 'json', $save)` service that either returns the JSON or writes it to a file in the default file scheme, and imports them with `NodeImport::import($nodeArray)`, which rebuilds each node and applies the configured "already exists" strategy. That strategy is stored in `node_export.settings:node_export_import` — `replace` (create a new revision of the existing node, the default), `new` (always create a new node), or `skip` (leave existing nodes untouched) — alongside `node_export_format` (currently `JSON`). The UI exposes several routes: per-node export at `/node/{node}/export`, imports at `/admin/content/import` and `/admin/content/import/file`, exports by content type (`/admin/content/export/contenttype`) or by node IDs (`/admin/content/export/nids`), a bulk export at `/admin/bulk-export`, and settings at `/admin/config/content/node_export` (route `node_export.config`). It also ships a VBO-style node action `bulk_node_export` and Drush commands `node-export-export` (alias `ne-export`) and `node-export-import` (alias `ne-import`). Three permissions gate it: `node_export.export_node`, `node_export.import_node`, and `node_export.administer`. Imports require the same content types (and ideally the same fields) to exist on the destination; UUID/nid are dropped so replace/skip decisions key on the node ID.

---

- Export a single node to JSON from its `/node/{nid}/export` page.
- Copy content from a staging site to production by exporting and re-importing JSON.
- Export every node of a given content type in one operation.
- Export a specific set of nodes by entering their node IDs.
- Bulk-export selected nodes using the "Node Export" action on the content admin listing.
- Import a JSON file of nodes through the admin import form.
- Seed a fresh site with sample content exported from another install.
- Migrate content to a new Drupal major version by exporting then importing.
- Choose to create a new revision of existing nodes on import (`replace`).
- Choose to always create brand-new nodes on import (`new`).
- Choose to skip nodes that already exist on import (`skip`).
- Script an export of all nodes with `drush node-export-export all`.
- Export specific nids from the CLI: `drush ne-export 1,2,3`.
- Save an export straight to a file with the drush `--save=y` option.
- Import nodes from a file on the CLI with `drush node-export-import /path/file.json`.
- Back up a subset of content as portable JSON.
- Move a handful of curated articles between client sites.
- Duplicate content into a development environment for testing.
- Keep content types in sync as a prerequisite, then transfer the content.
- Restrict who can export/import via the module's three permissions.
- Configure the default import-conflict behavior once in settings and reuse it everywhere.
- Produce JSON that external tooling can read (nodes as field-value arrays).
- Re-import edited JSON to update existing nodes as new revisions.
- Combine per-content-type export with a scripted import for repeatable content deployment.
