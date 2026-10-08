<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CDNetworks Purge — purger, tags-header, and API client

## Purger plugin — `CdnetworksPurgePurger`

`src/Plugin/Purge/Purger/CdnetworksPurgePurger.php`, extends Purge's `PurgerBase`.

- Annotation: id `cdnetworks_purge`, label "CDNetworks Purger", `types = {"url"}`,
  `multi_instance = FALSE`.
- `routeTypeToMethod()` maps only `url` -> `invalidateUrls`; `tag` and `regex` mappings are
  commented out, so as configured the purger handles **URL invalidations only**. `invalidate()`
  throws `LogicException` (should never be reached).
- `getIdealConditionsLimit()` returns the `ideal_conditions_limit` config value (default 100).
  `hasRuntimeMeasurement()` returns TRUE.
- `invalidateUrls()`: chunks invalidations into batches of **500** (CDNetworks limit), sets each to
  `PROCESSING`, collects `getExpression()`, then calls `invalidateItems('url', $urls)` and writes
  the resulting state back to every invalidation via `updateState()`.
- `invalidateItems()`: for `url`, it rewrites each URL's host (the 3rd `/`-delimited segment) to the
  configured `cdn_url` before calling `$this->client->purgeUrl()`; logs the sent URLs when
  `verbose_log` is on. `tag`/`regex` branches call `purgeTag()` / `purgeRegex()`. Returns
  `SUCCEEDED`/`FAILED`; exceptions are caught and mapped to `FAILED`.
- `invalidateTags()` / `invalidateRegex()` are implemented but only reachable if you re-enable the
  corresponding `routeTypeToMethod()` entries. `invalidateTags()` deliberately sends **one tag at a
  time** (chunk size 1).

## Tags-header plugin — `CdnetworksPurgeTagsHeader`

`src/Plugin/Purge/TagsHeader/CdnetworksPurgeTagsHeader.php`, extends `TagsHeaderBase`. Id
`cdnetworks_purge_tags_header`, `header_name = "tag"`. `getValue()` joins the page's cache tags with
commas and replaces `:` with `_` (CDNetworks disallows `:` in tags). `isEnabled()` returns TRUE only
when config `cachetag == 1`.

## API client service — `cdnetworks_purge.client`

`src/Client/CdnetworksPurgeApiClient.php` implements `CdnetworksPurgeApiClientInterface`. Service
args: `@http_client` (Guzzle), `@key.repository`, `@config.factory`, `@logger.channel.cdnetworks_purge`.

Constructor resolves `username` and `apikey` config values into secrets via
`KeyRepository::getKey(...)->getKeyValue()` (`getKeyValue()`), reads `base_uri`, and computes a
per-request GMT date string.

Public methods:
- `purgeUrl(array $urls, $urlAction = 'default', $dirAction = 'default')` — groups URLs into `urls`
  vs `dirs` (trailing `/` = directory) via `groupUrls()`, then POSTs to `/ccm/purge/ItemIdReceiver`.
- `purgeRegex(array $urls)` — POSTs `urlRegulars` to `/api/content/regular-url/purge`.
- `purgeTag($tag, $action = 0)` — replaces `:` with `_`, POSTs `tag`+`action` to
  `/api/content/tag/purge`.
- `validateConfiguration()` — TRUE only if `username`, `apiKey`, and `baseUri` are all set.
- `request($endpoint, array $options)` — always POSTs `base_uri . endpoint` with Guzzle; decodes the
  JSON body; treats a response containing `itemId` as success. Errors and `RequestException`s are
  logged and return FALSE.

### Auth mechanism (`prepareOptions()` / `getPassword()`)

Requests use Guzzle HTTP **Basic auth**: `options['auth'] = [username, getPassword()]`, plus `Date`
and `Accept: application/json` headers, and a `json` body. `getPassword()` derives the credential per
the CDNetworks spec: `base64_encode(hash_hmac('SHA1', $date, $apiKey, TRUE))` — i.e. the raw API key
is used as the HMAC key over the request date, never sent directly. TLS verification is left at
Guzzle's secure default (the client does not disable `verify`); default `base_uri` is `https://`.
