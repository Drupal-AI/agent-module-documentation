<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Asset Fetcher (assetfetcher) — agent index

Downloads the **external CSS/JS library files** that modules/themes declare (`type: external`)
and rewrites the asset sources to local copies, so browsers never hit the CDN. Verifies any
declared **SRI** hash. Version **1.1.0**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.
No dependencies, no entities, no permissions, no routes, no Drush.

- **How it works, config, SRI, CDN path reuse, operating it** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- Two alter hooks in `assetfetcher.module`: `assetfetcher_css_alter()` and
  `assetfetcher_js_alter()` both call `AssetFetcher::adjustSources($sources, 'css'|'js')`.
  A third, `assetfetcher_form_alter()`, delegates to `AssetFetcherConfig::hookFormAlter()`.
- Config UI is **injected into the core Performance form** (`system.performance_settings`,
  route `system_performance_settings`) — the module has no settings route of its own.
  info.yml `configure: system.performance_settings`.
- `hook_requirements('runtime')` (via `AssetFetcherRequirements`) reports which library
  external assets could / could not be fetched on the status report.

## Services (`assetfetcher.services.yml`)

- `assetfetcher.service` → `Drupal\assetfetcher\AssetFetcher` (the fetch/rewrite engine;
  `@internal`). Args: `file_system`, `logger.factory`, `stream_wrapper_manager`,
  `assetfetcher.config`, `assetfetcher.sri_checker`.
- `assetfetcher.config` → `Drupal\assetfetcher\AssetFetcherConfig` (reads
  `assetfetcher.settings`, builds the Performance-form fieldset, saves on submit).
- `assetfetcher.sri_checker` → `Drupal\assetfetcher\SRI\SubResourceIntegrityChecker`.

## Config object `assetfetcher.settings`

`enabled` (bool, default **true**), `prefer_unminified` (bool, default false),
`allow_remote` (bool, default false). Schema in `config/schema/assetfetcher.schema.yml`,
install defaults in `config/install/assetfetcher.settings.yml`.

## Key mechanism

- In `adjustSources()`, a source is a candidate only when `type === 'external'` **and** its
  `data` contains `//` (matches any scheme incl. protocol-relative). If `enabled`, it calls
  `fetch()`; on success sets `data` = root-relative local path and `type` = `file`.
- `fetch()` first checks for an existing `libraries/<path>` copy (via `parseLibraryPaths()`,
  which knows googleapis/cdnjs/aspnetcdn/jsdelivr/unpkg URL layouts). Otherwise it downloads
  with core `system_retrieve_file($uri, …)` to a tempname, runs SRI (`checkFile()`) if the
  library declared `attributes.integrity`, then `move()`s into `public://assetfetcher/…`
  (flat path from `mapUriToLocalPath()`). SRI failure deletes the temp file and throws.
- The fetched URL comes from module/theme **`.libraries.yml` definitions**, not from request
  input. TLS verification is core's default (`system_retrieve_file` → guzzle). See the
  config doc for the full flow.
