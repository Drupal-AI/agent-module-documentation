# Site Alert Drush commands

Defined in `src/Commands/SiteAlertCommands.php` (registered via `drush.services.yml`), delegating to
the `site_alert.cli_commands` service (`CliCommands`).

| Command | Args | Options | Purpose |
|---|---|---|---|
| `site-alert:create` | `<label> <message>` | `--start`, `--end`, `--severity`, `--active/--no-active` | Create an alert. |
| `site-alert:delete` | `<label>` | (confirm prompt) | Delete all alerts with that label. |
| `site-alert:enable` | `<label>` | | Activate inactive alert(s) with that label. |
| `site-alert:disable` | `[label]` | | Deactivate one alert by label, or **all** active alerts if label omitted. |

## create — details

- `--severity` = `low` | `medium` (default) | `high`; invalid values normalize to `medium`.
- `--active` defaults TRUE; pass `--no-active` to create it disabled.
- `--start` / `--end` accept ISO 8601 (`2022-10-15T15:00:00`) or human strings (`"tomorrow 13:45"`,
  `"+6 hours"`, `midnight`). They are parsed with `strtotime`/`DrupalDateTime` and stored in UTC
  (`DATETIME_STORAGE_FORMAT`); an unparseable date throws `InvalidArgumentException`.

Examples:

```bash
# Immediate, medium severity, stays until disabled/deleted
drush site-alert:create "maint" "We are performing maintenance."

# High severity, inactive until you enable it
drush site-alert:create "launch" "New feature is live!" --severity=high --no-active

# Scheduled window
drush site-alert:create "window" "Downtime 3–5pm" --start=2026-08-10T15:00:00 --end=2026-08-10T17:00:00

drush site-alert:enable "launch"
drush site-alert:disable            # disables ALL active alerts
drush site-alert:delete "maint"     # prompts for confirmation
```

Return codes follow Drush convention (0 success). `delete` reports how many matched; `enable`/`disable`
error when no matching alert is found (for a specific label).
