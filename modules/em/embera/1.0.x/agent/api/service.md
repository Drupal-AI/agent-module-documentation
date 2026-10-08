<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `embera.manager` service

Everything this module offers is the service `embera.manager`, class
`Drupal\embera\EmberaServiceManager` (`src/EmberaServiceManager.php`). Registered in
`embera.services.yml` with arguments `['@file_system', '@settings']`.

## Install / enable

- `composer require drupal/embera` (pulls `mpratt/embera:^2.0` into `/vendor/`), then
  `drush en embera`.
- `embera.install` → `embera_requirements($phase)` sets a status-report row "Embera (PHP Library)"
  = *Enabled* when `class_exists('\Embera\Embera')`, else `REQUIREMENT_ERROR`.
- Declare `dependencies: - embera:embera` in your module and depend on the service; do not install
  it standalone.

## Construction (constructor logic)

`__construct(FileSystemInterface $fileSystem, Settings $settings)` creates a single
`\Embera\Embera` object held in `$this->embera`:

- `$writablePath = $fileSystem->getTempDirectory()`.
- If `Settings::get('embera.file.cache.disabled', FALSE)` is falsy (the default): wraps an
  `\Embera\Http\HttpClient` in `\Embera\Http\HttpClientCache`, sets a
  `\Embera\Cache\Filesystem($writablePath, $duration)` caching engine where
  `$duration = Settings::get('embera.file_cache.duration', 3600)` seconds, and builds
  `new Embera($configuration, NULL, $httpCache)`.
- Otherwise builds `new Embera($configuration)` with no HTTP cache.
- In both branches `$configuration = Settings::get('embera.class.configuration', [])` is passed as
  Embera's constructor options.

## Methods

- `getEmbedInformation($url)` — calls `$this->embera->getUrlData([$url])` and returns the first
  result array (or NULL). Uses a function-`static $urls` per-request cache keyed by URL, so a repeated
  URL in the same request is fetched once.
- `getThumbnailUrl($url)` — returns `getEmbedInformation($url)['thumbnail_url']`, or `FALSE` if empty.
- `getTitle($url)` — returns the info's `title`, else its `description`, else `''`.
- `getEmbedCode($url)` — returns `$this->embera->autoEmbed($url)` (the provider's HTML embed markup).

## Configuration (via `Settings`, not config entities)

There is no config object, no schema, and no admin form. All tuning is through `settings.php`
`$settings[...]` (read with `Settings::get`):

- `embera.file.cache.disabled` (default `FALSE`) — set `TRUE` to disable the on-disk HTTP cache.
- `embera.file_cache.duration` (default `3600`) — cache lifetime in seconds.
- `embera.class.configuration` (default `[]`) — array of options forwarded to the `\Embera\Embera`
  constructor (see the library's "Passing configuration options" docs for supported keys).

## Usage example

```php
$manager = \Drupal::service('embera.manager');
$html  = $manager->getEmbedCode('https://www.youtube.com/watch?v=…');
$thumb = $manager->getThumbnailUrl('https://vimeo.com/…');
```

## Notes

- Provider matching, HTTP fetching, and embed-HTML generation all happen inside the vendored
  `mpratt/embera` library; this module only wires it to Drupal's `file_system` (temp dir) and
  `Settings`.
- The disk cache lives in the site temp directory; the per-request static cache is independent of it.
