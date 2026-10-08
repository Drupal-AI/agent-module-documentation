# Configuration

File Cache has **no admin UI**. Everything is configured in `settings.php` (or
`settings.local.php`). The two required steps are: point cache bins at the
backend, and tell the backend where to store files. The rest is optional tuning.

## 1. Point cache bins at the backend

To move **every** bin onto the file system:

```php
$settings['cache']['default'] = 'cache.backend.file_system';
```

Or move only specific bins (a common, safer starting point):

```php
$settings['cache']['bins']['entity'] = 'cache.backend.file_system';
$settings['cache']['bins']['page']   = 'cache.backend.file_system';
```

## 2. Configure storage directories (required)

You **must** tell File Cache where to write, or it throws "No path has been
configured for the file system cache backend." The directory must be **outside
the web root** and **owner-only** (`chmod 700`) — cache files can hold sensitive
rendered content and must never be web-accessible. Absolute paths and stream
wrappers both work; File Cache creates a per-bin subdirectory automatically.

```php
// Default location for all file-cached bins:
$settings['filecache']['directory']['default'] = '/var/cache/filecache';

// Optional per-bin override:
$settings['filecache']['directory']['bins']['entity'] = 'private://filecache/entity';
```

> **Tip:** pointing the directory at a `tmpfs` RAM disk gives you very fast cache
> reads, at the cost of the cache being cleared on reboot.

## 3. Cache strategy (optional)

Each bin can use one of two strategies:

- **Standard** (default) — cache files are deleted on a general cache rebuild
  (`drush cr`), matching normal Drupal behaviour.
- **Persist** — cache files **survive** a general rebuild. This is ideal for data
  fetched from slow external services that you don't want to re-fetch on every
  `drush cr`. The trade-off: persist mode doesn't fully conform to the cache API
  (individual deletes and bin removals still work), so test it before relying on
  it in production.

```php
use Drupal\filecache\Cache\FileSystemBackend;

// Persist a specific bin:
$settings['filecache']['strategy']['bins']['entity'] = FileSystemBackend::PERSIST;

// Or a default strategy for all file-cached bins:
$settings['filecache']['strategy']['default'] = FileSystemBackend::PERSIST;
```

## 4. Serializer / compression (optional)

By default cache entries are serialized with core's `phpserialize` serializer. To
compress files on disk, override the backend's serializer with `igbinary_gz` (from
the igbinary module). This is a services-file override, e.g. in a
`sites/default/services.yml`:

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

- **Run CLI cache commands as the web-server user** so cache files keep the right
  ownership — e.g. `sudo -u www-data drush cr`. Running as root or your own user
  can leave files the web server can't read or overwrite.
- The **Status report** (`/admin/reports/status`) includes File Cache self-checks
  — a quick way to confirm directories and permissions are correct.
- Before uninstalling the module, remove all `$settings['filecache']` and the
  related `$settings['cache']` entries first (see
  [Installation](../installation/index.md)).
