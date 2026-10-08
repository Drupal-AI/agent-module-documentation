# Settings: remote-CSV cache duration

The module's only global setting is how long a **remote** CSV response is cached. Local files
(`entity:`/`internal:`) are read fresh every time and are not affected.

- Route: `views_csv_source.settings` → `/admin/config/user-interface/views-csv-source-settings`
  (menu link `views_csv_source.admin` under System → Configuration → User interface).
- Access: `_permission: 'administer site configuration'`.
- Form: `ViewsCsvSourceSettingsForm` (`ConfigFormBase`), form id `views_csv_source_configuration`.
- Config object: `views_csv_source.settings`, schema `config/schema/views_csv_source.schema.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `cache_ttl` | integer (seconds) | `86400` | How long a fetched remote CSV is kept in `cache.default` under `views_csv_source_<md5(uri)>`. `0` disables caching (use for large or fast-changing remote files). |

The value is read in `Connection::fetchContent()`: on a `0` TTL the fetched body is returned
without being written to cache; otherwise it is cached until `request_time + cache_ttl`.

## Set it with Drush / PHP

```bash
drush config:set views_csv_source.settings cache_ttl 0 -y
```

```php
\Drupal::configFactory()
  ->getEditable('views_csv_source.settings')
  ->set('cache_ttl', 3600)
  ->save();
```

`config/install/views_csv_source.settings.yml` ships `cache_ttl: 86400`.
