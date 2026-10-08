<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request URL, headers, body and tokens

## How the request is assembled (`HttpPurgerBase`)

- **URI:** `getUri()` builds `sprintf('%s://%s:%s%s', scheme, hostname, port, token->replace(path))`.
  The `path` is passed through Purge's token service, so it can be dynamic per invalidation.
- **Options (`getOptions()`):** sets Guzzle `http_errors`, `connect_timeout`, `timeout`, the
  computed `headers`, an optional `body` (token-replaced), and — only when `scheme === 'https'`
  — `verify`.
- **Headers (`getHeaders()`):** always sends `user-agent: purge_purger_http module for Drupal 8.`;
  adds `content-type: <body_content_type>` when a body is set; then each configured header's
  `value` is token-replaced and its `field` lower-cased (header names are case-insensitive, so
  lowercasing avoids duplicates).
- **Request:** `http` calls `client->request(request_method, uri, opt)` once per invalidation;
  `httpbundled` calls it once for the batch. Success sets each invalidation to `SUCCEEDED`,
  otherwise `FAILED` and a detailed emergency log entry is written.

## Tokens (via purge_tokens)

The token group available depends on the purger:

- `http` (`HttpPurgerForm`) exposes the **`invalidation`** token group — one invalidation is
  being processed, e.g. `[invalidation:expression]` is the single tag/path/URL.
- `httpbundled` (`HttpBundledPurgerForm`) exposes the **`invalidations`** token group — the
  whole set, e.g. `[invalidations:separated_pipe]` style tokens listing every item.

Use these tokens inside `path`, any header `value`, or the `body`. Typical patterns:

- **Tag BAN on Varnish** (`http`): header `X-Cache-Tags` = `[invalidation:expression]`,
  `request_method` = `BAN`.
- **Per-URL PURGE on nginx** (`http`): `path` = `[invalidation:expression]`,
  `request_method` = `PURGE`, `invalidationtype` = `url` (or `path`).
- **Bundled CDN API call** (`httpbundled`): `request_method` = `POST`,
  `body_content_type` = `application/json`, `body` = a JSON payload embedding an
  `[invalidations:…]` token, sent once for the batch.

The exact token names come from `purge_tokens` (`purge_tokens_token_info()`); the purger only
declares which group(s) apply through the form's `$tokenGroups` property.
