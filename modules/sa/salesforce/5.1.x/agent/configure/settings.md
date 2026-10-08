# Suite settings — `salesforce.settings`

Admin section at `/admin/config/salesforce` (route `salesforce.admin_config_salesforce`,
permission `administer salesforce`). The suite-wide config object is `salesforce.settings`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `global_push_limit` | integer | `100000` | Max records processed per push queue run (0 = no limit). |
| `pull_max_queue_size` | integer | `100000` | Max items enqueued for pull at once (0 = no limit). |
| `standalone` | boolean | `false` | Use a standalone queue-processing endpoint and skip cron push processing. |
| `show_all_objects` | boolean | `false` | Show all Salesforce objects (incl. system/read-only) in the mapping UI. |
| `use_latest` | boolean | `true` | Always use the newest REST API version. |
| `limit_mapped_object_revisions` | integer | `10` | Max revisions kept per mapped object (0 = no limit). |
| `salesforce_auth_provider` | string | `''` | Default `salesforce_auth` config entity id used for API auth. |
| `short_term_cache_lifetime` | integer | `3600` | Seconds to cache object lists/descriptions/record types. |
| `long_term_cache_lifetime` | integer | `604800` | Seconds to cache API versions. |
| `rest_api_version` | mapping | `{version: '52.0', ...}` | Pinned REST API version (used when `use_latest` is false). |

```bash
drush cget salesforce.settings
drush cset salesforce.settings global_push_limit 5000 -y
drush cset salesforce.settings standalone 1 -y
drush cset salesforce.settings salesforce_auth_provider my_auth -y
```
Or in PHP:
```php
\Drupal::configFactory()->getEditable('salesforce.settings')
  ->set('use_latest', FALSE)
  ->set('rest_api_version', ['label' => '', 'url' => '', 'version' => '58.0'])
  ->save();
```

## Permissions

- `administer salesforce` — manage settings, authorizations, mappings admin.
- `authorize salesforce` — access OAuth consumer key/secret and identity info.

## Notes

- `salesforce_auth_provider` points at a `salesforce_auth` config entity
  (see `plugins/auth-providers.md`).
- `standalone` is also honoured by `salesforce_pull`/`salesforce_push` for queue processing.
- These settings are all local config — changing them needs no Salesforce connection, but
  actual API calls do.
