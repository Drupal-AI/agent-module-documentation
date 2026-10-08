<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CaptchEtat service, proxy route & JS flow

## Service `captchetat.captchetat`

`Drupal\captchetat\Service\CaptchetatService` (`src/Service/CaptchetatService.php`), implementing
`CaptchetatServiceInterface`. DI args: `@config.factory`, `@http_client` (Guzzle `Client`),
`@cache.discovery`. Constants: `PISTE_API_URL`/`PISTE_OAUTH_URL` (production),
`PISTE_SANDBOX_API_URL`/`PISTE_SANDBOX_OAUTH_URL`, and `PISTE_API_PATH = /piste/captchetat/v2`.
`getApiUrl()`/`getOauthUrl()` pick sandbox vs production from config (`sandbox` defaults TRUE).

Methods:

- **`getApiToken(): string`** — returns the cached OAuth token (`captchetat.access_token` in
  `cache.discovery`) or calls `fetchApiToken()`.
- **`fetchApiToken(): string`** — POSTs `grant_type=client_credentials`, `client_id`,
  `client_secret`, `scope=piste.captchetat` (as `form_params`) to `{oauth}/api/oauth/token`.
  Caches the `access_token` with an expiry of `time() + expires_in/2` and the config cache tags
  (so a config change invalidates it). Returns `''` and logs on missing config or any exception.
- **`clearApiToken(): void`** — deletes the cached token (used by `hook_uninstall`).
- **`getCaptcha(string $token, Request $request): Response`** — proxies the challenge fetch.
  Reflects the request's query string (`explode('?', $request->getRequestUri())[1]`) onto
  `{api}/piste/captchetat/v2/simple-captcha-endpoint?...`, GETs it with header
  `Authorization: Bearer {token}`, and returns the upstream body/status with the upstream
  `Content-Type`. Empty token → 500; exceptions → 500. **Host/path are fixed constants** — only the
  query string is caller-influenced.
- **`validateCaptcha(string $captcha_uuid, string $code, string $token): bool`** — POSTs
  `{"uuid":..., "code":...}` (JSON) to `{api}/piste/captchetat/v2/valider-captcha` with the Bearer
  header. Returns `true` only when the upstream body is exactly the string `'true'`. Returns FALSE
  (fail-closed) on empty code / empty token / empty uuid / any exception.
- **`healthCheck(string $token): mixed`** / **`isServiceUp(string $token): bool`** — GET
  `/healthcheck`; `isServiceUp` is TRUE only when the decoded `status` === `'UP'`.

TLS: all calls use the injected Guzzle `http_client` with default options — certificate
verification is left ON (no `verify => false`).

## Proxy route `captchetat.getcaptcha`

`captchetat.routing.yml`:

```yaml
captchetat.getcaptcha:
  path: "/simple-captcha-endpoint"
  defaults: {_controller: 'Drupal\captchetat\Controller\CaptchetatController::getCaptcha'}
  requirements: {_access: "TRUE"}
```

`_access: "TRUE"` means the route is reachable by anyone (anonymous) — required so the challenge
image/audio can load on public forms. `CaptchetatController::getCaptcha()` simply calls
`getApiToken()` then `$service->getCaptcha($token, $request)`. There is no per-request rate limit
in the module; throttling relies on the front end and the upstream API.

## Front-end flow

`hook_captcha()` renders a `#captchetat` container carrying HTML attributes `captchaStyleName`
(the language-suffixed style) and `urlBackend` (= `Url::fromRoute('captchetat.getcaptcha')`),
and attaches library `captchetat/captchetat`.

- `js/captchetat.js` — a no-op `Drupal.behaviors.captchetat` using `once`.
- `assets/vendor/captchetat/captchetat-js.js` (vendored, minified) — on load, `fetch()`s
  `urlBackend + '?get=image&c=' + captchaStyleName`, expects JSON `{imageb64, uuid}`, sets
  `#captchaImage.src` to the base64 image, and writes `uuid` into a hidden input
  `#captchetat-uuid` (posted with the form). A reload button re-fetches; a sound button plays
  `urlBackend + '?get=sound&c=' + style + '&t=' + uuid` via `new Audio()`.

The `uuid` produced per challenge is what `validateCaptcha()` sends back to `/valider-captcha`;
the module keeps no server-side record of issued uuids — issuance and one-time validity are
handled by the upstream CaptchEtat API.
