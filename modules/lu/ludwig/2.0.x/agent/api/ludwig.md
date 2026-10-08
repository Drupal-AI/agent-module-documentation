# Declaring libraries & how they autoload

Ludwig has no `*.api.php` hooks. The "API" is the **`ludwig.json` declaration format** a
module ships, plus two services and a service provider that consume it.

## 1. Declare libraries — `ludwig.json` (in the module root)

```json
{
  "require": {
    "doctrine/collections": {
      "version": "v1.4.0",
      "url": "https://github.com/doctrine/collections/archive/v1.4.0.zip"
    },
    "commerceguys/addressing": {
      "version": "v1.0.0-beta3",
      "url": "https://github.com/commerceguys/addressing/archive/v1.0.0-beta3.zip"
    }
  }
}
```

- Key = the package name (`vendor/name`). Value = `version` + archive `url` (a `.zip`).
- Ludwig downloads each into `<module>/lib/<vendor>-<name>/<version>/` (slashes in the
  package name become dashes for the directory).
- **Per-core-version deps:** append space-separated core majors to the key, e.g.
  `"vendor/name d9 d10"`. Ludwig keeps the entry only when the running core major
  (`d9`/`d10`/`d11`, from `\Drupal::VERSION`) is in the list.

## 2. Discovery & status — `ludwig.package_manager`

`Drupal\ludwig\PackageManager` (arg: `%app.root%`) implements `PackageManagerInterface`:

```php
$packages = \Drupal::service('ludwig.package_manager')->getPackages();
```

`getPackages()` scans every profile and module with `ExtensionDiscovery` (works even for
**non-installed** extensions), reads each `ludwig.json`, then reads the **downloaded
library's own `composer.json`** to learn its `autoload` section, namespace, paths and
status. Duplicate packages across modules resolve to the highest version (others
`Overridden`).

## 3. Autoloading — `LudwigServiceProvider`

`Drupal\ludwig\LudwigServiceProvider::register()` runs at container-build time. For every
package whose status is `Installed` and whose resource is `psr-4` or `psr-0`, it merges the
library's paths into Drupal's `container.namespaces` parameter (converting PSR-0 layouts as
needed). This is why **PSR-4/PSR-0 libraries autoload automatically** with no cache of
package data.

## 4. `classmap` / `files` libraries — `ludwig.require_once`

These are **not** autoloaded automatically. The requiring module must call the
`ludwig.require_once` service (`Drupal\ludwig\RequireOnce`) from its `.module`/`.install`:

```php
\Drupal::service('ludwig.require_once')
  ->requireOnce('vendor/name', 'src/functions.php', __DIR__);
```

`requireOnce($package_name, $file_to_require, $dir_name)` reads the caller's `ludwig.json`
for the pinned `version`, then `require_once`s
`<dir>/lib/<vendor>-<name>/<version>/<file_to_require>`. Ludwig detects this call in the
`.module` file and flips the package's status from `Not installed` to `Installed` on the
report.

## Downloading in code — `ludwig.package_downloader`

`Drupal\ludwig\PackageDownloader` (`download(array $package)`) is what the report controller
calls; it fetches, extracts and copies one package. You normally trigger it by visiting the
Packages report rather than calling it directly.
