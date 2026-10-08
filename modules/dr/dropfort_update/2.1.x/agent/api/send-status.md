<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The outbound client: dropfort_update_send_status()

All reporting logic is procedural, in `dropfort_update.module`. The worker is
**`dropfort_update_send_status(array $options = NULL)`**.

## When it runs (triggers)

- **`hook_cron()`** — calls the worker if more than 3600s have passed since the state value
  `dropfort_update.last_status` (i.e. throttled to at most once per hour).
- **`hook_module_implements_alter()`** — reorders `cron` so `dropfort_update` runs **after** other
  modules (notably core `update`), improving the chance fresh update data is available.
- **`hook_modules_installed()` / `hook_modules_uninstalled()`** — sends immediately after any module
  install/uninstall.
- **`DropfortUpdateSettingsForm::submitForm()`** — sends immediately on save.

## Precondition

Reads `site_key`, `site_token`, `dropfort_url` from `dropfort_update.settings`. If **any** is empty the
worker returns early (no request). So an unconfigured site sends nothing.

## Payload

Builds an array and JSON-encodes it (`Json::encode`) as the POST body:

- `site_key` — from config.
- `site_token` — from config (the auth token, sent in the request body).
- `site_status` — `_dropfort_update_system_status()` = `\Drupal::service('system.manager')
  ->listRequirements()` (the full site requirements/status report — the same data as
  `/admin/reports/status`).
- `update_status` — `update_calculate_project_data(update_get_available())` from core Update. If empty,
  it retries with `update_get_available(TRUE)` to force a refresh.

## Endpoint & request

- URL is built as `<dropfort_url> . '/api/v1/site/' . <site_key> . '/status'`.
- Before use, `UrlHelper::setAllowedProtocols(['https'])` then `UrlHelper::filterBadProtocol(...)` and
  `UrlHelper::isValid(...)` — **only `https` URLs pass**; an invalid URL logs a warning and aborts.
- Request via `\Drupal::httpClient()->request('POST', $status_url, $options)` (Guzzle). Options:
  headers `Content-Type: application/json` / `Accept: application/json`, `max_redirects: 3`,
  `timeout: 10`. No TLS options are overridden, so Guzzle's default certificate verification applies.

## Result / state / requirements

- On success it stores the send time in state `dropfort_update.last_status`. If any project in
  `update_status` is `NOT_FETCHED`/`FETCH_PENDING` (`UpdateFetcherInterface`), it back-dates the stored
  time by an hour so the next cron re-runs sooner.
- On `GuzzleHttp\Exception\RequestException` it logs the exception (via
  `Error::logException` / `watchdog_exception` compat shim) and sets `dropfort_update.last_status` to
  `FALSE`.
- **`hook_requirements('runtime')`** (`dropfort_update.install`) reads that state: `FALSE` →
  `REQUIREMENT_WARNING` "Failed to connect to Dropfort"; otherwise "Connected... last sent @time ago"
  on the site status report.
