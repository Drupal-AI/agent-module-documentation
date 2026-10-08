# Configuration

Search API Fast works with sensible defaults, so configuration is **optional
tuning** — mostly about matching the number of parallel workers to what your server
can handle. You can set these values either in the admin form or directly in
`settings.php`.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Search and metadata → Search API Fast**, or navigate
   directly to `/admin/config/search/search-api-fast`.

## Settings in `settings.php`

The same options can be set as configuration overrides in `settings.php`:

```php
$config['search_api_fast.performance']['index_workers'] = 8;
$config['search_api_fast.performance']['worker_batch_size'] = 100;
$config['search_api_fast.performance']['max_batches_worker_respawn'] = 4;
$config['search_api_fast.performance']['drush'] = '/opt/mycooldrush/drush';
```

## The settings, explained

- **`index_workers`** — the number of workers that run simultaneously. This is the
  key setting. It **should not exceed the number of CPU cores available**, and in
  practice the safe ceiling is often lower, because workers also compete for
  database connections and search-backend throughput. Setting it too high can turn
  a slow reindex into an outage — the database connection limit is usually the
  first thing you hit. When in doubt, start conservative and test on a copy of
  production.

- **`worker_batch_size`** — how many items each worker indexes per batch. Larger
  batches mean fewer round-trips but more memory per worker; smaller batches are
  gentler on memory.

- **`max_batches_worker_respawn`** — how many batches a worker processes before it
  is respawned. Respawning periodically keeps memory usage in check on long runs.

- **`drush`** — the path to the Drush executable, in case it isn't on the default
  path (for example a custom or site-local Drush). Optional; leave it unset to use
  the Drush that the command was launched with.

## After changing settings

These options take effect the next time you run the indexing command
(`drush sapi-fast …`). Because worker count is an infrastructure decision rather
than a preference, re-test after any change to make sure the server comfortably
handles the load.
