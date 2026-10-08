<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks — alters Acquia Search invites

From `acquia_search.api.php`. Implement in your `.module`.

## `hook_acquia_search_get_list_of_possible_cores_alter(array &$possible_core_ids, array $context)`

Add to / modify the list of candidate Solr core ids before the preferred core is chosen.
`$context` provides `ah_env` (string|null), `ah_db_role` (string), `identifier` (subscription
id, may be empty), and `sites_foldername` (string).

```php
function mymodule_acquia_search_get_list_of_possible_cores_alter(array &$possible_core_ids, array $context) {
  if (empty($context['ah_env'])) {
    $possible_core_ids[] = 'WXYZ-12345.dev.mysitedev_db';
  }
}
```

## `hook_acquia_search_should_enforce_read_only_alter(&$read_only)`

Force or lift read-only enforcement for the Acquia server. `$read_only` is a bool passed by
reference; set `TRUE` to force read-only, `FALSE` to allow writes.

```php
function mymodule_acquia_search_should_enforce_read_only_alter(&$read_only) {
  if (getenv('AH_SITE_ENVIRONMENT')) {
    $read_only = TRUE;
  }
}
```

## Search API hooks the module itself implements (for context)

- `hook_entity_operation_alter()` — removes the **delete** operation for `acquia_search_server`
  and `acquia_search_index` so the defaults can't be deleted in the UI.
- `hook_search_api_server_load()` — repairs the backend to `acquia_search_solr`, disables the
  server if the preferred core is unavailable, and flags read-only when enforced.
