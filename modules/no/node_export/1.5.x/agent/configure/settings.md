# Configure Node Export

Settings form: route `node_export.config` → `/admin/config/content/node_export`
(permission `node_export.administer`). Config object `node_export.settings`:

| Key | Values | Meaning |
|---|---|---|
| `node_export_import` | `replace` (default), `new`, `skip` | What happens when an imported node already exists (matched by node ID). `replace` = save a **new revision** of the existing node; `new` = always **create** a new node; `skip` = leave the existing node untouched. |
| `node_export_format` | `JSON` | Export format. Only JSON is implemented (dsv/serialize/xml are stubs). |

```bash
drush cget node_export.settings
drush cset node_export.settings node_export_import skip -y
```

The form's "When importing a node that already exists" radios map to `node_export_import` (the form
value key is `node_export_existing`). "Format" maps to `node_export_format`.

## Routes (all under content admin)

| Route | Path | Purpose |
|---|---|---|
| `node_export.export` | `/node/{node}/export` | Export one node |
| `node_export.export_content_type` | `/admin/content/export/contenttype` | Export by content type |
| `node_export.export_nids` | `/admin/content/export/nids` | Export by node IDs |
| `node_export.bulk_export_form` | `/admin/bulk-export` | Bulk export (used by the action) |
| `node_export.import` | `/admin/content/import` | Import pasted JSON |
| `node_export.import_file` | `/admin/content/import/file` | Import a JSON file |
| `node_export.config` | `/admin/config/content/node_export` | Settings |

## Permissions (`node_export.permissions.yml`)

| Permission | Gates |
|---|---|
| `node_export.export_node` | Exporting nodes (all export routes) |
| `node_export.import_node` | Importing nodes |
| `node_export.administer` | The settings form |

All three are `restrict access: true`.

## Bulk action

Ships `system.action.bulk_node_export` (plugin `bulk_node_export`, id `bulk_node_export`,
label "Node Export", type `node`) — a node action available on the content admin listing that
stashes the selected node IDs and sends the user to the bulk export confirm form.
