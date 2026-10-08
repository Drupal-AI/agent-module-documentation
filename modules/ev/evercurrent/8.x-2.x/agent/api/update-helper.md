<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Evercurrent — UpdateHelper service & flow

## Service

`evercurrent.update_helper` → `Drupal\evercurrent\UpdateHelper implements UpdateHelperInterface`
(`src/UpdateHelper.php`, `src/UpdateHelperInterface.php`). Constructor args: `ConfigFactory`, `ModuleHandlerInterface`,
`ThemeHandlerInterface`, `MessengerInterface`. Constants live in `evercurrent.module`:
`RMH_URL = '/evercurrent/post-update'`, `RMH_MD5_MATCH = '/^[a-f0-9]{32}$/i'`, `RMH_API_VERSION = 2`,
`RMH_ENV_URL = 'https://app.evercurrent.io'`, and status codes `RMH_STATUS_OK`=0 / `RMH_STATUS_WARNING`=1 /
`RMH_STATUS_ERROR`=2.

## Cron flow

`evercurrent_cron()` (`evercurrent.module`): if config `send` is truthy and
`state('evercurrent_last_run') + config('interval') < time()`, it calls
`UpdateHelper::sendUpdates(TRUE)`. On success `sendUpdates()` writes `state('evercurrent_last_run') = time()`.

## `sendUpdates($force = TRUE, $key = NULL, $out = FALSE)`

1. Resolve the key: if `$key` is null, `getKeyFromSettings()` (see below). Validate with `keyCheck()` —
   `is_string($key) && preg_match(RMH_MD5_MATCH, $key)` (32 hex chars). Invalid → writes a WARNING status, returns FALSE.
2. Gather updates: `update_get_available(TRUE)` then `update_calculate_project_data()` (loads `update.compare`). Keeps
   entries whose `status` is one of the `UpdateManagerInterface`/`UpdateFetcherInterface` constants (NOT_SECURE,
   REVOKED, NOT_SUPPORTED, CURRENT, NOT_CHECKED, NOT_CURRENT).
3. Build `$sender_data`:
   - `send_url` = config `target_address`
   - `project_name` = `getEnvironmentUrl()` (settings.php `evercurrent_environment_url` or global `$base_url`)
   - `key` = the resolved API key
   - `module_version` = Evercurrent's own version from `extension.list.module`
   - `api_version` = `1` (literal in the payload)
   - `updates` = the filtered project-data array
   - `enabled` = map of enabled module machine names + enabled theme machine names (+ the install profile if the Update
     Manager reports on it), so the server can act on uninstalled projects.
4. `hook_evercurrent_update_data_alter($sender_data)` lets other modules extend the payload.
5. POST it: `\Drupal::httpClient()->request('POST', $target_address . RMH_URL, ['body' => json_encode($sender_data),
   'headers' => ['Content-Type' => 'application/json']])` (Guzzle via core's http_client). Connection exceptions →
   ERROR status, return FALSE.
6. Response handling: decodes the JSON body; expects `saved` truthy and a `message`. On success writes an OK status,
   records `evercurrent_last_run`, and calls `disableListening()`. On `saved` false writes the server `message` as ERROR.

## API-key resolution — `getKeyFromSettings()`

```
$config_key   = config('evercurrent.admin_config')->get('key');
$settings_key = Settings::get('evercurrent_environment_token', NULL);
return ($settings_key && !config->get('override')) ? $settings_key : $config_key;
```

So a settings.php token wins unless the `override` config flag is set. The key is never persisted to a Key entity and
there is no environment-variable/`getenv()`/dotenv mechanism — the key comes only from config or settings.php.

## Other public methods

- `setKey($key)` — validates and saves `key` to config; ERROR status on invalid format.
- `testUpdate($key)` — validates, turns `listen` off, saves the key, writes OK status, then `sendUpdates(TRUE)`.
- `writeStatus($severity, $message, $output = FALSE)` — `Xss::filter()`s the message, stores it in state
  (`evercurrent_status_message` / `evercurrent_status`); logs ERRORs to logger channel `evercurrent`; optionally shows
  a messenger message.
- `lastRun()` — human-readable interval since `evercurrent_last_run` (or "Never.").
- `getEnvironmentUrl()` — settings.php `evercurrent_environment_url` or global `$base_url`.
- `disableListening()` — sets config `listen` = FALSE.

## Listening mode — route `evercurrent.listener` (`/api/rmc/key`)

`Drupal\evercurrent\Controller\ListenerPageController` (`no_cache: TRUE`). When the admin has enabled "Listen for new
API key", the Evercurrent server can deliver the site's API key here instead of the admin pasting it: `content()` reads
the posted `data`, extracts `key`, and calls `UpdateHelper::testUpdate($key)`, which validates the key, saves it, sends
an update, and — on success — turns listening back off (`disableListening()`). Responses are JSON via `jsonResponse()`.
The route (`ListenerPageController::access()`) is only active while listening mode is enabled. This is the module's
documented mechanism for server-assisted key setup; leave listening off once the key is configured.
