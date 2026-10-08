Rollbar integrates a Drupal site with the [Rollbar](https://rollbar.com/) error-tracking service, both server-side (a PSR logger channel that forwards watchdog messages) and client-side (the Rollbar JS snippet that reports browser errors).

---

The module registers a `logger` service (`logger.rollbar` → `RollbarLogger`) that receives every Drupal log message and, when enabled, forwards selected severities to Rollbar using the bundled `rollbar/rollbar` PHP SDK. On the front end, `hook_page_attachments_alter` injects the Rollbar JS library and a `drupalSettings.rollbar` config block so uncaught JS errors and unhandled promise rejections are reported. Everything is driven by one settings form at `/admin/config/services/rollbar` (config object `rollbar.settings`): separate server and client access tokens, an `enabled` master switch, an `environment` string, a checkbox list of which RFC log levels to send, a `;`-separated list of logger channels to exclude, a comma-separated host allow-list, ignored-message and ignored-header lists, and `scrub_fields` (field names replaced with asterisks in payloads — defaults include `password`, `secret`, `auth_token`, `csrf_token`). `person_tracking` optionally attaches the current user's ID (and, on "Full", username + email) to reports — the form flags this as a possible GDPR concern. `ignored_headers` lets a matching request header disable reporting for that request. Other modules can alter the client settings via `hook_rollbar_settings_alter`. The `rollbar_js_url` setting points at a Rollbar CDN build by default.

---

- Forward PHP errors, warnings, and exceptions from Drupal's logger to Rollbar.
- Report uncaught JavaScript errors from the browser to Rollbar.
- Capture unhandled promise rejections in the browser.
- Choose exactly which RFC log levels (Emergency…Debug) are sent server-side.
- Separate error streams per environment (e.g. `production`, `staging`) via the environment string.
- Exclude noisy logger channels (e.g. `php`, `cron`) from being sent to Rollbar.
- Scrub sensitive field names (passwords, tokens) out of report payloads.
- Attach the current user's ID to error reports for easier triage.
- Attach username and email (Full person tracking) when GDPR allows.
- Restrict client-side reporting to a set of allowed hosts.
- Suppress specific known error messages client-side.
- Disable reporting for requests carrying a specific header (e.g. from monitoring/uptime bots).
- Turn all reporting on or off with a single `enabled` switch.
- Use distinct server and client (post_client_item) access tokens.
- Point the JS snippet at a self-hosted or pinned Rollbar library URL.
- Alter the client-side settings from a custom module via `hook_rollbar_settings_alter`.
- Centralise error monitoring across multiple Drupal sites into one Rollbar project.
- Correlate a spike in server log severity with front-end JS failures.
- Keep watchdog logging intact while additionally streaming to Rollbar.
- Silence reporting on local/dev by leaving `enabled` off or environment unset.
