<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Tester — request architecture

How a request flows from the browser UI through the Drupal server to the target endpoint and back.

## Endpoints (`ApiTesterController`, all `_permission: 'use api tester'`)
- `api_tester.main` — `main(Request)`: renders `#theme => 'api_tester_main'`, attaches library `api_tester/main`, and passes `drupalSettings.apiTester` (a CSRF token via `csrf_token->get('api-tester')`, the endpoint URLs, `baseUrl`, `currentUserId`, and the user's presets).
- `api_tester.execute` — POST `execute(Request)`: decodes the JSON body, optionally switches user, calls the executor, returns a `JsonResponse` of the result. This is the proxy that actually issues the outbound request.
- `api_tester.users` — `getUsers()`: returns active users (uid>0), **one representative per distinct role-combination** (dedup by sorted role key), `accessCheck(FALSE)`, for the "Test as User" dropdown.
- `api_tester.list_presets` / `save_preset` (POST) / `load_preset` / `delete_preset` (POST) — CRUD over per-user presets in State.

## Outbound execution (`Service\ApiExecutor::execute()`)
Signature: `execute($url, $method='GET', array $headers=[], $body='', array $auth=[], $body_type='json', array $form_data=[])`.
1. `urlValidator->validate($url)` (see below) — throws before any request.
2. Builds Guzzle options: enabled `headers`, `http_errors=FALSE`, `allow_redirects=TRUE`, `timeout=30`.
3. Auth (`$auth['type']`): `basic` → Guzzle `auth` `[user,pass]`; `bearer` → `Authorization: Bearer <token>`; `api_key` → header `key:value` or appended `?key=value` (urlencoded) depending on `add_to`; `drupal_session` → copies the current request's session cookie and adds `X-CSRF-Token` from `csrf_token->get('rest')`.
4. Body only for POST/PUT/PATCH: `form` → `form_params` from enabled fields; otherwise raw `body`.
5. `httpClient->request($method,$url,$options)`; returns `status`, `statusText`, `headers`, `body`, `decodedBody` (if JSON), `isJson`, `time` (ms), `size`. `RequestException` is caught and returned as a structured error (status 0 or the response's status).

## SSRF guard (`Service\UrlValidator::validate()`)
Rejects non-`http(s)` schemes and malformed URLs; matches the host, then the `gethostbyname()`-resolved IP, against a regex blocklist (`ALLOWED_SCHEMES`, `BLOCKED_PATTERNS`) of private/link-local ranges and cloud-metadata hosts. Called at the top of `ApiExecutor::execute()`.

## Test-as-User
`execute()` reads `test_as_user` (numeric uid); if the user loads, `accountSwitcher->switchTo($user)` runs before the request and `switchBack()` in both success and catch paths. Lets an operator re-run a request under another account to observe permission behavior.

## Presets (State API)
Key: `getUserPresetsKey()` → `api_tester.presets.uid_<currentUser id>` (scoped per user). `savePreset()` stores id/name/url/method/headers/params/body/body_type/form_data/auth/created/updated; id is the posted `id` or `uniqid('preset_')`. `hook_uninstall` deletes every user's preset key plus a legacy `api_tester.presets`.

## Client (`js/api-tester.js`)
Reads rows from the Params/Headers/Body/Auth tabs, POSTs JSON to `executeUrl` with header `X-CSRF-Token: settings.csrfToken`. Renders JSON responses as a collapsible tree / syntax-highlighted raw / table preview (values escaped via `escapeHtml`); a non-JSON body is shown in the preview pane through a client-side `nativeSanitize()` DOMParser pass. Also generates copyable code snippets for 13+ languages.
