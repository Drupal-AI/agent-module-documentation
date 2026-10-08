<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Asset Fetcher — configuration & operation

## Install / enable

`composer require drupal/assetfetcher` then `drush en assetfetcher`. No module dependencies
(core only). On enable, `config/install/assetfetcher.settings.yml` ships with
`enabled: true`, `prefer_unminified: false`, `allow_remote: false` — so it starts localizing
external assets immediately.

## Where you configure it

There is **no dedicated settings route**. `assetfetcher_form_alter()` →
`AssetFetcherConfig::hookFormAlter()` (`src/AssetFetcherConfig.php`) injects a fieldset named
**"Asset Fetcher"** into the core Performance form when `$formId === 'system_performance_settings'`
(page `/admin/config/development/performance`, route `system_performance_settings`, permission
`administer site configuration`). info.yml `configure: system.performance_settings` points the
module's "Configure" link there. Three checkboxes, all written to `assetfetcher.settings` by
`submitForm()`, which then `Cache::invalidateTags(['library_info'])` so rewrites take effect:

| Setting (`assetfetcher.settings`) | Default | Effect |
|---|---|---|
| `enabled` | `true` | Master switch. When off, external sources are left remote and merely annotated. |
| `prefer_unminified` | `false` | Before fetching `foo.min.js`, first try `foo.js` (regex `~\.min(\.js\|\.css)$~`) for better debugging DX; falls back to the original on failure. |
| `allow_remote` | `false` | When a fetch fails: `false` = replace with an invalid local filename `--assetfetcher-could-not-fetch/…` (hard-fail, GDPR-safe); `true` = leave the original remote URL loading. |

Config schema: `config/schema/assetfetcher.schema.yml` (`assetfetcher.settings` mapping, three
booleans). Read via `AssetFetcherConfig::enabled()/preferUnminified()/allowRemote()`.

## How assets are localized (`AssetFetcher::adjustSources()`)

Called from `hook_css_alter`/`hook_js_alter` for every asset source. A source is rewritten only if:

- `$info['type'] === 'external'`, **and**
- `strpos($info['data'], '//') !== FALSE` (matches `https://`, `//host/…`, `s3://`, etc.).

For matches, if `enabled`:

1. If `prefer_unminified`, try the de-minified URL first via `fetch()`.
2. Otherwise (or on fallback) `fetch($assetUri, $integritySpec, $fileType)` where
   `$integritySpec = $info['attributes']['integrity']` (may be null).
3. On success: `$info['data']` = root-relative local path (via `toRootRelativePath()`),
   `$info['type'] = 'file'`, plus a bookkeeping key `assetfetcher_could_fetch`.
4. On failure (throwable caught, logged to channel `assetfetche`): the source is annotated
   `assetfetcher_could_not_fetch`; if `!allow_remote`, `data` is set to the sentinel
   `--assetfetcher-could-not-fetch/<uri>` so the broken asset is obvious rather than silently
   leaking to the CDN.

**Only libraries that route through the core asset pipeline are covered.** CSS `@import`s and
font `url()` includes are not (noted in the enable-checkbox description).

## `fetch()` internals (`src/AssetFetcher.php`)

1. **Local library reuse first.** `parseLibraryPaths($uri)` recognizes the URL layout of
   `ajax.googleapis.com`, `cdnjs.cloudflare.com`, `ajax.aspnetcdn.com`, `cdn.jsdelivr.net`,
   `unpkg.com` and yields candidate `libraries/<lib>@<ver>/<path>` (and unversioned) paths;
   if `libraries/<path>` exists on disk it is returned as-is (no download).
2. **Download.** Else map to `public://assetfetcher/<flattened-dir>/<file>.<ext>` via
   `mapUriToLocalPath()` (URL parts flattened with `--`; `/` in the path → `--`; missing
   extension → `txt`). If that local file doesn't already exist, download to a tempname with
   core `system_retrieve_file($uri, $tmp, FALSE, EXISTS_REPLACE)`. A false return throws
   `RuntimeException("Can not retrieve uri …")`.
3. **SRI.** If `$integritySpec` present, `SubResourceIntegrityChecker::checkFile()` reads the
   temp file and compares `hash($algo, $data, TRUE)` against the base64 hash for each
   space-separated option (`sha256`/`sha384`/`sha512`). Any match returns; no match throws
   `SubResourceIntegrityException`, the temp file is **deleted**, and `fetch()` rethrows — an
   asset that fails integrity is never served.
4. **Commit.** `prepareDirectory(CREATE_DIRECTORY|MODIFY_PERMISSIONS)` then `move()` temp →
   `public://assetfetcher/…`. Returns that URI (later converted to a Drupal-root-relative path
   because of core issue 2735717).

SRI is thus computed over the **downloaded local bytes against the library's own declared
hash** — the URL and hash both come from trusted module/theme library definitions, not from
request input.

## Status report (`AssetFetcherRequirements`)

`hook_requirements('runtime')` walks every module/theme library
(`library.discovery` → `getLibrariesByExtension`), runs `adjustSources()` over each, and on
`/admin/reports/status` lists which external assets **could** be fetched (severity OK, with a
remote→local link) and which **could not** (severity ERROR, with the failure message), or
"no remote assets to fetch." Purely diagnostic; changes no state.

## Operating notes

- Toggling any setting invalidates `library_info` cache so new/changed rewrites apply; a full
  `drush cr` also refreshes the on-disk `public://assetfetcher/` copies (deletion on cache
  rebuild is a `@todo`, not yet implemented).
- For strict GDPR/privacy keep `allow_remote: false` so a fetch failure is a visible error, not
  a silent CDN call.
- Class comments mark the engine/config/interfaces `@internal`; call the service
  `assetfetcher.service`, don't depend on class internals.
