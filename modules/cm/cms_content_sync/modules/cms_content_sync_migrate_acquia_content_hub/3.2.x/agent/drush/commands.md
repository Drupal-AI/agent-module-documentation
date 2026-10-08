# Drush command

Defined the legacy way in `cms_content_sync_migrate_acquia_content_hub.drush.inc`
(`hook_drush_command()`), not as a Drush service class.

| Command | Alias | Purpose |
|---|---|---|
| `content_sync_migrate_acquia_content_hub` | `mach` | Migrate configuration from Acquia Content Hub to Content Sync (creates the `content` Pool, a Flow, and the `EntityStatus` records — the headless equivalent of the migration forms). |

## Options

| Option | Required | Allowed / meaning |
|---|---|---|
| `--type` | yes | `push` or `pull`. |
| `--backend_url` | yes | The Sync Core URL for the generated Pool. |
| `--authentication_type` | yes | `basic_auth` or `cookie` (only `cookie` is allowed when the `basic_auth` module is not enabled). |
| `--site_id` | no | Site identifier; if omitted, falls back to Acquia's `acquia_contenthub.admin_settings:client_name`. |
| `--node_push_behavior` | for push | `automatically` or `manually`. |
| `--pull_updates_behavior` | for pull | e.g. `force_and_forbid_editing`, `allow_override`, `force`, `ignore`. |
| `--sync` | no | JSON to override individual per-type/bundle options. |
| `--force_update` | no | Overwrite existing Flow configuration if it already exists. |

## Examples (from the command's own help)

```bash
# Create a pushing configuration
drush mach --type="push" --vocabulary="sites" \
  --backend_url="http://user:pass@drupal-content-sync:8691/rest" \
  --authentication_type="basic_auth" --site_id="example-exporter" \
  --node_push_behavior="automatically"

# Create a pulling configuration (iterates all contenthub_filter entities)
drush mach --type="pull" --vocabulary="sites" \
  --backend_url="http://user:pass@drupal-content-sync:8691/rest" \
  --authentication_type="basic_auth" --site_id="example-importer" \
  --pull_updates_behavior="force_and_forbid_editing"
```

For `pull`, the command loads every `contenthub_filter` entity and creates a Flow per filter, then
runs a batch to create the status entities. It validates `--type`, `--authentication_type`,
`--site_id`, and the behavior options before doing anything.
