<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Suggest proxy endpoint & JS behavior

## Route
`dadata_integration.suggest` — path `/dadata/suggest/{type}`, `_controller` `Controller\SettingsController::suggest`, `_permission: 'access content'`, `_format: 'json'`.

## Controller: SettingsController::suggest($type, Request $request)
Constructed with the core `http_client` (Guzzle) via `create()`. Flow:
1. Read `q` from the query string; if empty, return `{"suggestions": []}` immediately.
2. Load `api_key` and `api_url` from `dadata_integration.settings`.
3. Validate `$type` against the allowlist `['address','fio','email','party']`; anything else (including `undefined`) falls back to `address`.
4. Build the payload:
   - `query` = `q`
   - `count` = `min((int) query.count (default 10), 20)` (hard cap 20)
   - `language` = query `language` (default `ru`)
   - address only: if a `bound` query param is present and not `address`, set `from_bound`/`to_bound` = `{value: bound}`.
   - optional `locations` and `locations_geo`: JSON-decoded from the query string and passed through if they decode to arrays.
5. POST to `rtrim(api_url,'/') . '/' . type` with headers `Content-Type: application/json`, `Accept: application/json`, `Authorization: Token <api_key>`, `json` = payload, `timeout` 8.
6. Return the decoded DaData JSON as a `JsonResponse`. On a Guzzle `RequestException` it logs to the `dadata_integration` channel and returns `{"suggestions": [], "error": "request_failed"}` with HTTP 502.

TLS: uses the default core `http_client`, so peer verification is on (no `verify => false`). The API token is sent only in the outbound `Authorization` header and is not echoed in the response body.

## Client behavior: js/dadata_autocomplete.js
`Drupal.behaviors.dadataAutocomplete.attach()` iterates `drupalSettings.dadataIntegration.fields`. For each row it `document.querySelectorAll(selector)` (falls back to `cfg.field_id` if `field_selector` absent) and, guarding against double-binding via `input.dataset.dadataAttached`, wires each input:
- Base URL `/dadata/suggest/${cfg.type}`; for `address` with a non-default `bound`, appends `?bound=<bound>`.
- On `input`, when the trimmed value is >= 3 chars, `fetch`es `${apiUrl}[?|&]q=<encoded query>` and renders a `<ul class="dadata-suggestions">` of `<li class="dadata-suggestion-item">` from `data.suggestions[].value` appended to `input.parentNode`.
- Keyboard: ArrowUp/ArrowDown move the active item, Enter selects it; clicking a suggestion sets `input.value = s.value`. The dropdown closes on outside click and on blur (200 ms delay).

The client only ever sends `q` (and `bound` for addresses); `count`, `language`, `locations`, and `locations_geo` are controller-supported query parameters but are not set by the shipped JS.

## Operating notes
- The endpoint is the single integration point with DaData; it always uses the site-wide stored token, not a per-user credential.
- Because the library and `drupalSettings` are attached on every page (see [settings.md](../config/settings.md)), suggestions activate wherever a configured selector matches the DOM, including forms rendered by other modules.
