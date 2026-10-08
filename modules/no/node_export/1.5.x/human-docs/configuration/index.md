# Configuration

Node Export's settings form is short — it holds just the import‑conflict
strategy and the export format. Most of the module's "configuration" is really
about granting the right permissions and knowing which export/import pages to
use, all of which are covered below.

## Open the settings form

1. Log in as a user with the **Administer Node Export** permission
   (`node_export.administer`).
2. Go to **Configuration → Content authoring → Node Export**, or navigate directly
   to `/admin/config/content/node_export`.

## When importing a node that already exists

This is the important setting. When you import JSON and a node with the same ID
already exists on the destination, this radio choice decides what happens:

- **Replace** *(default)* — load the existing node and save a **new revision** of
  it with the imported values. If no such node exists, it's created. Use this when
  you're pushing content updates from one environment to another and want a clean
  revision history.
- **New** — always create a **brand‑new** node, ignoring any existing one. Use
  this when you're duplicating content rather than updating it.
- **Skip** — if a node with that ID already exists, leave it untouched;
  otherwise create it. Use this to import only content the destination doesn't
  already have.

## Format

A single option, currently fixed to **JSON** — the only format Node Export
implements. There's nothing to change here in this version.

Click **Save configuration** to store your choices. The import behavior applies
everywhere afterward, including the Drush `node-export-import` command.

## Permissions

Node Export defines three permissions, all marked as restricted access — grant
them deliberately at **People → Permissions** (`/admin/people/permissions`):

| Permission | Machine name | What it allows |
|-----------|--------------|----------------|
| **Export nodes** | `node_export.export_node` | Access to all the export pages and the per‑node Export tab. |
| **Import nodes** | `node_export.import_node` | Access to the import forms (paste and file upload). |
| **Administer Node Export** | `node_export.administer` | Access to the settings form above. |

Because these control moving content in and out of your site, keep them limited to
trusted administrator or content‑staging roles.

## Export and import pages at a glance

Once permissions are granted, these are the pages you'll use:

| Page | Path | What it does |
|------|------|--------------|
| Per‑node export | `/node/{id}/export` | Export a single node |
| Export by content type | `/admin/content/export/contenttype` | Export every node of a chosen type |
| Export by node IDs | `/admin/content/export/nids` | Export a specific list of node IDs |
| Bulk export | `/admin/bulk-export` | Used by the **Node Export** action on the content listing |
| Import (paste) | `/admin/content/import` | Import JSON pasted into a textarea |
| Import (file) | `/admin/content/import/file` | Import an uploaded JSON file |

Remember: imports only work when the destination site already has the same
content types (and ideally the same fields) as the source. Set those up first,
then transfer the content.
