<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Iterator (entity_iterator) — agent index

**Memory-efficient PHP utility to iterate huge entity sets in chunks, evicting each from the entity memory cache. Code-only, no web surface.**

- **Version:** 1.2.x  •  core: `^8 || ^9 || ^10`  •  package: Other.
- **Class:** `Drupal\entity_iterator\EntityIterator` implements Iterator, ArrayAccess, Countable.
- **Ctor:** `(string $entity_type_id, array $ids = NULL, int $chunk_size = 50, string $bundle = NULL)`. NULL ids → load all; chunks via `array_chunk`; loads with `loadMultiple`; clears `entity.memory_cache` per entity.
- **No routes/forms/permissions/config.**

**Security (reviewed, sound):** the internal ID query uses `->accessCheck(FALSE)` by design; this is a low-level maintenance utility with no HTTP entry point. Access enforcement is the caller's responsibility, as with any Drush/update-hook script. Not reachable by web users.
