# Settings form & config object

- Route `event_log_track.settings_form` → `/admin/config/system/events-log-track`
  (form `Drupal\event_log_track\Form\EventsTrackForm`, form id `events_track_form`),
  required permission `administer site configuration`. Menu link under
  *Configuration → System*.
- Config object: `event_log_track.settings`.

| Config key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `enable_log_deletion` | bool | false | When on, `hook_cron` prunes rows older than `timespan_limit` days. |
| `timespan_limit` | int | 30 | Max age (days) of retained records. Required, min 1. |
| `batch_size` | int | 50 | Chunk size used by the deletion batch. Required, min 1. |
| `disable_db_logs` | bool | false | Skip the DB write in `insert()` (use with the syslog/stdout submodule to log only to an external backend). |
| `log_cli` | bool | false | Also record events triggered under CLI (Drush/console). Off by default. |
| `skip_patterns` | string | '' | One glob per line matched against `ref_char`; matching events are dropped. `*` is a wildcard, e.g. `system.*`. |

Set via drush:

```bash
drush cset event_log_track.settings enable_log_deletion true -y
drush cset event_log_track.settings timespan_limit 90 -y
drush cset event_log_track.settings disable_db_logs true -y   # external-backend-only logging
drush cset event_log_track.settings skip_patterns "system.*\ncore.*" -y
```

Or PHP:

```php
\Drupal::configFactory()->getEditable('event_log_track.settings')
  ->set('enable_log_deletion', TRUE)
  ->set('timespan_limit', 90)
  ->save();
```

Config schema is defined in `config/schema/event_log_track.schema.yml`. The `skip_patterns`
match is compiled in `EventLogTrackManager::shouldSkip()` (each line becomes
`/^<glob with * → .*>$/`). Pruning logic lives in
[api/logging.md](../api/logging.md); the syslog/stdout backends have their **own** config
objects documented in their submodule docs.
