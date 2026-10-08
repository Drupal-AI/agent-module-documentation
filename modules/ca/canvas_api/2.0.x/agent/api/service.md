<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# canvas_api service — `Drupal\canvas_api\CanvasApiService`

Registered as service id `canvas_api` (`canvas_api.services.yml`). Constructor args:
`@http_client_factory`, `@config.factory`, `@key.repository`, `@logger.factory`.
Grab it with `\Drupal::service('canvas_api')` or inject `canvas_api`.

## Construction
On construct it:
- loads `canvas_lms.settings` into `$this->lms` (immutable config — supplies `institution`, `environment`);
- reads `canvas_api.settings.key` (a Key entity id); if set, resolves the token via
  `KeyRepositoryInterface::getKey($key)->getKeyValue()`; if NOT set, logs an error to the `canvas_api`
  channel and leaves `$this->token` null (calls will then send an empty bearer token).

## Fluent builders (each returns `$this`)
- `setPath(string $path)` — the API path **relative to** `/api/v1/`, e.g. `courses/123/users`.
- `setMethod(string $method)` — `GET` | `POST` | `PUT` | `DELETE`.
- `setParams(array $params)` — query params (GET) or form params (non-GET).

## `request(): array`
1. Builds a Guzzle client via `ClientFactory::fromOptions(getClientOptions())`.
   `getClientOptions()` sets `base_uri` = `getUrlString()` and header
   `Authorization: Bearer <token>`. (TLS verification is left at Drupal/Guzzle default = ON; no
   `verify` override.)
2. Calls `$client->request($method, $path, getOptions())`.
   - `getOptions()` always appends `query = per_page=100` (`self::PER_PAGE`). For GET it also appends
     `&<buildQuery(params)>`; for non-GET it sends `form_params => $params`.
3. **GET pagination:** decodes the body, then while `getNextUrl($response)` returns a URL it does
   `$client->get($next)`, merges each page with `array_merge`, and repeats. A counter fail-safe
   `die('Over 50 iterations')` aborts after 50 pages.
4. Returns the decoded array (merged pages for GET; the single decoded body otherwise).

## Helpers
- `getUrlString(): string` — `https://<institution>` + suffix by environment
  (`production` = none, `test` = `.test`, `beta` = `.beta`; unknown → logs error) + `.instructure.com/api/v1/`.
  The host is therefore always an `*.instructure.com` subdomain derived from admin config.
- `getNextUrl($response)` — regex-extracts the `rel="next"` target from the `Link` response header
  (`/,<(.+)>; rel="next"/`), returns FALSE when absent.
- `buildQuery(array $params): string` — encodes arrays as Canvas expects: `foo[]=bar&foo[]=baz` for
  numeric keys, `foo[key]=val` for string keys, avoiding PHP's `foo[0]=` form that Canvas rejects.

## Notes for callers
- `request()` returns a plain array; API/network/HTTP errors surface as Guzzle exceptions — wrap in
  try/catch in your code.
- The service is stateful (path/method/params persist on the instance); create/reset per call rather
  than reusing across unrelated requests in one process.
