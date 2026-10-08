# Export / import services (programmatic)

Two static helper classes (no service container entry — call statically).

## Export

```php
use Drupal\node_export\NodeExport;

// Return JSON string for all nodes:
$json = NodeExport::export([], 'json', FALSE);

// Return JSON for specific nids:
$json = NodeExport::export([1, 2, 3], 'json', FALSE);

// Write to a file (default file scheme) and get the File entity back:
$file = NodeExport::export([1, 2, 3], 'json', TRUE);
$path = \Drupal::service('file_system')->realpath($file->getFileUri());
```

`export(array $ids, string $format, bool $save)`:
- `$ids` empty ⇒ all nodes (`Node::loadMultiple()`), else those nids.
- `$format` — only `json` is implemented; `dsv`/`serialize`/`xml` are stubs that yield no data.
- `$save` FALSE ⇒ returns the JSON string; TRUE ⇒ writes a `node_export_*.json` file (unique name)
  and returns the `File` entity.

## JSON shape

An array of node objects, each an associative array of `field_name => field_value_array` exactly as
`$node->get($key)->getValue()` returns (so e.g. `title => [['value' => '...']]`,
`type => [['target_id' => 'article']]`).

## Import

```php
use Drupal\node_export\NodeImport;

$data  = json_decode(file_get_contents('/path/nodes.json'), TRUE);
foreach ($data as $nodeArray) {
  $id = NodeImport::import($nodeArray);   // int nid on success, FALSE if not importable
}
```

`import(array $nodeArray)`:
- Reads the target content type from `type[0].target_id`; returns FALSE if that content type does
  not exist on this site or the export contains a field the bundle lacks.
- Drops `nid`, `vid`, `uuid`, then applies `node_export.settings:node_export_import`:
  - `replace` — load the node by its original id and save a **new revision** (falls back to create
    if missing).
  - `new` — always `Node::create()`.
  - `skip` — if a node with that id exists, return it unchanged; otherwise create.
- Saves and returns the resulting node id.
