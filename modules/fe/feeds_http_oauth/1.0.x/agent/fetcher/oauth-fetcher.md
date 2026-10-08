<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The OAuth 2.0 Feeds fetcher (`http_oauth`)

One `@FeedsFetcher` plugin defined in `src/Feeds/Fetcher/HttpOAuthFetcher.php`:

```
@FeedsFetcher(
  id = "http_oauth",
  title = "Download from url (OAuth 2.0)",
  form = {
    "configuration" = "Drupal\feeds\Feeds\Fetcher\Form\HttpFetcherForm",       // core, unchanged
    "feed"          = "Drupal\feeds_http_oauth\Feeds\Fetcher\Form\HttpOAuthFetcherFeedForm"
  }
)
```

`HttpOAuthFetcher extends HttpFetcher` (Feeds core). `create()` fetches the same services as the
parent (`http_client`, `cache.feeds_download`, `file_system`, `feeds.file_system.in_progress`) plus
`key.repository`, stored as `$this->keyRepository`.

## Install / enable

Depends on `feeds` and `key` (see `feeds_http_oauth.info.yml`). Enable the module, then on a
**feed type** set the Fetcher to *Download from url (OAuth 2.0)*. There is **no settings route or
permission** — all OAuth values are entered per **feed** (Content → Feeds).

## Per-feed configuration (the OAuth feed form)

`HttpOAuthFetcherFeedForm extends HttpFetcherFeedForm`. `buildConfigurationForm()` calls the parent
(Feed URL / core HTTP fields) and adds an `oauth` `details` group under
`$form['plugin']['fetcher']['oauth']`:

| Key | `#type` | Notes |
|---|---|---|
| `grant_type` | `select` | `client_credentials` (default) or `password`; required |
| `send_client_credentials_in` | `radios` | `body` (default) or `header`; visible only for `client_credentials` |
| `access_token_url` | `url` | token endpoint, required, maxlength 2048 |
| `client_id` | `key_select` | selects a **Key entity**; required |
| `client_secret` | `key_select` | selects a **Key entity**; required |
| `scope` | `textfield` | optional |
| `username` | `key_select` | Key entity; visible + required only for `password` grant |
| `password` | `key_select` | Key entity; visible + required only for `password` grant |

`#states` toggle the fields by grant type using selector
`:input[name="plugin[fetcher][plugin][fetcher][oauth][grant_type]"]`.

`submitConfigurationForm()` reads the existing config first, lets the parent save the core HTTP
fields, then merges the OAuth values back from `$values['plugin']['fetcher']['oauth']` (parent submit
would otherwise wipe them). For the `password` grant it keeps `username`/`password`; otherwise it
`unset()`s them. `defaultFeedConfiguration()` returns the keys `access_token_url`, `grant_type`
(default `client_credentials`), `client_id`, `client_secret`, `scope`, `username`, `password`,
`send_client_credentials_in` (default `body`).

Config schema: `feeds.fetcher.http_oauth` (mapping of the eight string keys above) in
`config/schema/feeds_http_oauth.schema.yml`. Values are stored inside the feed's fetcher
configuration.

## Credential resolution via the Key module

In `getAccessToken()` each credential is treated as a **Key name first**: for `client_id`,
`client_secret`, and (password grant) `username`/`password`, the code calls
`$this->keyRepository->getKey($value)` and, if a Key entity of that name exists, uses
`$key->getKeyValue()`; otherwise the stored string is used literally. Because the form fields are
`key_select`, the stored values are Key entity names selected by the feed admin, resolved to their
values at request time.

## Token exchange — `getAccessToken($feed_config)`

- Requires `access_token_url` (throws `\RuntimeException` if missing).
- Builds a POST with header `Content-Type: application/x-www-form-urlencoded` and `FORM_PARAMS`.
- **client_credentials:** `grant_type=client_credentials`; if
  `send_client_credentials_in === 'header'` it sends `Authorization: Basic base64(client_id:client_secret)`,
  otherwise it puts `client_id`/`client_secret` in the body. Adds `scope` if set.
- **password:** always sends `Authorization: Basic base64(client_id:client_secret)` plus body
  `grant_type=password`, `username`, `password` (+ optional `scope`).
- Any other grant type throws `\RuntimeException('Unsupported OAuth grant type.')`.
- Sends via `$this->client->request('POST', $access_token_url, $options)` (core `http_client` /
  Guzzle). On `RequestException` it logs `watchdog_exception('feeds_http_oauth', $e)` and throws.
- Parses the JSON body with `json_decode(..., FALSE)`; a non-object response throws. Returns the
  decoded token object (expects `access_token` + `token_type`).

## Data fetch — `get($url, $sink, $cache_key, $options, $feed_config)`

- Requires a non-empty `$feed_config` (throws otherwise) — OAuth is mandatory for this fetcher.
- Calls `getAccessToken()`; a token missing `access_token`/`token_type` throws.
- Translates schemes with `Feed::translateSchemes($url)`, then downloads with
  header `Authorization: {token_type} {access_token}`, `SINK => $sink`, an optional inherited
  `User-Agent`, and (when a `cache_key` is cached) conditional `If-None-Match` / `If-Modified-Since`
  headers.
- Uses `$this->client->getAsync($url, $options)->wait()`; on `RequestException` throws a broken-feed
  `\RuntimeException`. When `cache_key` is set, stores the (lower-cased) response headers in
  `$this->cache`. Returns the Guzzle response — Feeds' parser/processor handle the body.

`defaultConfiguration()` also disables `auto_detect_feeds` and `use_pubsubhubbub` by default.

## Limitations (from source / README)

- No refresh-token caching; a token is fetched on each run.
- No provider-specific quirk handling; the token response must be JSON with `access_token` +
  `token_type`.
