# Configure Feeds Log

Logging can be switched on at three levels; the most specific wins.

1. **Global** — config `feeds_log.settings`, UI `/admin/config/content/feeds_log`
   (route `feeds_log.settings`). Keys:

| Key | Default | Meaning |
|---|---|---|
| `log_dir` | `private://feeds/logs` | Where source/item files are written. |
| `age_limit` | (int) | How long (seconds) to keep logged imports before pruning. |
| `stampede.max_amount` | (int) | Max logs allowed for one feed within the window. |
| `stampede.age` | (int) | Look-back window (seconds) for the stampede guard. |

2. **Per feed type** — third-party setting on the feed type,
   `feeds.feed_type.*.third_party.feeds_log.status` (toggled on the feed type edit form).

3. **Per feed** — individual feeds can override whether their imports are logged.

```bash
drush config:set feeds_log.settings age_limit 604800 -y
drush config:get feeds_log.settings
```

Reports are exposed through the `feeds_import_logs` View; each run is a `feeds_import_log`
content entity (`base_table feeds_import_log`). Access requires the `feeds_log.access`
permission plus the user's normal Feeds view access. Files are managed by the
`feeds_log.file_manager` service (`Drupal\feeds_log\LogFileManager`).

> Logs can grow fast on large/frequent imports — tune `age_limit` and the stampede guard.
