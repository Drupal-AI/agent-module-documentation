# Configure Rollbar

Form `RollbarSettingsForm` at `/admin/config/services/rollbar` (route `rollbar.settings`,
permission `administer rollbar`). Writes config object `rollbar.settings`.

## Settings keys (defaults from `config/install/rollbar.settings.yml`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | bool | `false` | Master switch for both server and client reporting. |
| `access_token` | string | `null` | **Server** token (Rollbar `post_server_item` scope). |
| `access_token_frontend` | string | `null` | **Client** token (`post_client_item`); emitted to the browser. |
| `capture_uncaught` | bool | `true` | JS: report uncaught errors. |
| `capture_unhandled_rejections` | bool | `false` | JS: report unhandled promise rejections. |
| `environment` | string | `production` | Environment label on every report (required server-side to init). |
| `log_level` | sequence | `[]` | Which RFC levels are forwarded server-side (indexes 0–7 = Emergency…Debug). |
| `channels` | string | `''` | `;`-separated logger channels to **exclude**. |
| `rollbar_js_url` | string | Rollbar CDN v2.26.3 | URL of the Rollbar JS library. |
| `host_white_list` | string | `''` | Comma-separated hosts; client reports only for these (`hostSafeList`). |
| `person_tracking` | string | `off` | `off` / `id` / `on` (Full = id+username+email). |
| `ignored_headers` | sequence | `[]` | `Header: value` lines; a match disables reporting for that request. |
| `ignored_messages` | sequence | `[]` | Client-side messages to ignore. |
| `scrub_fields` | sequence | passwd, password, secret, confirm_password, password_confirmation, auth_token, csrf_token | Field names replaced with `*` in payloads. |

## Notes

- **Nothing is sent until `enabled` is true.** Server init (`RollbarLogger::init`) additionally
  requires a non-empty `access_token` and `environment`; otherwise the logger silently no-ops.
- `log_level` is a checkbox set — an **empty** list means no server messages are forwarded even
  when enabled. Select the severities you want.
- `person_tracking = on` attaches the authenticated user's **email and username** to reports; the
  form labels this a GDPR consideration. Use `id` to send only the user ID.
- The two tokens are stored as plain config values; override per-environment via
  `settings.php` (`$config['rollbar.settings']['access_token'] = getenv(...)`) as usual.

## Set it with Drush

```php
// drush php:eval
\Drupal::configFactory()->getEditable('rollbar.settings')
  ->set('enabled', TRUE)
  ->set('access_token', getenv('ROLLBAR_SERVER_TOKEN'))
  ->set('access_token_frontend', getenv('ROLLBAR_CLIENT_TOKEN'))
  ->set('environment', 'production')
  ->set('log_level', [0, 1, 2, 3])   // Emergency, Alert, Critical, Error
  ->save();
```
