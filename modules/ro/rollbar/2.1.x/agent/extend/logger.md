# Rollbar internals & extension points

## Server-side logger channel

`logger.rollbar` (`Drupal\rollbar\Logger\RollbarLogger`, tagged `logger`,
args `@current_user @config.factory @logger.log_message_parser @request_stack`) implements
`Psr\Log\LoggerInterface` via `RfcLoggerTrait`. Every Drupal log call reaches `log()`:

1. `init()` returns false (no-op) unless `enabled` + `access_token` + `environment` are all set.
   On first use it calls `Rollbar::init()` with the token, environment, and `scrub_fields`.
2. Messages are dropped if the level isn't in `log_level`, or if `context['channel']` is in the
   `channels` exclude list.
3. `ignored_headers` — if a configured `Header: value` matches the current request, Rollbar is
   initialised with `enabled => FALSE` (that request won't report).
4. `person_tracking` adds `person_fn` (id, and username/email on Full for authenticated users).
5. The message placeholders are parsed and the level is mapped RFC→Rollbar, then `Rollbar::log()`.

There is **no plugin type** to implement — you tune behaviour through config, not code.

## Client-side attachment

`rollbar_page_attachments_alter()` (in `rollbar.module`) runs only when `enabled`. It builds a
`drupalSettings.rollbar` array (front-end token, capture flags, environment, JS URL, ignored
messages, scrub fields, optional `hostSafeList`, optional person payload) and attaches library
`rollbar/global` (`js/rollbar.js`, depends on `core/drupalSettings`). `ignored_headers` can set
`enabled => 'false'` client-side for matching requests.

## `hook_rollbar_settings_alter(&$settings)`

Before the client settings are attached, the module invokes
`\Drupal::moduleHandler()->alter('rollbar_settings', $settings)`. Implement
`hook_rollbar_settings_alter(array &$settings)` in a custom module to add/override any Rollbar JS
option (e.g. inject a `code_version`, add `transform` payload data, adjust `hostSafeList`) without
patching the module.
