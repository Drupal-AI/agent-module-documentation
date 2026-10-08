# Services, the `Filebrowser` object, and the metadata event API

## Key services (`filebrowser.services.yml`)

| Service | Class | Use |
|---|---|---|
| `filebrowser.manager` | `FilebrowserManager` | Build node form extra fields, `updateFilebrowser()`, `loadData()`, `createPresentation()` |
| `filebrowser.storage` | `Services\FilebrowserStorage` | Read/write the `filebrowser_nodes` and `filebrowser_content` tables (`loadNodeRecord($nid)`) |
| `filebrowser.common` | `Services\Common` | Permission constants, access helpers |
| `filebrowser.validator` | `Services\FilebrowserValidator` | Validate folder paths / uploads |
| `filebrowser.breadcrumb` | `Breadcrumb\BreadcrumbBuilder` | Folder breadcrumb (priority 1005) |

## The `Filebrowser` value object

`Drupal\filebrowser\Filebrowser` wraps one listing's settings. Construct it two ways:

- `new Filebrowser($nid)` (numeric) — loads the row via `filebrowser.storage` and unserializes
  `properties` onto public props (`folderPath`, `exploreSubdirs`, `downloadArchive`,
  `downloadManager`, `accepted`, `defaultView`, `visibleColumns`, ...).
- `new Filebrowser($settingsArray)` — builds from a node-form-shaped array (see
  [../configure/dir-listing-node.md](../configure/dir-listing-node.md)).

`hook_node_load()` attaches a hydrated instance as `$node->filebrowser` for every `dir_listing`
node.

## Metadata event API (add a column to the listing)

The listing's columns are extensible through two events dispatched while building a listing:

- **`filebrowser.metadata_info`** (`Events\MetadataInfo`) — subscribe and call
  `$event->setMetaDataInfo($data)` to declare a column: `$data['modified'] = ['title' =>
  t('Modified'), 'type' => 'integer'];`.
- **`filebrowser.metadata_event`** (`Events\MetadataEvent`) — subscribe to populate that
  column's value for each file.

Register subscribers in a module's `*.services.yml` with `tags: [{name: event_subscriber}]`.
The bundled **`filebrowser_extra`** submodule is a complete, minimal example that adds a
"Modified" (file mtime) column — see
[`modules/filebrowser_extra/3.1.x/agent/extend/metadata-column.md`](../../modules/filebrowser_extra/3.1.x/agent/extend/metadata-column.md).

## Other extension points

- `filebrowser_metadata_entity` — a config entity type (with its own permissions and admin
  form) for defining reusable custom metadata definitions.
- Remote storage: point `folder_path` at a Flysystem scheme (e.g. `s3://bucket/dir`) once the
  `flysystem` module and an adapter are installed and configured in `settings.php`.
