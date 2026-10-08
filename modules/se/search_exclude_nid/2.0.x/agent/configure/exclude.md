# Configure search exclusions

No config entity — the exclusion list is stored in Drupal **State**.

## Admin form
- Route `search_exclude_nid.form` → `/admin/config/search/search_exclude_nid`
  (menu under *Configuration → Search and metadata*), permission `administer search exclude nid`.
- Single textarea `excluded_nids`: comma-separated node IDs, e.g. `1,4,8,23`.
- On submit each value is `intval()`-cast, checked that a node with that ID exists and is not a duplicate;
  invalid/duplicate entries are dropped with a warning message. The clean int array is saved to State.

## Storage
```php
// Read / write the exclusion list programmatically:
$nids = \Drupal::state()->get('search_exclude_nid.excluded_nids'); // array of ints or NULL
\Drupal::state()->set('search_exclude_nid.excluded_nids', [12, 34, 56]);
```
Because it is State (not config), the list is per-environment and is **not** exported with configuration.

## How exclusion is applied
`search_exclude_nid.module` implements `hook_query_search_node_search_alter(AlterableInterface $query)`:
```php
$excluded_nids = \Drupal::state()->get('search_exclude_nid.excluded_nids');
if (!empty($excluded_nids)) {
  $query->condition('n.nid', $excluded_nids, 'NOT IN');
}
```
This only alters core Search's tagged `search_node_search` query. Search API, Views, and node access are
unaffected, and excluded nodes stay reachable by direct URL.

## `update_9001`
Migrates any legacy `search_exclude_nid.settings:excluded_nids` config value into State and deletes the old
config object.
