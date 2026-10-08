<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search flow: Acquia Cloud API + SSH/drush + batch

The search combines three services driven by `Form\ACSFModulesListingForm`.

## 1. Search form — `Form\ACSFModulesListingForm` (extends `FormBase`)

- `create()` injects `config.factory`, `cache.default`, `request_stack`, `extension.list.module`,
  and the three module services (`acsf_environment_entity`, `acsf_api_v1_service`, `ssh_service`).
- `buildForm()` runs only if `function_exists('ssh2_connect')`. It offers: `server` (select of the
  configured `acsf_environment_entity` labels), `module_search` (textfield — machine name or title),
  `ignore_cache` (checkbox). When the request has a `?result=<cache-key>` query param it renders a
  results `#type => 'table'` from the cached data (Website / Modules columns).
- `submitForm()`:
  1. Loads the chosen environment via `AcsfEnvironmentEntityService::loadAcsfEnvironmentById()`.
  2. Cache key = `acsf_module_listing_search.` . `Html::cleanCssIdentifier(module_search)`; if cached
     and `ignore_cache` is off, redirects straight to the results page.
  3. Otherwise calls `AcsfApiV1Service::getWebsitesList()` and, for each returned site, adds a
     batch operation (`processItem`) using a `Core\Batch\BatchBuilder`.
- `processItem()` calls `SshShellService::getWebsiteModulesList()` per site and stores results in the
  batch context. `finished()` caches the aggregated `modules` under the search key with lifetime
  `configuration.cache_lifetime` and redirects to `…/search?result=<key>`.
- `formatModuleName()` parses a drush `pm-list` row (array) into
  `version` / `status` / `machine_name` / `package` / `title` for display.

## 2. Acquia Cloud API — `Services\AcsfApiV1Service::getWebsitesList()`

- Builds `$url = {acsf_env_url}/api/v1/sites`.
- Guzzle `GET` with `auth => [acsf_username, acsf_api_key]` (HTTP basic) and `query => ['limit' => 10000]`.
- On HTTP 200 returns `json_decode(body, TRUE)` (expected shape: `count`, `sites[]` with `domain`).
  Non-200 or exception → logs to channel `acsf_module_listing`, shows a generic messenger error,
  returns NULL.
- **TLS verification is left at Guzzle's default (enabled)** — no `verify => false`. The API key is
  passed via the Guzzle `auth` option (basic-auth header), not in the URL.

## 3. SSH + drush — `Services\SshShellService`

- `establishSshConnection()`: `ssh2_connect(ssh_url, 22, ['hostkey' => 'ssh-rsa'])` then
  `ssh2_auth_pubkey_file(conn, ssh_user, public_key_path, private_key_path, pass_phrase ?: '')`.
  Returns the connection resource, or NULL on failure (logged).
- `getWebsiteModulesList($env, $website, $input, $ignore_cache, $full_list = FALSE)`:
  - Cache key `acsf_module_listing.sites.{env id}.{cleaned website}`; TTL `time() + cache_lifetime`.
  - On a miss (or `ignore_cache`), opens the SSH connection and calls `getSshModulesList()`.
  - Splits the drush output on `PHP_EOL`, then each line on whitespace (`preg_split('/\s+/')`).
    Unless `$full_list`, keeps only rows where a token contains one of the space-split search words
    (`str_contains(strtolower(...), $word)`).
- `getSshModulesList()` (private): builds
  `drush -r {drush_path} -l {website} pm-list` (adds `--type=Module --status=enabled` unless
  `$full_list`), runs it with `ssh2_exec()`, reads the stream (`stream_set_blocking(TRUE)`,
  `stream_get_contents`). Returns the raw text or NULL.

## 4. Remap helper — `Services\AcsfModulesCommon::remapModulesList()`

Transforms a `site => rows[]` array into a `machine_name => {machine_name, name, sites[], version}`
array (a module is attributed to a site only when its row status is `Enabled`), sorted ascending by
number of sites. Registered as service `acsf_module_listing.acsf_modules` but **not called by the
shipped forms** — it is a helper for consumers.

## Notes for agents

- The whole feature acts on **remote ACSF sites**, not the host site; the host never publishes its
  own module list.
- Result caching is keyed by search term and by site; use the "Ignore cached results" checkbox to
  force fresh SSH round-trips.
- `drush_path` must point to a working drush for the target sites on the Acquia Cloud SSH host.
