<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RulesAction: "Request HTTP data" (`rules_http_client`)

Class `Drupal\rules_http_client\Plugin\RulesAction\RulesHttpClient` (extends `RulesActionBase`,
implements `ContainerFactoryPluginInterface`). File `src/Plugin/RulesAction/RulesHttpClient.php`.
Annotation id `rules_http_client`, label "Request HTTP data", category "Data".

## Install / enable
`drush en rules_http_client`. Requires Rules (`drupal/rules:^4.0`). The action then appears when
adding an action to any reaction rule or rules component in the Rules UI.

## Context inputs (from the `@RulesAction` annotation)
| Name | Type | Required | Default | Notes |
|---|---|---|---|---|
| `url` | string | yes | — | `multiple = TRUE`; only `$url[0]` is used at runtime. |
| `headers` | string | no | — | `name: value` pairs, one per line. |
| `method` | string | no | GET | Upper-cased; any verb (GET/POST/PUT/DELETE/PATCH/…). |
| `data` | string | no | — | `multiple`, `assignment_restriction = "data"`; `param=value` lines → JSON body. |
| `max_redirects` | integer | no | 3 | `assignment_restriction = "input"`. |
| `timeout` | float | no | 30 | Seconds. |
| `debug` | boolean | no | false | `assignment_restriction = "input"`; enables request/response logging. |

Provides: `http_response` (string) — the response body, set only on a 2xx status.

Any input can be a literal or a Rules **data selector** resolved at execution time; the URL is
therefore chosen by whoever configures the Rule (needs `administer rules`).

## Execution flow — `doExecute(array $url, $headers, $method, $data, $max_redirects, $timeout, $debug)`
1. `debug` coerced via `filter_var(..., FILTER_VALIDATE_BOOLEAN)`.
2. Headers: if a string, `explode("\n", …)`; each non-empty line containing `:` is split once into
   `name`/`value`, `ltrim`-ed, and placed in `$options['headers'][$name]`.
3. Body: if `data` is an array, each `param=value` is `explode('=', …)` into a keyed array, then
   `json_encode`-d. The same JSON string is used as both `$options['data']` and `$options['body']`.
4. `max_redirects` defaults to 3, `timeout` to 30 if empty. `method = strtoupper($method ?: 'GET')`.
5. Builds `new GuzzleHttp\Psr7\Request($method, $url[0], $headers, $body)` and calls
   `$this->httpClient->send($request, $options)` — the shared core `http_client` (Guzzle) service.
6. On 2xx: rewinds the body stream, `getContents()`, and `setProvidedValue('http_response', $output)`.
7. `RequestException` and generic `\Exception` are caught and logged to the `rules_http_client`
   logger channel (`logger.factory`); non-2xx bodies are not set as `http_response`.

## Debug logging — `getDebugLogMessage(RequestInterface, ResponseInterface)`
When `debug` is true, builds an HTML message (method, URL, request/response headers and bodies) via
Guzzle `MessageFormatter` tokens (`{req_headers}`, `{res_body}`, …) and logs it with `logger->debug`
(or `->error` on failure). Basic-auth credentials in the URL user-info are masked (`withUserInfo(...,
'***')`). If `rules_http_client.settings:show_responses` is on **and** the current user has the
`access rules debug` permission, the same details are echoed to the UI via
`messenger()->addStatus()`/`addError()` using a `FormattableMarkup` (placeholder values are escaped).

## Operating notes
- TLS is verified by default (uses core `http_client`; no verify-off option is set).
- `getBodySummarizer()` builds a `GuzzleHttp\BodySummarizer` sized from
  `rules_http_client.settings:max_response_size` (default 10000) for error-path body truncation.
- Only the first URL is requested even though `url` is `multiple`; extra URLs are ignored.
- `data` lines without an `=` produce a malformed body element (robustness caveat, not configurable).
