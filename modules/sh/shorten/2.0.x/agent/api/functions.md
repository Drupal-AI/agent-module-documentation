# Shorten URLs — API & tokens

All procedural, in `shorten.module`.

## `shorten_url($original = '', $service = ''): string`
The main API. Returns a shortened URL.
- `$original` empty → uses the current page's absolute URL.
- `$service` empty → uses config `shorten.settings:shorten_service`.
- Resolves the service definition from `moduleHandler()->invokeAll('shorten_service')`, calls
  `_shorten_get_url()`. On failure, retries with `shorten_service_backup`; if that also fails,
  returns `$original` unchanged.
- Optionally rewrites `http(s)://` → `www.` when `shorten_www` is set.
- Fires `hook_shorten_create($original, $url, $service)` before returning.
- (Cache calls are present but commented out in this release — results are recomputed unless a
  submodule/caller memoises them.)

```php
$short = shorten_url('https://example.com/a/very/long/path');
$short = shorten_url($url, 'TinyURL'); // force a specific service
```

## `shorten_fetch($url, $tag = '', $special = '', $options = []): string|false`
Low-level fetch of the service response. `$url` is the full service endpoint **with the target URL
already appended**. Method from `shorten_method`:
- `php`: `\Drupal::httpClient()->get($url, $options)` (Guzzle), body `stripslashes`ed.
- `curl`: raw cURL with `CURLOPT_MAXREDIRS`, protocol restriction to HTTP(S), etc.
Options merge `max_redirects=3` and `timeout=shorten_timeout`. If `$tag` given, extracts a value
from XML (`_shorten_xml`) or JSON (`shorten_get_value_from_json`, dot-path aware). Returns the
abbreviated URL or FALSE.

## `_shorten_get_url($original, $api, $service)`
Builds the request from a service definition (`$api` string or array with `url`/`tag`/`json`/
`custom`/`args`), calls `shorten_fetch`, and validates the result begins with `http(s)://`
(else logs and returns FALSE). A `custom` service key names a PHP callback
(`call_user_func`) — see hooks doc.

## Built-in services (`shorten_shorten_service()`)
Always present: `is.gd`, `migre.me`, `Metamark`, `PeekURL`, `qr.cx`, `ri.ms`, `TinyURL`.
Key-gated: `bit.ly`/`j.mp` (login+key), `budurl`, `ez`, `goo.gl` (custom callback), `fwd4.me`.
`ShURLy` added when the `shurly` module exists (on-domain shortening).

## Tokens (`hook_token_info` / `hook_tokens`)
- `[url:shorten]` — shortens the current URL/path with the default service.
- `[node:short-url]` — **deprecated**; use `[node:url:shorten]` / `[node:url:unaliased:shorten]`.
Both resolve through `shorten_url()`.
