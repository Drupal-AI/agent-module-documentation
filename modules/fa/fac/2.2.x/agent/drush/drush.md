# Drush commands

Provided by `\Drupal\fac\Commands\FacCommands` (`drush.services.yml`).

## `fac:cache-clear` (alias `fac:cc`)
Deletes the generated suggestion JSON files (`public://fac-json/<config>/…`) so they regenerate
with fresh content on the next request.

- `drush fac:cache-clear` — clears JSON for **all** `fac_config` entities.
- `drush fac:cache-clear --fac_config_ids=default,test` — clears only the named configurations.

Calls `FacConfig::deleteFiles()` (with no expiry, i.e. removes the whole per-config directory).
Equivalent to the "Delete json files" operation in the config list, and complements the
cron cleanup driven by each config's `cleanUpFiles` / `filesExpiryTime`.
