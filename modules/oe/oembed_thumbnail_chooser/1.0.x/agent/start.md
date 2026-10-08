<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# oEmbed Thumbnail Chooser (oembed_thumbnail_chooser) — agent index

Rewrites the thumbnail URL that YouTube and Vimeo return through core's oEmbed media source, stepping
**down from the highest resolution to whatever actually exists**, so remote-video media get a crisp
poster image instead of core's default soft `hqdefault` (480×360) / `295x166` thumbnail. The entire
module is a single `.module` file implementing one alter hook — **no routes, no services, no
permissions, no config, no config schema, no forms, no plugins, no drush, no submodules.** Version
**1.0.0-beta2**. Core `^8.9 || ^9 || ^10 || ^11`. Depends only on core **`media`**.

`oembed_thumbnail_chooser_oembed_resource_data_alter(array &$data, $url)` branches on a substring of
the resolved provider endpoint `$url` and probes higher-resolution variants of
`$data['thumbnail_url']` with `\Drupal::httpClient()->get()`, keeping the first variant that responds
without a `GuzzleHttp\Exception\RequestException`:
- **YouTube** (`$url` contains `youtube.com/oembed`): `hqdefault` → try `maxresdefault` → try
  `sddefault` → fall back to the original URL.
- **Vimeo** (`$url` contains `vimeo.com/api/oembed`): the `295x166` size token → try `1280` → try
  `960` → fall back to the original; on success it also rewrites `$data['thumbnail_width']` /
  `$data['thumbnail_height']` (1280×720 or 960×540) so image styles compute from real dimensions.
- Any other provider passes through untouched.

The GET is a **reachability probe only** — the downloaded body is discarded; core performs the real
thumbnail download and storage afterwards, using the (possibly rewritten) `$data['thumbnail_url']`.
The probed host is always the provider's own CDN (`i.ytimg.com` / `i.vimeocdn.com`) as it appears in
the trusted YouTube/Vimeo oEmbed response — the module only swaps a size token in the path, never the
host, and the value is not an editor-typed URL.

**Cost:** up to **two extra synchronous outbound HTTP GETs per oEmbed fetch**, inside the request that
creates or refreshes the media item. `get()` downloads the full image body where a `HEAD` would answer
the question, and **no explicit timeout** is set (inherits the site's Guzzle default). Watch bulk
imports of remote videos.

**Important compatibility caveat:** stock Drupal core invokes `hook_oembed_resource_url_alter()` but
does **not** invoke `hook_oembed_resource_data_alter()` — there is no `alter('oembed_resource_data')`
call in `core/modules/media`. As the project page states, this module relies on the core patch from
drupal.org issue **#3042423** to expose that alter hook. On an unpatched core the module installs
cleanly but its hook is **never called** (a no-op). Verify the patch is present before expecting any
thumbnail rewriting.

## What you'd do → where
Everything lives in the one hook. For the full mechanism (branches, size-token ladders, `$data`
keys, the compatibility caveat, and how to add a provider) → [api/oembed-alter.md](api/oembed-alter.md).
Or read `oembed_thumbnail_chooser.module` directly.

## Key facts (real machine names)
- **File:** `oembed_thumbnail_chooser.module` — the module's only PHP.
- **Hook implemented:** `oembed_thumbnail_chooser_oembed_resource_data_alter($data, $url)`
  (an implementation of core Media's `hook_oembed_resource_data_alter`, patch-provided — see caveat).
- **`$data` keys read/written:** `thumbnail_url` (both providers); `thumbnail_width` +
  `thumbnail_height` (Vimeo success paths only).
- **HTTP client:** `\Drupal::httpClient()` → `->get($probeUrl)`; failures caught as
  `GuzzleHttp\Exception\RequestException` (`use GuzzleHttp\Exception\RequestException;`).
- **Provider triggers (substring match on `$url`):** `youtube.com/oembed`, `vimeo.com/api/oembed`.
- **Size-token rewrites:** YouTube `hqdefault`→`maxresdefault`→`sddefault`; Vimeo `295x166`→`1280`→`960`.
- **Routes / services / permissions / config / schema / plugin types / drush / libraries:** none.
- **Depends on:** `drupal:media`. **Core:** `^8.9 || ^9 || ^10 || ^11`. **Package:** Media.
