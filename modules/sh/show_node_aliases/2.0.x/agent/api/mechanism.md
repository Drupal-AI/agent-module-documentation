# How it works (mechanism)

The entire module is `show_node_aliases.module`: one widget form alter, one help hook, and one
tiny DB helper. No services, plugins, config, or Drush.

## The form alter

`show_node_aliases_field_widget_single_element_path_form_alter(&$element, $form_state, $context)`
fires for the core **`path`** widget (the "URL alias" field on the node edit form). It:

1. Confirms the form object is a `NodeForm`, gets the node, and calls
   `show_node_aliases_get_paths('/node/' . $node->id())`.
2. If any aliases exist, builds an `#type => details` element titled **"Existing Aliases"**
   (`#open => TRUE`) containing a themed table.
3. Table header is **Alias, Language** — plus **Operations** when the current user has
   `administer url aliases`.
4. Each row: the alias string, its `langcode`, and (with the permission) an `#type => operations`
   cell with two links:
   - **Edit** → `internal:/admin/config/search/path/edit/<id>`
   - **Delete** → `internal:/admin/config/search/path/delete/<id>`
   both carrying `?destination=node/<nid>/edit`.

## The data source

```php
function show_node_aliases_get_paths($path) {
  return Database::getConnection()->select('path_alias')
    ->fields('path_alias')
    ->condition('path', $path)   // e.g. "/node/42"
    ->execute()->fetchAll();
}
```

So it reads directly from the **`path_alias`** table/entity (columns include `id`, `path`,
`alias`, `langcode`). To read a node's aliases programmatically, prefer the entity API:

```php
$aliases = \Drupal::entityTypeManager()->getStorage('path_alias')
  ->loadByProperties(['path' => '/node/' . $nid]);
```

## The help hook

`show_node_aliases_help()` returns the module's `README.txt` (rendered through the `markdown`
filter if that module is enabled, else `<pre>`).

## Consequences an agent should know

- It shows **all** aliases for the node, unlike core's Path field which only exposes one.
- Users **without** `administer url aliases` still see the alias list, but with **no** Edit/Delete
  operations column.
- The module changes nothing on save — alias create/edit/delete are core operations; this module
  only surfaces and deep-links to them.
- It targets **node** forms only (the `path` widget on a `NodeForm`).
