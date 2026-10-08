# Directory-listing nodes (`dir_listing`)

A file listing **is a node** of type `dir_listing` (created by the module in
`config/install/node.type.dir_listing.yml`). What makes it special is not a Field but an
extra fieldset added to the node form by `filebrowser_form_node_form_alter()` +
`filebrowser.manager::addFormExtraFields()`, whose values are packed into a `Filebrowser`
value object and saved to the **`filebrowser_nodes`** table by the `filebrowser.storage`
service. It is **not** stored in field config or the node's field data.

## Where per-node data lives

Table `filebrowser_nodes`: `nid`, `folder_path` (the exposed directory URI), `properties`
(a PHP-serialized blob of the rights/uploads/presentation settings), `external_host`.
The file listing itself is cached in `filebrowser_content` (one row per file).

## Create a listing programmatically

`hook_ENTITY_TYPE_insert()` reads `$node->filebrowser` (a `Drupal\filebrowser\Filebrowser`
object) and writes the storage row, so you must attach one before saving:

```php
use Drupal\node\Entity\Node;
use Drupal\filebrowser\Filebrowser;

$node = Node::create(['type' => 'dir_listing', 'title' => 'Team files']);
$node->filebrowser = new Filebrowser([
  'folder_path' => 'public://team',
  'rights' => [
    'explore_subdirs' => 1, 'download_archive' => 1, 'create_folders' => 0,
    'download_manager' => 'private', 'force_download' => 0,
    'forbidden_files' => '', 'whitelist' => '',
  ],
  'uploads' => ['enabled' => 1, 'allow_overwrite' => 0, 'accepted' => 'pdf txt'],
  'presentation' => [
    'overwrite_breadcrumb' => 1, 'default_view' => 'list-view', 'encoding' => 'UTF-8',
    'hide_extension' => 0, 'visible_columns' => ['name' => 'name'],
    'default_sort' => 'name', 'default_sort_order' => 'asc',
    'grid_settings' => ['alignment' => '', 'columns' => '', 'image_style' => '',
      'auto_width' => '', 'grid_height' => '', 'grid_width' => '', 'grid_hide_title' => ''],
  ],
  'adhocsetting' => ['external_host' => ''],
]);
$node->save();   // hook_node_insert() persists the folder to filebrowser_nodes
```

> Creating a `dir_listing` node with `Node::create()` **without** attaching `$node->filebrowser`
> will error in `hook_node_insert()` (it dereferences `$node->filebrowser->nid`).

## Read a listing's folder back

```php
$rec = \Drupal::service('filebrowser.storage')->loadNodeRecord($nid);
echo $rec['folder_path'];         // e.g. public://team
// or, hydrated onto the loaded node:
$node = \Drupal\node\Entity\Node::load($nid);   // hook_node_load attaches $node->filebrowser
echo $node->filebrowser->folderPath;
```

## Display

`filebrowser_entity_extra_field_info()` adds two pseudo-fields to the `dir_listing` view
display: `filebrowser_file_list` (the listing) and `filebrowser_statistics`. The full view
renders the folder contents via `filebrowser.manager::createPresentation()`.

## Known setup gap on this site

The shipped `field.field.node.dir_listing.body` instance is **missing** here, so `dir_listing`
nodes have no Body field at the moment. The `dir_listing` node type itself exists and works.
Do **not** repair core/other-module config to add it back — this is noted only so an agent
does not assume a Body field is present.
