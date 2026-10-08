<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Search API Fast

All tuning lives in one simple config object, `search_api_fast.performance`. It ships with
`config/install/search_api_fast.performance.yml`, so these defaults exist after install:

| Key | Default | Type | Meaning |
| --- | --- | --- | --- |
| `index_workers` | `8` | int | Number of simultaneous background workers (one queue + one Drush process each). Keep at or below the host's CPU cores. |
| `worker_batch_size` | `100` | int | Items each worker claims and indexes per batch (per `indexSpecificItems` call). |
| `max_batches_worker_respawn` | `4` | int | Batches a worker handles before it respawns itself (bounds memory; avoids relying on the PHP GC). |
| `drush` | `'drush'` | string | Path to the Drush binary used to spawn workers. Overridden at runtime by the actual `$argv[0]` when the parent runs under Drush CLI. |

There is **no `config/schema`** for this object.

## Recommended: set via settings.php or drush

The reliable way to change these is a config override or a direct config write.

```php
// settings.php — override (read at runtime; not written to the active store).
$config['search_api_fast.performance']['index_workers'] = 8;
$config['search_api_fast.performance']['worker_batch_size'] = 100;
$config['search_api_fast.performance']['max_batches_worker_respawn'] = 4;
$config['search_api_fast.performance']['drush'] = '/opt/mydrush/drush';
```

```bash
# Or write the active config directly.
drush config:set search_api_fast.performance index_workers 8 -y
drush config:set search_api_fast.performance worker_batch_size 100 -y
drush config:set search_api_fast.performance max_batches_worker_respawn 4 -y
drush config:set search_api_fast.performance drush /opt/mydrush/drush -y
```

## Settings form

- Route: `search_api_fast.settings` → `/admin/config/search/search-api-fast`
- Permission: `administer site configuration` (core; the module defines no permissions of its own)
- Form class: `Drupal\search_api_fast\Form\SearchApiFastSettingsForm` (a `ConfigFormBase`)
- Fields exposed (number inputs): `index_workers` (min 0, max 10), `worker_batch_size`
  (min 0, max 150), `max_batches_worker_respawn` (min 0, max 10). The `drush` path is **not**
  editable through the UI — set it via config as above.

Note: the form's `submitForm()` only writes config when the submit op equals `Save configuration`,
while the button label is `Save settings`; prefer the settings.php / `drush config:set` methods
above when you need the change to take effect deterministically.

## How the config is consumed

- `search_api_fast_init()` (hook_init, in the `.module`) calls `SearchApiFastConfig::init()` on
  every request, populating the static properties `SearchApiFastConfig::$indexWorkers`,
  `$maxBatchesWorkerRespawn`, `$workerBatchSize`, `$drush`.
- The Drush command class `SearchApiFastCommands` reads the same four keys directly from
  `config.factory` in its constructor, so a CLI run always uses the current stored values.
