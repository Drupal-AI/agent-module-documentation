<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flickr API service

`Drupal\flickr_integration_suite\FlickrIntegrationSuiteApiProvider`, service id
**`flickr_integration_suite.api_provider`**. This is the module's reusable public surface — other
modules can inject or fetch it (`\Drupal::service('flickr_integration_suite.api_provider')`) to
call Flickr without dealing with keys, HTTP, or caching.

## Construction

Constructor args (from `flickr_integration_suite.services.yml`): `@config.factory`,
`@key.repository`, `@http_client_factory`, `@messenger`, `@cache.default`. On construction it reads
`flickr_integration_suite.settings` for `api_endpoint` and `api_cache_max_age`, and resolves the
`api_key` config value (a Key machine name) to the raw key via `key.repository`. If no key is
configured/resolvable, `$flickrApiKey` stays empty.

## request(array $parameters): mixed

Low-level call used by every helper. Behavior:

- If no API key is set, adds a Messenger **error** linking to the settings form and returns
  `FALSE` (no request made).
- If `extras` is present and lacks `media`, appends `,media`.
- Builds a cache id `flickr_integration_suite:<md5>` from the ksort-ed, concatenated params. Returns
  the cached decoded array on hit.
- On miss, sends a Guzzle **GET** to `api_endpoint` with `['query' => $parameters]` (TLS
  verification at Guzzle defaults — enabled). Decodes JSON to an associative array.
- If the payload has `stat == 'fail'`, surfaces the Flickr `message` as a Messenger error (the
  API key is **not** included in the message).
- Caches the decoded array for `api_cache_max_age` seconds when that value is non-zero.

Note: `request()` is `public`, so a caller can invoke any Flickr REST method by passing its own
`method` + params (the helpers below just preset common ones). The helpers add `format => json`,
`nojsoncallback => 1`, and the resolved `api_key`.

## Preset helper methods

- `photosetsGetPhotos(string $photoset_id, int $per_page = 50, int $page = 1, string $media = 'all', string $extras = ''): bool|array`
  — `flickr.photosets.getPhotos`.
- `galleriesGetPhotos(string $gallery_id, int $per_page = 50, int $page = 1, string $extras = '', int $get_user_info = 0, int $get_gallery_info = 0): array`
  — `flickr.galleries.getPhotos`.
- `photosGetSizes(string $photo_id): bool|array` — `flickr.photos.getSizes` (used by the slider
  preprocess to pick photo/video source URLs, and by the filter helper to size images).
- `photosGetInfo(string $photo_id): bool|array` — `flickr.photos.getInfo` (title, owner, urls,
  description; used by the filter).

Return shape mirrors the raw Flickr JSON (e.g. `['stat' => 'ok', 'photoset' => ['photo' => [...]]]`).
Callers check `$data['stat']` themselves. IDs are passed straight through as query params to the
fixed endpoint — there is no user-supplied URL fetch (no SSRF surface).
