<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The oEmbed resource-data alter hook

The whole module is one procedural function in `oembed_thumbnail_chooser.module`:

```php
function oembed_thumbnail_chooser_oembed_resource_data_alter(array &$data, $url)
```

It is an implementation of core Media's `hook_oembed_resource_data_alter($data, $url)`, invoked while
core's oEmbed `ResourceFetcher` parses a provider response into a `Resource`. `$data` is the decoded
oEmbed payload (by reference); `$url` is the provider's resolved oEmbed endpoint URL that core chose
from its trusted providers list.

## Install / enable
- `composer require drupal/oembed_thumbnail_chooser` then `drush en oembed_thumbnail_chooser -y`.
- Depends only on core `media`. No config, no settings form, no permissions — enabling is the whole
  setup. Re-save existing remote-video media to refresh their thumbnails through the hook.

## Branching (substring match on `$url`)
- **YouTube** — `strpos($url, 'youtube.com/oembed') !== FALSE`.
- **Vimeo** — else if `strpos($url, 'vimeo.com/api/oembed') !== FALSE`.
- **Anything else** — falls through untouched; `$data` is returned unchanged.

## Resolution ladders (rewrite a size token in `$data['thumbnail_url']`, keep the first that responds)
For each candidate, the module calls `\Drupal::httpClient()->get($thumbnailUrl)` and treats a thrown
`GuzzleHttp\Exception\RequestException` (`use GuzzleHttp\Exception\RequestException;`) as "does not
exist", stepping to the next candidate.

- **YouTube:** `str_replace('hqdefault', 'maxresdefault', …)` → on failure
  `str_replace('hqdefault', 'sddefault', …)` → on failure keep the original `$data['thumbnail_url']`.
  Only `thumbnail_url` is written.
- **Vimeo:** `str_replace('295x166', '1280', …)` → on failure `str_replace('295x166', '960', …)` →
  on failure keep the original. On the **1280** success path it also sets
  `$data['thumbnail_width'] = '1280'` / `['thumbnail_height'] = '720'`; on the **960** path
  `'960'` / `'540'`, so downstream image styles size from real dimensions.

The GET is a **reachability probe only** — the response body is discarded. Core still performs the
real thumbnail download/store afterward using the (possibly rewritten) `$data['thumbnail_url']`, which
always points at the provider's own CDN (`i.ytimg.com` / `i.vimeocdn.com`); the module swaps only a
size token in the path, never the host.

## Cost
Up to **two extra synchronous outbound HTTP GETs per oEmbed fetch**, inside the request that creates or
refreshes the media item. `get()` downloads the full image body where a `HEAD` would answer the same
question, and **no explicit timeout** is set (inherits the site's Guzzle default). Watch bulk imports
of remote videos.

## Compatibility caveat (important)
Stock Drupal core invokes `hook_oembed_resource_url_alter()` but does **not** invoke
`hook_oembed_resource_data_alter()` — there is no `alter('oembed_resource_data')` call in
`core/modules/media`. Per the project page, this module relies on the core patch from drupal.org issue
**#3042423** to expose that hook. On unpatched core the module installs cleanly but the hook is
**never called** (a no-op). Confirm the patch is applied before expecting any rewriting.

## Extending it
To support another provider or size token, edit the single function: add a branch keyed on a substring
of `$url` and an ordered ladder of `str_replace()` candidates against `$data['thumbnail_url']`, keeping
the first that returns without a `RequestException`. There are no plugins, services, or config to wire.
