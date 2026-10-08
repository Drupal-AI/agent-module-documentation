<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Enhanced — fetchers

Three `@FeedsFetcher` plugins in `src/Feeds/Fetcher/`. Selected per Feed Type on the Feeds
"Fetcher" step. Enable with `drush en feeds_enhanced` (needs `feeds`, `key`, `dx_toolkit`).

## `sftp` — SftpFetcher ("Download via SFTP")

`src/Feeds/Fetcher/SftpFetcher.php`, extends Feeds `PluginBase`, `ContainerFactoryPluginInterface`.
Downloads the feed file over SFTP with phpseclib3.

Config (`defaultConfiguration()`, schema `feeds.fetcher.sftp`):
- `host` (string) — stored verbatim, may be `hostname:port` (e.g. `sftp.example.com:22`).
- `port` (int) — default `SftpClient::defaultPort()` = 22.
- `username` (string).
- `password` (string) — **a Key entity ID**, not a raw secret. `getPw()` calls
  `key.repository`→`getKey($id)->getKeyValue()`; empty string if the key is missing.
- `timeout` (int) — default `SftpClient::defaultTimeout()` = 90 s.

Forms: `Form\SftpFetcherForm` (feed-type config) + `Form\SftpFetcherFeedForm` (per-feed), sharing
`Form\SftpFetcherFormTrait`; the Key selector is built from `key.repository`. The form stores
`host` as-is; parsing to host/port happens at runtime.

`fetch(FeedInterface $feed, StateInterface $state)`:
1. Merges feed config with the resolved Key password.
2. If a `token` service is present, `$this->token->replace($config['host'], ['feed' => $feed], ['clear' => TRUE])` — so `[feed:*]` tokens in the host expand at fetch time. (The optional token
   service is `token`; the `feeds_enhanced_tokens` submodule expands the broader config.)
3. If host contains `:`, `parse_url("sftp://{host}")` splits host/port.
4. Builds `SftpClient($config)`, writes to a Feeds temp file (`feeds.file_system.in_progress`→`tempnam`),
   calls `getFile($feed->getSource(), $sink)`. On failure sets a state message and throws
   `EmptyFeedException`. Returns `SftpFetcherResult`.

**Source path** = `$feed->getSource()` (the admin-entered feed source), i.e. the remote file path
on the SFTP server. `SftpClient` (`src/SftpClient.php`) wraps `phpseclib3\Net\SFTP`: `logIn()` calls
`$client->login($username, $password)`; `getFile()` calls `$client->get($source, $destination)`.
Connection host/username/key are admin-configured on the Feed Type / Feed.

## `unconditional_http` — HttpUnconditionalFetcher ("Download unconditionally from url")

`src/Feeds/Fetcher/HttpUnconditionalFetcher.php`, **extends core Feeds `HttpFetcher`**; reuses its
`HttpFetcherForm` / `HttpFetcherFeedForm` and its Guzzle-based `get()`. Only override:
`getCacheKey()` returns `FALSE`, which suppresses the `If-None-Match` / `If-Modified-Since` headers
so the target URL is downloaded on every import regardless of change. Use for in-place-updated
sources or to keep every version. URL is the admin-configured feed source (same trust model as
core's HTTP fetcher).

## `null_data_source` — NullDataSource ("Null data source")

`src/Feeds/Fetcher/NullDataSource.php`. `fetch()` returns `new FetcherResult('')` — no I/O. Use for
update-only Feed Types or with the **`entity_data`** parser (see parsers.md) where the source rows
come from stored entities, not a fetched file. Forms `NullDataSourceFetcherForm` /
`NullDataSourceFeedForm` are empty config forms.
