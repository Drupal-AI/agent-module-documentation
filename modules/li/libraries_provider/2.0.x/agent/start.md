<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Libraries Provider (libraries_provider) — agent index

Lets a **module or theme** declare *how* each of its external front-end libraries is served, and lets the **site** override that choice: jsDelivr CDN vs. local `/libraries`, version, minification, variant, and library-replacement — all applied at runtime through `hook_library_info_alter`. Version **2.0.4**, core `^10 || ^11`, PHP `>=8.0`, GPL-2.0-or-later.

## What it actually does
- A declaring extension adds a `libraries_provider` key to a `*.libraries.yml` entry (keys: `enabled`, `source`, `npm_name`, `minified`, `variant`, `variants_available`, `variant_regex`, `replaces`, `blacklist_releases`, `custom_options`). Without that key a library is ignored entirely.
- `src/AutoEventSubscriber/LibrariesReplacements.php` subscribes to `core_event_dispatcher`'s `LibraryInfoAlterEvent` (i.e. `hook_library_info_alter`). For each managed library it merges defaults, overlays a saved `library` config entity, resolves minification against `system.performance`, and rewrites every `css`/`js` path through a **LibrarySource plugin**.
- Two ship: `cdn.jsdelivr.net` (`src/Plugin/LibrarySource/CdnJsdelivrNet.php`, builds `https://cdn.jsdelivr.net/npm/<npm_name>@<version>/…`, versions from the jsDelivr data API via `upstreamable/jsdelivr-api-client`) and `local` (`src/Plugin/LibrarySource/Local.php`, serves `/libraries/<asset-packagist-name>`, version from `package.json`).
- Overrides persist as a `library` **config entity** `libraries_provider.library.<extension>__<name>` (double underscore). `src/Entity/Library.php` `postSave`/`preDelete` clear the library-discovery cache and, if `custom_options` are set, compile SASS variables into the library's CSS file via the `sassphp` PHP extension.
- The base module has **no route, no UI, no permission**. The **`libraries_provider_ui`** submodule adds the config-entity list/edit/revert forms at `/admin/structure/libraries`, gated by the `administer libraries` permission (also depends on `form_options_attributes`).

## Dependencies are non-trivial
Requires `hook_event_dispatcher` (`core_event_dispatcher ^4`) and `autoservices ^1` — both architectural modules. Also needs the PHP libs `php-http/guzzle7-adapter` and `upstreamable/jsdelivr-api-client` (composer-only install). For a one-off single-library case, core `libraries-override` in a theme is the smaller intervention. Reach for this module when you have several libraries to expose, or a hard requirement — a **CSP** enumerating hosts, a **privacy/GDPR** ban on third-party requests, or an **offline/restricted** network — and want site builders to flip CDN↔local per library from config.

## Where to look
- `config/` — declaring a library (`libraries_provider` YAML keys), the `library` config entity, schema, tokens.
- `api/` — the `LibrarySource` plugin type and how to add a new source/CDN; the alter event.
- `submodules/` — `libraries_provider_ui` admin screen, permission, forms.

## Notes for agents
- No integrity/SRI attribute is emitted on CDN-served assets; pair with something like `external_script_sri` if supply-chain integrity matters.
- The `local` source assumes asset-packagist naming (`@scope/pkg` → `scope--pkg` under `/libraries`).
- Two tokens exist: `[library:version]`, `[library:variant]`.
