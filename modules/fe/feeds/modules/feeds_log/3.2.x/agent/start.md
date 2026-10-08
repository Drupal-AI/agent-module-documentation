# feeds_log — agent start

Submodule of **feeds**. Records detailed per-item import reports by subscribing to Feeds'
`REPORT`/stage events and writing `feeds_import_log` content entities plus source/item files on
disk (default `private://feeds/logs/<id>/`). Depends on `views` + `feeds`.

- **View reports:** Views-driven report `feeds_import_logs` at `/admin/content/feed`; per-run
  detail via `feeds_import_log` entity (`Drupal\feeds_log\Entity\ImportLog`).
- **Enable & configure logging** (global / per feed type / per feed) + settings keys
  (`log_dir`, `age_limit`, stampede guard) → [configure/settings.md](configure/settings.md)
- **Permission:** `feeds_log.access` — view Feeds logs the user already has view access for.
- **Storage:** fetched source + each processed item written as files by
  `feeds_log.file_manager` (`LogFileManager`); messages stored on the log entity.
