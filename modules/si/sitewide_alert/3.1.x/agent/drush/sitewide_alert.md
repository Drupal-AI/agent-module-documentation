<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sitewide Alert — Drush commands

Provided by `\Drupal\sitewide_alert\Drush\Commands\SitewideAlertCommands`
(backed by `CliCommands`). All operate on `sitewide_alert` content entities.

| Command | Purpose |
|---|---|
| `sitewide-alert:create "<label>" "<message>"` | Create a new alert. |
| `sitewide-alert:delete "<label>"` | Delete alert(s) whose name matches `<label>`. |
| `sitewide-alert:enable "<label>"` | Mark matching alert(s) active. |
| `sitewide-alert:disable ["<label>"]` | Disable all active alerts, or only those matching `<label>`. |

## create — options

```
drush sitewide-alert:create "<label>" "<message>" \
  [--style=<key>] [--start=<when>] [--end=<when>] [--no-active] [--dismissible]
```

- `<label>` (required) → the entity `name`; `<message>` (required) → the `message`.
- `--style` — a style key from `sitewide_alert.settings:alert_styles`; unknown
  values fall back to `primary` (see `CliCommands::normalizeStyle`).
- `--start` / `--end` — any `strtotime()`-parsable value (ISO datetime, `13:45`,
  `"tomorrow 13:45"`, `"2 hours 30 minutes"`, `"15 minutes"`). Supplying either
  turns the alert into a scheduled alert (`scheduled_alert = TRUE`); if only
  `--end` is given, start defaults to now.
- Active by default; pass `--no-active` to create it inactive.
- `--dismissible` — make it visitor-dismissible.

> Note: the docblock mentions a `--severity` alias, but the effective option that
> maps to the entity `style` field is `--style`.

Examples:

```bash
drush sitewide-alert:create "Outage" "We are investigating an outage." --style=danger
drush sitewide-alert:create "Sale" "50% off today" --start="today 09:00" --end="today 17:00"
drush sitewide-alert:create "Staged" "Coming soon" --no-active
drush sitewide-alert:disable            # kill all active alerts instantly
drush sitewide-alert:enable "Staged"    # activate the pre-staged one
drush sitewide-alert:delete "Outage"
```
