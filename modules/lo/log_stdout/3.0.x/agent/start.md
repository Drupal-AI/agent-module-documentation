# Log Stdout — agent index

Registers a PSR logger (`logger.stdout`) tagged `{ name: logger }` that writes every Drupal
Logging API event to `php://stdout` (or `php://stderr` for WARNING+ when enabled). No plugins,
no Drush, no permissions of its own (the settings form uses core `administer site configuration`).
All state is the `log_stdout.settings` config object: `format`, `use_stderr`, `severity_level`.

- **Configure format / stderr / minimum severity, config keys, config route** →
  [configure/settings.md](configure/settings.md)
- **How the logger service works (tag, severity gate, placeholders, stream selection)** →
  [api/logger.md](api/logger.md)

Key facts:
- Config route: `log_stdout.settings` → `/admin/config/development/log_stdout`.
- `severity_level` is an RFC5424 integer 0–7 (0=Emergency … 7=Debug); an event logs only when its
  level is `<= severity_level`. Default `3` (Error).
- `use_stderr: '1'` sends level `<= WARNING` (i.e. 0–4) to `php://stderr`, everything else to stdout.
- Schema quirk: the schema file mislabels the object as `syslog.settings`, so `log_stdout.settings`
  has no active schema — read/write the three keys directly.
