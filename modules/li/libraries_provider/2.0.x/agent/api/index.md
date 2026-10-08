<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Developer API: the `LibrarySource` plugin type and the alter flow

## The alter flow (`hook_library_info_alter`)

`src/AutoEventSubscriber/LibrariesReplacements.php` implements `EventSubscriberInterface` and listens on `ThemeHookEvents::LIBRARY_INFO_ALTER` (the `LibraryInfoAlterEvent` from `core_event_dispatcher`, i.e. core `hook_library_info_alter`). Registration is automatic via the `autoservices` module (the `AutoEventSubscriber` namespace), so there is no `libraries_provider.services.yml`.

Per library carrying a `libraries_provider` key, `replace()`:
1. `getLibraryDefaults()` — fills defaults (`id`, `name`, `npm_name`, `minified: when_aggregating`, empty `replaces`/`variant`/`variants_available`/`blacklist_releases`).
2. `normalizeLibrary()` — keys the `replaces` list.
3. `applyConfigurationReplacements()` — loads the `library` config entity (`storage('library')->load("$ext__$name")`) and overlays `version`, `enabled`, `source`, `minified`, `variant`, `replaces`.
4. `replaceByOtherLibraries()` — if another library entity lists this one in its `replaces`, this library is force-disabled and gains a dependency on the replacer.
5. If enabled: instantiate the target and original `LibrarySource` plugins and run every `css` component and the `js` array through `replaceComponent()`, which canonicalises the original path, decides minification against `system.performance`, and asks the target plugin for the new path (`type` becomes `file` for `local`, else `external`). If disabled: `disableLibrary()` voids the assets.

## The `LibrarySource` plugin type

Annotation-based plugin type provided by this module:
- Manager: `src/AutoPluginManager/LibrarySourcePluginManager.php` (extends `DefaultPluginManager`); discovery dir `Plugin/LibrarySource`, interface `LibrarySourceInterface`, annotation `@LibrarySource`, alter hook `libraries_provider_sources_info`, cache key `libraries_provider_sources`. Auto-registered as a service via `autoservices` (`AutoPluginManager` namespace); referenced by class name in the container.
- Annotation: `src/Annotation/LibrarySource.php` — only an `id`.
- Interface: `src/Plugin/LibrarySource/LibrarySourceInterface.php` — `getAvailableVersions(string $libraryId)`, `getCanonicalPath(string $path)`, `getPath(string $canonicalPath, array $library)`, `isAvailable(string $libraryId): bool`.
- Base: `src/Plugin/LibrarySource/LibrarySourceBase.php` — `ContainerFactoryPluginInterface`, injects `library.discovery`; provides `getLibrary()`, `getAvailabilityMessage()`, and `applyVariants()` (regex-swaps the variant segment).

### Shipped plugins
- `cdn.jsdelivr.net` (`CdnJsdelivrNet.php`) — id `cdn.jsdelivr.net`. Builds `https://cdn.jsdelivr.net/npm/<npm_name>@<version><canonicalPath>` and appends `.min` when serving minified. `getAvailableVersions()`/`isAvailable()` call the jsDelivr data API (`https://data.jsdelivr.com/v1/`, npm) through `Upstreamable\JsdelivrApiClient` (built on `php-http/guzzle7-adapter`); `blacklist_releases` are removed from the version list; a missing npm package yields an availability notice and disables the option. Uses HTTPS with the client's default TLS verification.
- `local` (`Local.php`) — id `local`. Serves `/libraries/<name>` where `<name>` follows asset-packagist rules (`@scope/pkg` → `scope--pkg`). `getAvailableVersions()` reads `<localPath>/package.json`; `isAvailable()` checks the directory exists, else emits a "download and extract to …" notice.

### Adding a source
Create `Plugin/LibrarySource/MySource.php` in your module with `@LibrarySource(id = "my.cdn")` extending `LibrarySourceBase`, implement the four interface methods, and reference the new id as `source:` in a library's `libraries_provider` key (and/or let admins pick it in the UI). No service registration needed.

## Query service

`src/Autoservice/LibrariesProviderManager.php` (auto-service, referenced by class name): `getManagedLibraries()` returns every discovered library with a `libraries_provider` key keyed by `ext__name`; `getCustomOptionsRequirements()` returns unmet requirements before custom options can be applied.
