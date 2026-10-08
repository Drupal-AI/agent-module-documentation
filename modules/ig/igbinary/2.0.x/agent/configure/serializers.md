# Configure: point a backend at the igbinary serializers

The module has **no settings form and no `configure` route**. "Configuring" it means overriding the
service definition of a cache / key-value / queue backend so that it uses one of this module's
serialization services instead of core's default `serialization.phpserialize`. The module ships an
`example.services.yml` with ready-made overrides.

## Two ways to enable

**A. Include the shipped example file** (edit `sites/default/settings.php`):

```php
$settings['container_yamls'][] = $app_root . '/modules/contrib/igbinary/example.services.yml';
```

**B. Copy the overrides you want into `sites/default/services.yml`** (more selective). The relevant
factory services and the argument you swap to a serializer:

| Service overridden | Factory class | Serializer argument |
| --- | --- | --- |
| `keyvalue.database` | `Drupal\Core\KeyValueStore\KeyValueDatabaseFactory` | `@serialization.igbinary_gz` |
| `keyvalue.expirable.database` | `Drupal\Core\KeyValueStore\KeyValueDatabaseExpirableFactory` | `@serialization.igbinary_gz` |
| `cache.backend.database` | `Drupal\Core\Cache\DatabaseBackendFactory` | `@serialization.igbinary_gz` |
| `cache.backend.redis` | `Drupal\redis\Cache\CacheBackendFactory` | `@serialization.igbinary_gz` |

The `cache.backend.database` override keeps the `{ name: backend_overridable }` tag so per-bin
overrides via `$settings['cache']['bins']` still work. The `cache.backend.redis` line requires the
contrib `drupal/redis` module. Swap `@serialization.igbinary_gz` for `@serialization.igbinary`
(no compression) or `@serialization.phpserialize_gz` (compression only, no igbinary extension) as needed.

Example (verbatim shape from `example.services.yml`):

```yaml
services:
  cache.backend.database:
    class: Drupal\Core\Cache\DatabaseBackendFactory
    arguments:
      - '@database'
      - '@cache_tags.invalidator.checksum'
      - '@settings'
      - '@serialization.igbinary_gz'
      - '@datetime.time'
    tags:
      - { name: backend_overridable }
```

Rebuild the container after editing (`drush cr`).

## The one tunable: compression level

The `*_gz` services read a single **settings.php** value (not Drupal config):

```php
$settings['igbinary_compress_level'] = 6; // default is 1
```

It is passed straight to `gzcompress($data, $level)` (zlib levels `0`–`9`; higher = smaller but more
CPU). Read via `Settings::get('igbinary_compress_level', 1)` in `CompressionTrait::compressData()`.
There is no `config/schema` and no config object — nothing to export.

## Operational caveats

- **Requires the igbinary PECL extension** compiled into PHP for the `serialization.igbinary*` services
  (`composer.json` declares `ext-igbinary` and `ext-zlib`). Without it those services are inert.
  `serialization.phpserialize_gz` needs only `ext-zlib`.
- **Switching a live backend must be paired with a cache flush.** New reads auto-detect old formats
  (see [../api/services.md](../api/services.md)) so most stores survive the switch, but a full
  `drush cr` after changing a cache backend avoids mixed-format churn.
- Anywhere serialized data is *persisted* rather than merely cached (a queue mid-drain, a long-lived
  key/value record) the same auto-detection applies on read, but plan the switch deliberately.
