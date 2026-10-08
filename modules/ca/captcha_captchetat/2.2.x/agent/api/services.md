# Services, clients, routes and the validation flow (API)

## Services (`captcha_captchetat.services.yml`)

| Service id | Class | Purpose |
|---|---|---|
| `captcha_captchetat.widget` | `Service\CaptchaService` | Builds the challenge render array (`generate()`) and validates a submitted code (`validate()`). Args: `config.factory`, `renderer`, `request_stack`, `captcha_captchetat.helper.client`. |
| `captcha_captchetat.helper.client` | `Helper\ClientHelper` | Thin wrapper over the captcha client: `isAvailable()`, `isCaptchaValid()`, `getCaptcha()`, `getVersion()`. Args: `config.factory`, `captcha_captchetat.client.captcha`, `logger.factory`. |
| `captcha_captchetat.client.captcha` | `Client\CaptchaClient` | Calls the CaptchEtat API (`healthcheck`, `simple-captcha-endpoint`, `valider-captcha`, `info`, `version`). Injects an OAuth bearer via `getDefaultOptions()`. Parent `…client.base`, extra arg `captcha_captchetat.client.oauth`. |
| `captcha_captchetat.client.oauth` | `Client\OauthClient` | OAuth2 client-credentials token (`token()` → POST `api/oauth/token`) cached until `expires_in`; `authorize()` returns `"<token_type> <access_token>"`. Parent `…client.base`. |
| `captcha_captchetat.client.base` | `Client\ClientBase` (abstract) | Shared Guzzle GET/POST helpers with cache. Args: `cache.discovery`, `config.factory`, `http_client`, `logger.factory`. |
| `Drupal\captcha_captchetat\Hook\CaptchaCaptchetatHooks` | same | Autowired hook object (help / theme / captcha). |

All outbound requests use the injected `http_client` (Guzzle) with default options set to
`Accept: application/json`, `Charset: utf-8`; the captcha client adds `Content-Type: application/json`
plus `Authorization: <token>`, the OAuth client adds
`Content-Type: application/x-www-form-urlencoded`. **No TLS options are overridden** — Guzzle default
certificate verification applies; every base URL is `https://…gouv.fr`. On a `GuzzleException` the
request is logged (URL + error message only) and the method returns `null`.

## `hook_captcha` integration

`CaptchaCaptchetatHooks::captcha($op, $captcha_type)`:
- `op = 'list'` → returns `['CaptchEtat']` (the challenge shown in the CAPTCHA UI;
  `CaptchaServiceInterface::CAPTCHA_TYPE`).
- `op = 'generate'` and `$captcha_type === 'CaptchEtat'` → `CaptchaService::generate()`.

`CaptchaService::generate()` (when `ClientHelper::isAvailable()` is true) returns a CAPTCHA array with
`solution => TRUE`, `cacheable => TRUE`, `captcha_validate => 'captcha_captchetat_captcha_validation'`,
and a form containing a `captcha_widget` container (id `captchetat`, data attributes
`captchaStyleName` = configured `widget.type`, `urlBackend` = the `captcha_captchetat.object` route)
plus a required `captcha_response` textfield (id `captchaFormulaireExtInput`, maxlength 12). It
attaches `captcha_captchetat/captchetat-js`. If the service is **not** available it returns the
site's default CAPTCHA challenge instead (`generateDefault()` → the module named in
`captcha.settings:default_challenge`, or `Math`).

## Server-side validation flow (the security-critical path)

1. CAPTCHA module invokes the callback `captcha_captchetat_captcha_validation($solution, $response,
   $element, $form_state)` (in `.module`), which calls `captcha_captchetat.widget->validate($response)`.
2. `CaptchaService::validate($code)` reads `captchetat-uuid` from the current request. If the uuid
   **or** the code is empty it returns `FALSE` immediately (fails closed); otherwise it calls
   `ClientHelper::isCaptchaValid($captchaId, $code)`.
3. `ClientHelper::isCaptchaValid()` → `CaptchaClient::captchaValidate($captchaId, $code)` POSTs JSON
   `{uuid, code}` to `valider-captcha` (production/sandbox API) and returns the response body only
   for HTTP 200/201/204, else `null`. `isCaptchaValid()` returns `$data === 'true'`.

So the challenge answer is verified **server-to-server against the CaptchEtat API**; the form is
accepted only when the API returns the literal plaintext `true`. Any non-`true` body, non-2xx status,
transport error, or empty uuid/code yields `FALSE` — the design does not trust anything client-side
and does not fail open on API errors. (The `solution => TRUE` marker exists only to satisfy the
CAPTCHA module's element plumbing; the real decision is the API round-trip above.)

## Object-proxy route — `captcha_captchetat.object`

`/captchetat/object`, `_access: 'TRUE'` (necessarily public — a CAPTCHA precedes authentication),
controller `Controller\CaptchaObjectController::get()`. The bundled JS calls it to fetch the image or
sound. Query params: `get` (object type), `c` (captcha type), `t` (captcha uuid). Behaviour:
- Requires `c`; for non-image object types also requires `t`; otherwise `AccessDeniedHttpException`.
- If `ClientHelper::isAvailable()` is false → 503 with the configured `unreachable` text.
- Enforces per-IP flood control via the `flood` service (event
  `captcha_captchetat.captcha_generate`, limits `flood.ip_limit` / `flood.ip_window`); over the limit
  → 429 with the configured `flood` text (and a log entry).
- Otherwise proxies to the API through `ClientHelper::getCaptcha()`. `object`/`captcha` type strings
  are validated inside `CaptchaClient::captcha()` against `OBJECT_TYPES` (`image`, `sound`) and
  `TYPES` (throws `CaptchaClientException`, logged, empty result → 503) — they are never interpolated
  into the outbound host; the target host is a fixed constant. The uuid `t` is passed only as a
  Guzzle query value.

## Client method reference (`CaptchaClient`)

| Method | HTTP | Endpoint (under `piste/captchetat/v2/`) | Format |
|---|---|---|---|
| `healthcheck()` | GET | `healthcheck` | JSON (`status == 'UP'` ⇒ available) |
| `captcha($objectType,$type,$id?)` | GET | `simple-captcha-endpoint?c=&get=&t=` | plain (image/sound object) |
| `captchaValidate($id,$code)` | POST | `valider-captcha` (JSON `{uuid,code}`) | plain (`'true'`/`'false'`) |
| `captchaInfo($id)` | GET | `captcha/{id}/code/infos` | JSON |
| `info()` | GET | `info` (cached 1 day) | JSON |
| `version()` | GET | `version` (cached 1 day) | plain |

OAuth token requests (`OauthClient::token()`) POST `client_id`, `client_secret`,
`grant_type=client_credentials`, `scope` as `form_params` to `api/oauth/token`; the derived
`"<token_type> <access_token>"` string is cached under the config cache tags until `expires_in`.

## Other hooks

- `hook_theme` → `captcha_captchetat_widget_noscript` (template
  `templates/captcha-captchetat-widget-noscript.html.twig`, a `<noscript>` notice).
- `hook_help` → help text for `help.page.captcha_captchetat`.
- `hook_requirements` (runtime) → adds a "CaptchEtat Healthcheck" report row; error severity with a
  link to the settings form when `ClientHelper::isAvailable()` is false.
