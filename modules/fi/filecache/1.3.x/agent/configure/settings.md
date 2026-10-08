<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure (settings.php only)

There is no admin UI. All configuration is in `settings.php` / `settings.local.php`.

## 1. Point cache bins at the backend

```php
// All bins:
$settings['cache']['default'] = 'cache.backend.file_system';

// Or specific bins only:
$settings['cache']['bins']['entity'] = 'cache.backend.file_system';
$settings['cache']['bins']['page']   = 'cache.backend.file_system';
```

## 2. Configure storage directories (REQUIRED)

The directory MUST be outside the webroot and owner-only (chmod 700). Absolute paths or stream
wrappers are both accepted; File Cache creates per-bin subdirectories automatically.

```php
$settings['filecache']['directory']['default'] = '/var/cache/filecache';
// Per-bin override:
$settings['filecache']['directory']['bins']['entity'] = 'private://filecache/entity';
```

`FileSystemBackendFactory::getPathForBin()` resolves per-bin first, then `default/<bin>/`, else
throws. Storing the directory on a `tmpfs` RAM disk is supported for speed.

## 3. Cache strategy (optional, per bin or default)

```php
use Drupal\filecache\Cache\FileSystemBackend;
$settings['filecache']['strategy']['default'] = FileSystemBackend::PERSIST;
$settings['filecache']['strategy']['bins']['entity'] = FileSystemBackend::PERSIST;
```

- `STANDARD` (default): files are deleted on a general cache clear (`drush cr`).
- `PERSIST`: files survive a general clear (good for cached external-service data). Not fully
  cache-API-conforming — individual deletes / bin removals still delete files. Test before prod.

## 4. Serializer / compression (optional, via services.yml override)

Default serializer is `@serialization.phpserialize`. To compress on disk, override the factory
service argument with e.g. `@serialization.igbinary_gz` (from the `igbinary` module):

```yaml
services:
  cache.backend.file_system:
    class: Drupal\filecache\Cache\FileSystemBackendFactory
    arguments:
      - '@file_system'
      - '@settings'
      - '@datetime.time'
      - '@cache_tags.invalidator.checksum'
      - '@serialization.igbinary_gz'
      - '@logger.factory'
```

## Operational notes

- Run CLI cache commands as the web-server user (`sudo -u www-data drush cr`) so file ownership is
  correct.
- Remove all `$settings['filecache']` entries before uninstalling the module.
- The Status report page shows File Cache self-checks.
