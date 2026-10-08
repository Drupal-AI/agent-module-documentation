# How Configuration Log works (mechanism)

Three event subscribers (services in `config_log.services.yml`), all extending
`ConfigLogSubscriberBase`, listen on core config events. There is **no plugin manager and no
public API service** — you extend it by registering another subscriber (see
`extend/custom-destination.md`).

## The three subscribers / destinations

| Service id | Class | `$type` | Destination |
|---|---|---|---|
| `config_log_database_subscriber` | `ConfigLogDatabaseSubscriber` | `custom` | Row in the `config_log` DB table |
| `config_log_psr_subscriber` | `ConfigLogPsrSubscriber` | `default` | `logger.channel.default` (watchdog/dblog) |
| `config_log_mail_subscriber` | `ConfigLogMailSubscriber` | `mail` | Email via `plugin.manager.mail` |

Each listens on `ConfigEvents::SAVE`, `DELETE`, `RENAME` (DB only), `IMPORT`, and
`IMPORT_VALIDATE` (to detect imports). A destination acts only if `isEnabled()` (its key is
active in `log_destination`) and the config name is not filtered by `isIgnored()`.

## The `config_log` table (destination `custom`)

Defined in `config_log.install` (`hook_schema`). Columns:

| Column | Notes |
|---|---|
| `clid` | serial primary key |
| `uid` | acting user id (import rows use `1`) |
| `operation` | `create` / `update` / `rename` / `delete` (import uses the changelist op) |
| `data` | YAML of the new config data (redacted) |
| `originaldata` | YAML of the original config data (redacted) |
| `name` | config object name |
| `old_name` | previous name for `rename` |
| `created` | unix timestamp |

`data`/`originaldata` are dumped with `Symfony\Component\Yaml\Dumper(2)` at
`PHP_INT_MAX` inline level, so they diff cleanly line-by-line (the Views submodule uses this).

## Secret redaction

`ConfigLogSubscriberBase::redactSensitiveValues()` walks the data recursively before encoding.
A leaf is redacted to `[redacted]` when its dotted `config_name.key.path` (lower-cased, `-`/`_`
normalised to `.`) either contains a sensitive **phrase** (`api.key`, `access.key`,
`secret.key`, `private.key`, `client.secret`, `refresh.token`, `access.token`, `smtp.password`,
…) or has a path **segment** exactly equal to one of `apikey`, `key`, `password`, `pass`,
`passwd`, `pwd`, `secret`, `token`, `credential(s)`, `authorization`, `bearer`. Only the matching
leaf is redacted; sibling values stay visible. Controlled by `redact_sensitive_config_values`
(missing/`!== FALSE` ⇒ enabled, so the secure default survives upgrades).

## No-op and import handling

- `ignore_no_changes`: `isChanged()` encodes original vs current YAML and skips equal saves.
- `ignore_config_import`: `IMPORT_VALIDATE` sets a flag so SAVE/DELETE fired *during* an import
  are skipped; the IMPORT event itself is also skipped when this is on. Import rows otherwise
  record one entry per config name in `$event->getChangelist()`.

## Retention (cron)

`config_log_cron()` reads `logs_to_keep`; if `> 0` it finds the `clid` of the Nth newest row and
deletes everything older in 5000-row batches, logging each batch. `0` keeps everything.
