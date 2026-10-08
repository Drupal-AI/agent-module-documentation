# Request Cleanup — manual setup guide

**Request Cleanup** (`request_cleanup`) is a small performance module that
**strips ignored query parameters** from incoming URLs before Drupal processes
them, so tracking parameters don't fragment your internal page cache. Marketing
links routinely arrive with parameters like `utm_source`, `utm_medium`,
`utm_campaign`, or Facebook's `fbclick` — parameters Drupal doesn't need but which
make each URL look unique to the page cache, forcing it to store a separate copy
for every variation.

Request Cleanup runs as a **stack middleware**: it removes the configured
parameters early, so `https://example.com/node/1?utm_source=ad1` is handled as
`https://example.com/node/1`, and `.../search?query=Findme&fbclick=111234322`
keeps the meaningful `query` parameter while dropping `fbclick`. The result is
fewer redundant cache entries and a higher cache hit-rate. It supports Drupal 10
and 11 and needs no other modules.

By default it removes four parameters: `fbclick`, `utm_campaign`, `utm_source`,
and `utm_medium`. You can override that list in `settings.php` (see below) — there
is **no admin settings form**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no configuration page**. Its one setting is a `settings.php`
override, documented below.

## How to configure the parameter list

Request Cleanup works as soon as it is enabled, stripping its four default
parameters. To change which parameters are removed, add a line to your site's
`settings.php` listing the full set you want stripped:

```php
$settings['request_cleanup.get'] = ['fbclick', 'utm_source', 'utm_medium', 'utm_campaign', 'yourparameter'];
```

The array **replaces** the default list, so include the defaults you still want
alongside any new parameters. After editing `settings.php`, clear the cache
(`drush cr`).

## Notes and limitations

- **If you use an external cache (e.g. Varnish) and can administer it,** it is
  better to strip unneeded parameters there so requests never reach Drupal at all.
  See the getpagespeed.com guide on stripping Varnish query parameters.
- **If you use an external cache but can't administer it,** keep Drupal's internal
  page cache on with real storage — that is, do **not** uncomment this line in
  `settings.php`:

  ```php
  //$settings['cache']['bins']['page'] = 'cache.backend.null'
  ```

  Request Cleanup then still helps the internal page cache.
