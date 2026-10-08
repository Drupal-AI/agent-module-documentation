<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Cache — agent index

A file-system cache backend (`cache.backend.file_system`). No UI, permissions, schema, or Drush —
all configuration is in `settings.php`. Depends on nothing (PHP ^8.1).

- **All settings.php keys: choosing bins, directories, strategy, serializer** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Service `cache.backend.file_system` → `Drupal\filecache\Cache\FileSystemBackendFactory`
  → `FileSystemBackend`. Default serializer `@serialization.phpserialize`.
- A path is REQUIRED per bin (or a default); missing path throws
  "No path has been configured for the file system cache backend."
- Strategy constants: `FileSystemBackend::STANDARD` (default; cleared on general cache clear) and
  `FileSystemBackend::PERSIST` (survives general clears).
