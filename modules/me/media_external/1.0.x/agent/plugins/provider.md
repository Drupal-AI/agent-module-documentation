# Media External — the `media_external_provider` plugin type

## Discovery
- Manager service: `plugin.manager.media_external_provider` → `ExternalMediaProviderManager`
  (`src/Plugin/ExternalMediaProviderManager.php`), a `DefaultPluginManager`.
- Directory: `Plugin/media/ExternalMediaProvider` in any module's namespace.
- Annotation: `@ExternalMediaProvider` (`src/Annotation/ExternalMediaProvider.php`) — properties `id`,
  `label`.
- Alter hook: `hook_external_provider_info_alter`. Cache key `external_provider_plugins`.
- Interface: `ExternalMediaProviderInterface` (`src/Plugin/ExternalMediaProviderInterface.php`).

## Interface to implement
```php
public function search(string $keyword, int $page = 1): array; // ['total','per_page','current_page','results']
public function load(string $id): \Drupal\media_external\ExternalMedia;
```
- `search()` returns a result set: `results` is an array of `ExternalMedia` value objects, plus `total` and
  `per_page` used to build the Media Library pager. Note: callers pass `$page` 0-indexed; the shipped
  providers add 1 for provider APIs that start at page 1.
- `load($id)` returns a single `ExternalMedia` for a stored external ID (used when reading media metadata).

## The `ExternalMedia` value object (`src/ExternalMedia.php`)
Immutable DTO. Constructor:
`new ExternalMedia($id, $url, $thumbnail_url, $description = '', $alt = '', $photographer = '', $photographer_url = '')`
with getters `getId/getUrl/getThumbnailUrl/getDescription/getAlt/getPhotographer/getPhotographerUrl`.

## Reference implementations
- `Pexels` (id `pexels`): GET `https://api.pexels.com/v1/search` / `/photos/{id}`, header
  `Authorization: <Settings::get('media.external_provider.pexels.api_key')>`.
- `Unsplash` (id `unsplash`): GET `https://api.unsplash.com/search/photos` / `/photos/{id}`, header
  `Authorization: Client-ID <Settings::get('media.external_provider.unsplash.access_key')>`.

Both extend `PluginBase`, implement `ContainerFactoryPluginInterface`, and inject `@http_client` (Guzzle).
To add a provider: create a class in `Plugin/media/ExternalMediaProvider/`, annotate it, read your API key
from `Settings::get(...)` (keep it in `settings.php`), map the API response into `ExternalMedia` objects, and
it becomes selectable in any External-media type's source configuration.

## Caching
Search/load calls go through `media_external.cache.wrapper` (`ExternalMediaCacheWrapper`, custom cache bin
`cache.media_external`), so provider API responses are cached rather than hit on every request.
