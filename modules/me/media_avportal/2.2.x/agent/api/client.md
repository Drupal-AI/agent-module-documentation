# API client, resource object, stream wrapper, refresh service

## The client service

`media_avportal.client` is an `AvPortalClient` (`src/AvPortalClient.php`) produced by the factory
service `media_avportal.client_factory` (`AvPortalClientFactory::getClient()`), which is constructed
with `@http_client`, `@config.factory`, `@cache.default`, `@datetime.time`. Inject
`media_avportal.client` for a cached client, or build an uncached one explicitly:

```php
$client = \Drupal::service('media_avportal.client_factory')->getClient(['use_cache' => FALSE]);
```

### `AvPortalClientInterface`

| Method | Behavior |
|---|---|
| `query(array $options): ?array` | GETs `client_api_uri` with the options as query string. Returns `['num_found' => int, 'resources' => [ref => AvPortalResource, …]]` (empty structure on failure). |
| `getResource(string $ref): ?AvPortalResource` | `query(['ref' => $ref])` then `resources[$ref]`. |
| `getThumbnail(AvPortalResource $resource): ?string` | Downloads the thumbnail bytes; for `PHOTO`/`REPORTAGE` prepends `photos_base_uri`; returns the body only on HTTP 200. |
| `resourceRequestByUri(string $uri): ResponseInterface` | Raw GET of a URI (used by the stream wrapper to stream a photo file). |

`query()` merges defaults into the options: `fl` (field list
`type,ref,doc_ref,titles_json,duration,shootstartdate,media_json,mediaorder_json,summary_json,languages`),
`hasMedia=1`, `wt=json`, `index=1`, `pagesize=15`, `type=VIDEO,PHOTO,REPORTAGE`. It **rejects
unsupported asset types** — any `type` outside `AvPortalClient::ALLOWED_TYPES`
(`VIDEO`, `PHOTO`, `REPORTAGE`) throws `\InvalidArgumentException`. Guzzle `RequestException`s are
swallowed and treated as an empty response.

### Response caching

Non-empty responses are cached under cid `media_avportal:client:query:<serialize(options)>` for
`cache_max_age` seconds (or `Cache::PERMANENT`), tagged with the settings config's cache tags so
changing `media_avportal.settings` invalidates them. Caching is disabled when `use_cache` is FALSE or
`cache_max_age === 0`. (`media_avportal_post_update_enable_response_cache` set the default age to 3600.)

## `AvPortalResource` value object

`src/AvPortalResource.php` wraps one `docs` entry from the API (constructor throws if `ref` is absent).

- `getRef()`, `getType()`, `getData()`.
- `getTitle(string $langcode = 'EN')` — picks the localized title (EN fallback), `Html::decodeEntities`,
  `strip_tags`, then truncates to 255 chars on a word boundary with an ellipsis.
- `getCaption(string $langcode = 'EN')` — `summary_json` for `PHOTO`, `legend_json` for `REPORTAGE`.
- `getPhotoUri()` — `media_json.HIGH.PATH`.
- `getThumbnailUrl()` — for `VIDEO`, the first `media_json` entry's `THUMB` by language preference
  (`INT`, site default, `EN`, then resource languages); for `PHOTO`/`REPORTAGE`, `media_json`
  `MED`→`LOW`→`HIGH` `PATH`.

## Stream wrapper — `avportal://`

Service `media_avportal.photo_stream_wrapper` (`tags: stream_wrapper, scheme: avportal`) is
`AvPortalPhotoStreamWrapper`, extending abstract `AvPortalStreamWrapper` → core `ReadOnlyStream`. It is
**read-only** (`getType()` = `StreamWrapperInterface::READ`; `unlink()` is a no-op). Stream wrappers
cannot use DI, so the client is lazy-loaded via `\Drupal::service('media_avportal.client')`.

`getExternalUrl()` returns `photos_base_uri . AvPortalResource::getPhotoUri()`. `stream_open()` /
`url_stat()` resolve the ref (`getPath()` strips the trailing `.jpg`) and stream the remote file via
`resourceRequestByUri()`. The `.jpg` suffix in `avportal://REF.jpg` (added by the photo formatters)
exists only so core's image toolkit recognises the URI as a JPG when building image styles.

## Metadata refresh service

`media_avportal.media_updater` (`AvPortalMediaUpdater`) exposes
`refreshMappedFields(?array $media_ids = NULL)`: it loads the media (all when `NULL`), and for each
entity whose source `provider` is `media_avportal` it forces core to re-map the source metadata by
cloning `$entity->original` and nulling its source-field value (so `hasSourceFieldChanged()` returns
TRUE), then saves — pulling fresh title/thumbnail from the portal. Each update is logged to the
`avportal_media` channel. This is what the Drush command drives (see
[../drush/commands.md](../drush/commands.md)).
