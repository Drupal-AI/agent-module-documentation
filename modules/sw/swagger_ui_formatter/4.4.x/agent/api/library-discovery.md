# Swagger UI library discovery & install

The Swagger UI JavaScript library is **not bundled in the rendered output** by default — the
module locates it at runtime through a swappable service, then registers a Drupal asset library
for it in `hook_library_info_build` (`swagger_ui_formatter.module`).

## The discovery service

Service id: `swagger_ui_formatter.swagger_ui_library_discovery` — an **alias**. Two concrete
implementations (both extend the abstract `SwaggerUiLibraryDiscoveryBase`, cache into
`cache.default`):

| Service | Class (`src/SwaggerUiLibraryDiscovery/…`) | Locates |
|---|---|---|
| `…swagger_ui_library_discovery.downloaded` (**default alias target**) | `SwaggerUiLibraryDiscoveryFromDownloadedArtifact` | A prebuilt Swagger UI dist under `[web root]/libraries/swagger-ui` (folder must be named `swagger-ui`, files in `dist/`). |
| `…swagger_ui_library_discovery.bundled` | `SwaggerUiLibraryDiscoveryFromNodeManagedBundledAssets` | The npm `swagger-ui-dist` assets bundled inside the module. |

Interface `SwaggerUiLibraryDiscoveryInterface`: `libraryDirectory(): string` and
`libraryVersion(): string`; throws `SwaggerUiLibraryDiscoveryExceptionInterface` when the
library is missing/invalid. (`src/Service/SwaggerUiLibraryDiscovery.php` is a **deprecated**
BC bridge, removed in 5.0.0 — don't depend on it.)

## Switch to the bundled npm assets

Add to your site's `sites/*/services.yml` (or a module's `*.services.yml`):

```yml
services:
  swagger_ui_formatter.swagger_ui_library_discovery:
    alias: swagger_ui_formatter.swagger_ui_library_discovery.bundled
```

## Install the downloaded library (default mode)

- Manual: download a Swagger UI release, rename the folder to `swagger-ui`, place at
  `[web root]/libraries/swagger-ui` (so `…/libraries/swagger-ui/dist/swagger-ui-bundle.js`).
- Composer (asset-packagist): require `npm-asset/swagger-ui-dist` with a `web/libraries/{$name}`
  installer path, or use the module's `drupal-scaffold` file-mapping (see the module
  `composer.json`) to scaffold the dist files into `web/libraries/swagger-ui/dist`.
- Minimum supported Swagger UI is `3.32.2` (first version with the needed security fixes).

## Override the resolved directory (hook)

Only invoked for the default theme (and base themes) when the *downloaded-artifact* discovery
is active (`swagger_ui_formatter.api.php`):

```php
function hook_swagger_ui_library_directory_alter(string &$library_dir): void {
  $library_dir = '/my/custom/path/to/swagger-ui/';
}
```
To change discovery wholesale, swap the `SwaggerUiLibraryDiscoveryFromDownloadedArtifact`
service instead.

## Status / requirements (`hook_requirements`)

- Reports the detected Swagger UI **version** and install **path** on the status report and at
  install time (severity OK, or ERROR with the discovery exception message when missing).
- For downloaded-artifact discovery with library ≥ `5.29.0`, warns if
  `dist/oauth2-redirect.js` is missing — Swagger UI moved OAuth2 redirect JS out of
  `oauth2-redirect.html`, and its absence disables OAuth2 authentication. Fix by re-scaffolding
  the dist files.

## Programmatic access

```php
$discovery = \Drupal::service('swagger_ui_formatter.swagger_ui_library_discovery');
$dir = $discovery->libraryDirectory();   // e.g. 'libraries/swagger-ui'
$ver = $discovery->libraryVersion();     // e.g. '5.29.2'
```
`hook_cache_flush` calls `reset()` on the discovery service so a swapped/updated library is
re-detected on a cache rebuild.
