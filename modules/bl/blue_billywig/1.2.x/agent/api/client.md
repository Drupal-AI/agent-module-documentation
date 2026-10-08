# `blue_billywig.client` service (`BlueBillywigClient`)

The single service wrapping the Blue Billywig SAPI (via `bluebillywig/bb-sapi-php-sdk`). Get it with
`\Drupal::service('blue_billywig.client')` or inject `@blue_billywig.client`. All methods no-op /
return empty when the API is not configured (publication + key + secret missing).

Constructor deps: `@config.factory`, `@keyvalue`, `@datetime.time`, `@cache.default`. The SDK is
lazily built via `Sdk::withRPCTokenAuthentication(publication, key, secret)` from
`blue_billywig.settings`.

## Public methods

| Method | Returns | Purpose |
|---|---|---|
| `validateApi(string $key, string $secret, string $publication): bool` | bool | Live-check credentials (`GET /sapi/playout`). Empty secret falls back to the stored one. Used by the settings form. |
| `load(string $id): ?MediaClip` | MediaClip\|null | Load one clip (`GET /sapi/mediaclip/{id}`). |
| `embedCode(string $id, string $playout, string $embed_type): string` | string | Platform embed markup for a clip/playout/type. Cached 1h (tags `blue_billywig:embed`, `blue_billywig:embed:{id}`). |
| `search(string $keyword, int $page = 0, ?int $limit = NULL): array` | array | Search published clips by title. Returns `total`/`per_page`/`current_page`/`results` (MediaClip[]). Keyword is Solr-escaped; scoped to `client_id` (`klantnaam`). Page size `SEARCH_LIMIT` = 32. |
| `playouts(): array` | array | Active playouts as `id => name` (cached 1h, tag `blue_billywig:playouts`). |
| `getContentProtectionPolicies(): array` | array | Active CPP policies: each `code`/`name`/`hideContent`/`rulesets`. Throws `BlueBillywigApiException` if the list endpoint fails; per-policy detail failures are tolerated. Cached 1h (tag `blue_billywig:cpp_policies`). |
| `uploadFile(string $title, string $path): ?MediaClip` | MediaClip\|null | Server-side upload path: create clip + push file via SDK (fallback, non-Uppy). |
| `initializeUpload(string $filename, int $filesize, string $content_type): ?array` | array\|null | Create a clip and request presigned S3 URLs (`mediaclipId`, `key`, `uploadId`, `chunks`, `presignedUrls`, `chunkSize`). Records the clip in key-value `blue_billywig.s3.uploads`. Cleans up the orphan clip on failure. |
| `completeUpload(string $key, string $upload_id, array $parts): bool` | bool | Finalize a multipart S3 upload. |
| `abortUpload(string $key, string $upload_id): bool` | bool | Abort a multipart S3 upload. |
| `update(string $id, array $data): bool` | bool | Update clip metadata. |
| `delete(string $id): bool` | bool | Delete a clip (`DELETE /sapi/mediaclip/{id}`). |
| `requestAccessibility(string $mediaclip_id): bool` | bool | Submit a Scribit.Pro transcription job (audio description, subtitles, transcript; `nl-nl`, male voice). |

Constants: `KEY_VALUE_S3_UPLOADS = 'blue_billywig.s3.uploads'`,
`UNCOMPLETED_S3_UPLOADS_LIMIT = 14400` (4h), `SEARCH_LIMIT = 32`.

## Internals worth knowing

- `call()` swallows failures and returns `[]` (after logging); `callOrThrow()` throws
  `BlueBillywigApiException` — use the latter when you must distinguish "remote error" from "empty".
  `callOrThrow()` catches `\Throwable` so SDK `Error`s don't WSOD callers.
- `escapeSolrQuery()` backslash-escapes Solr reserved chars per-character before the caller appends a
  trailing `*` wildcard — this is the sanitization on the search keyword path.
- The other consumer service, `blue_billywig.media_library_search` (`MediaLibrarySearch`), wraps
  `search()` for the media library add form (Ajax results + pager); route
  `blue_billywig.media_library_search` reuses core's `media_library.ui_builder:checkAccess`.

## `MediaClip` value object (`Object\MediaClip`)

Wraps a clip's API array with a base URL: exposes id, title (falls back to `originalfilename`),
description, and thumbnail (default 400×225). Used throughout search/load results.

## Example

```php
$client = \Drupal::service('blue_billywig.client');
$results = $client->search('interview', 0);      // ['total'=>…, 'results'=>MediaClip[]]
$embed   = $client->embedCode($clipId, $playoutId, 'iframe');
$clip    = $client->load($clipId);
```
