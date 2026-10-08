<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Mail Safety

All behavior is driven by the single config object **`mail_safety.settings`** (shipped defaults
in `config/install/mail_safety.settings.yml`). There are no field or entity settings.

## Config keys

| Key | Type | Default | Effect |
|---|---|---|---|
| `enabled` | boolean | `false` | Master switch. When TRUE, `hook_mail_alter()` sets `$message['send'] = FALSE` so no mail is delivered normally. |
| `send_mail_to_dashboard` | boolean | `false` | When TRUE, every caught mail is stored (serialized) in the `mail_safety_dashboard` table and shown on the dashboard. |
| `send_mail_to_default_mail` | boolean | `false` | When TRUE, the recipient is rewritten to `default_mail_address`, Cc/Bcc headers are removed, and `$message['send']` is set back to TRUE so that copy is delivered. |
| `default_mail_address` | string | `''` | The single address all mail is rerouted to when `send_mail_to_default_mail` is on. |
| `log_retention_period` | integer (seconds) | `''` | Dashboard rows older than this are deleted on cron. `0` / `''` = keep forever. Settings form offers 1 hour, 6 hours, 12 hours, 1 day, 1 week, 4 weeks, 3 months (`3600, 21600, 43200, 86400, 604800, 2419200, 7776000`). |

Important: mail is only intercepted when `enabled` is TRUE. If `enabled` is TRUE but **both**
destinations are FALSE, mail is silently dropped (stopped but neither stored nor rerouted).

## Routes & UI

- **Settings form** — route `mail_safety.settings`, path `/admin/config/development/mail_safety/settings`
  (this is the `configure` route). Class `\Drupal\mail_safety\Form\SettingsForm`.
- **Dashboard** — route `mail_safety.dashboard`, path `/admin/config/development/mail_safety`.
- Per-mail actions (all under the dashboard path, `{mail_safety}` = the `mail_id`):
  `view`, `view-body`, `details`, `send_original`, `send_default`, `delete`, and a global `clear`.

## Permissions

- `administer mail safety` — required for the settings form (restricted).
- `use mail safety dashboard` — required for the dashboard and every per-mail action (restricted).

## Reading / setting via drush

```bash
# Read the whole config object:
drush cget mail_safety.settings

# Turn on: stop mail + capture to dashboard:
drush cset mail_safety.settings enabled 1 -y
drush cset mail_safety.settings send_mail_to_dashboard 1 -y

# Reroute everything to one safe address instead:
drush cset mail_safety.settings send_mail_to_default_mail 1 -y
drush cset mail_safety.settings default_mail_address 'qa@example.com' -y

# Auto-purge dashboard rows older than one week (on cron):
drush cset mail_safety.settings log_retention_period 604800 -y
```

The config schema (`config/schema/mail_safety.schema.yml`) types all five keys, so values are
validated as part of `mail_safety.settings`.
