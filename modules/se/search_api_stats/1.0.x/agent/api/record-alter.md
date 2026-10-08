<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_search_api_stats_record_alter()

Before each row is inserted, `search_api_stats.module` calls:

```php
\Drupal::moduleHandler()->alter('search_api_stats_record', $fields);
```

so any module can implement **`hook_search_api_stats_record_alter(array &$fields)`** to
rewrite the row that is about to be written to the `search_api_stats` table.

`$fields` is the associative array passed straight to
`$database->insert('search_api_stats')->fields($fields)`, with these keys already set by the
module: `s_name`, `i_name`, `timestamp`, `uid`, `sid`, `keywords`, `numfound`, `filters`,
`sort`, `language`. (Columns `total_time`, `prepare_time`, `process_time`, `page`,
`showed_suggestions` are not populated by the module and default per the schema.)

## Typical uses

```php
/**
 * Implements hook_search_api_stats_record_alter().
 */
function MYMODULE_search_api_stats_record_alter(array &$fields) {
  // Do not log searches by admins.
  if (in_array('administrator', \Drupal::currentUser()->getRoles(), TRUE)) {
    $fields['keywords'] = '';   // an empty keyword row is still inserted here; to fully
                                // suppress logging, implement the results_alter hook earlier.
  }
  // Hash the session id for privacy.
  $fields['sid'] = hash('sha256', $fields['sid']);
  // Populate a reserved timing column.
  $fields['total_time'] = 0;
}
```

Only keys that correspond to real columns in the `search_api_stats` schema will persist -
adding an unknown key to `$fields` makes the `insert()` fail, so to store extra data you must
also add the column (e.g. via `hook_schema_alter()` / an update hook).

There is **no `search_api_stats.api.php`** in the project; this hook exists only as the
`->alter('search_api_stats_record', ...)` call in the module file.
