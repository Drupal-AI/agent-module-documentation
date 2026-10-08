# Rollbar — agent index

Sends Drupal server-side log messages (via a PSR `logger` channel) and browser JS errors (via the
Rollbar JS snippet) to the Rollbar service. One settings form at `/admin/config/services/rollbar`
(route `rollbar.settings`). Bundles the `rollbar/rollbar` PHP SDK. Provides config schema + one
permission; no Drush, no plugin types.

- **All settings keys, the two tokens, log-level/channel filtering, scrub fields, person tracking, host allow-list** → [configure/settings.md](configure/settings.md)
- **How the logger channel + JS attachment work, and `hook_rollbar_settings_alter`** → [extend/logger.md](extend/logger.md)

Key facts:
- Config object `rollbar.settings`; master switch `enabled` (default false), `environment` (default `production`).
- Server: `logger.rollbar` service tagged `logger`; only levels in `log_level` are forwarded and only when `enabled` + token + environment are set.
- Client: `rollbar_page_attachments_alter` attaches library `rollbar/global` + `drupalSettings.rollbar` (uses `access_token_frontend`).
- Permission: `administer rollbar`. Default JS URL is a Rollbar CDN build (`rollbar_js_url`).
