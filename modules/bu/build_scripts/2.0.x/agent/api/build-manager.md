<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build scripts — service API & flow

## Service `build_scripts.build_manager`

Class `Drupal\build_scripts\BuildManager` implements `BuildManagerInterface` (`build_scripts.services.yml`, args `@config.factory`, `@http_client_factory`). The constructor builds one Guzzle client via `ClientFactory::fromOptions([...])`:

- `base_uri` = `build_scripts.settings:address`
- `http_errors => FALSE` (non-2xx responses are returned, not thrown)
- `headers['Host']` = the current Drupal request host (so the daemon can vhost by site)

Methods:

- `start($stage, $language)` — first calls `isValidStage($stage)` = `in_array($stage, $config->get('stages'))`; if not valid, throws `\Exception("Stage {$stage} is not one of the configured stages.")`. Otherwise `POST /start/{stage}+{language}`; on `RequestException` returns `NULL`; else returns `json_decode($response->getBody())` (the build id).
- `streamLogs($build_id)` — `GET /logs/by-id/{build_id}` with `['stream' => TRUE]`; on `RequestException` returns `new BuildLogStream(NULL)`, else wraps the streamed response. `{build_id}` is a route param (cannot contain `/`).

## `BuildLogStream` (`implements BuildLogStreamInterface`)

Thin PSR-7 `StreamInterface` wrapper around the Guzzle response body. `getStatusCode()` returns `STATUS_UNAVAILABLE` when the wrapped response is `NULL` (daemon unreachable / logs truncated); all other stream methods (`read`, `eof`, `getContents`, `seek`, …) delegate to `$response->getBody()` and throw `"Log stream is unavailable."` if there is no response.

## Controller `BuildController` (`use build_scripts` on all three)

- `start(Request, $stage)` — resolves current langcode, `BuildManager::start()`, saves the id to session key `build_scripts.{stage}`, logs it; returns `JsonResponse($buildId)` or throws `ServiceUnavailableHttpException` if empty. Route is **POST-only** (`build_scripts.start`).
- `view(Request, $stage)` — reads the session build id for the stage; if present, renders a `<code id="builder-output">` and attaches `build_scripts/build_scripts.builder` with `drupalSettings.build_scripts = {buildId, endpoint}` (endpoint = `build_scripts.logs` URL). If absent, sets an error message. Shares path `/admin/build/{stage}` with `start` (GET vs POST).
- `logs(Request, $build_id)` — `set_time_limit(BUILD_TIMEOUT=600)`, gets a `BuildLogStream`; if `STATUS_UNAVAILABLE` throws `ServiceUnavailableHttpException`; else returns a `StreamedResponse` that `ob_end_clean()`s, reads `READ_BUFFER=128`-byte chunks until `eof()`, `fwrite`+`flush` to `php://output`. Headers: `X-Accel-Buffering: no`, `Content-Type: text/plain`.

## Client-side

- `js/build_scripts.toolbar.js` (`Drupal.behaviors.oeBuilderToolbar`) — on click of `[data-toolbar-builder]`, `preventDefault`, show fullscreen progress indicator, `fetch(url, {method:'POST', headers:{'Content-Type':'application/json'}})`, then `window.location.href = url` (GET → view page).
- `js/build_scripts.builder.js` (`Drupal.behaviors.oeBuilder`) — `fetch(endpoint)`, read the response body with a `ReadableStreamDefaultReader`, decode chunks and append to `#builder-output.textContent` (log rendered as text, not HTML).

## Toolbar hook

`build_scripts_toolbar()` (`build_scripts.module`) builds `#type: toolbar_item` "Build" with one link per configured stage (`Url::fromRoute('build_scripts.start', ['stage' => $stage])`), cached per `user.permissions` + `config:build_scripts.settings`, only when the current user has `use build_scripts`.
