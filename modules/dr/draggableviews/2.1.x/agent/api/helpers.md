# Helper class, storage table & migrate destination

## `draggableviews_structure` table
Stores the manual order. Columns: `dvid` (PK), `view_name`, `view_display`, `args`
(JSON-encoded contextual args, defaults `[]`), `entity_id`, `weight` (signed int), `parent`.
A row's identity for a saved order is `view_name` + `view_display` + `args` + `entity_id`.

## `Drupal\draggableviews\DraggableViews` helper
Constructed with a `ViewExecutable`; used mainly from preprocess/theming code.

```php
$dv = new \Drupal\draggableviews\DraggableViews($view);
$dv->getIndex($id);      // result index for an entity id (mid for Media, else nid)
$dv->getDepth($index);   // nesting depth from parent chain (drives indentation)
$dv->getParent($index);  // parent entity id or 0
$dv->getAncestor($index);// topmost ancestor index
$dv->getValue($name, $i);// arbitrary result property by name
$dv->getHtmlId($index);  // stable table id: draggableviews-table-<view>-<display>-<index>
```

## Migrate destination plugin
`@MigrateDestination(id = "draggableviews")`
(`src/Plugin/migrate/destination/DraggableViews.php`) writes rows straight into
`draggableviews_structure`, letting a migration import a pre-existing manual order. Map the
`view_name`, `view_display`, `args`, `entity_id`, `weight` (and optional `parent`) fields.

## No public API service
There is no service to call; ordering is produced by the Views field form + the submit
handler `draggableviews_views_submit()`. To read an order back, use the
`Draggableviews: Weight` sort in a View rather than querying the table directly.
