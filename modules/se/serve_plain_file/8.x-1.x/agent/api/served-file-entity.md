<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ServedFile entity API (cache-purge integration)

For code that reacts to served-file changes (e.g. purging Varnish/CDN caches). The entity is a
config entity, so standard `hook_ENTITY_TYPE_insert/update/delete()` fire for `served_file`.

## Interface

`src/Entity/ServedFileInterface.php` (extends `ConfigEntityInterface`), implemented by
`src/Entity/ServedFile.php`:

- `getPath(): string` — stored path (no leading slash).
- `getContent(): string` — the file body.
- `getContentHead(): string` — first ~20 chars of the first line + `" ... "` (used by the list
  builder).
- `getFileMaxAge(): int` — cache max-age in seconds.
- `getMimeType(): string` — configured MIME-Type (may be empty; controller falls back to
  `text/plain`).
- `getLinkToFile(): \Drupal\Core\Link` — an absolute `Link` to the served path (ignores language
  prefixing).
- `getUrlsForCachePurging(): string[]` — absolute URLs to purge. Returns the current path's URL,
  and — when the path was just changed — also the **original** path's URL
  (`$this->original->path`), so a rename purges both the old and new URL.

## Cache-purge hook example (from README)

```php
use Drupal\serve_plain_file\Entity\ServedFile;

/**
 * Implements hook_ENTITY_TYPE_update().
 */
function my_module_served_file_update(ServedFile $entity) {
  $urls = $entity->getUrlsForCachePurging();
  my_module_purge_external_caches($urls);
}

/**
 * Implements hook_ENTITY_TYPE_delete().
 */
function my_module_served_file_delete(ServedFile $entity) {
  $urls = $entity->getUrlsForCachePurging();
  my_module_purge_external_caches($urls);
}
```

`getUrlsForCachePurging()` builds each URL via the protected `pathToUrl()`, which composes
scheme + host + path from an absolute `Url::fromUri('internal:/'.$path)` and strips any language
path prefix — appropriate for CDN/Varnish keys.

## Loading / listing programmatically

Load via the entity type manager: `\Drupal::entityTypeManager()->getStorage('served_file')`, e.g.
`->loadMultiple()` (as the dynamic route builder does) or
`->loadByProperties(['path' => $p, 'langcode' => $lc])` (as the controller does). Saving an entity
should be followed by a `router.builder` rebuild so its dynamic serving route is (de)registered —
the add/edit and delete forms do this for you.
