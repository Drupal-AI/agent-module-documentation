<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Absolute URLs (rest_absolute_urls) — agent index

Rewrites root-relative URLs to absolute in serialised string values. Depends on core `serialization`.
Core requirement `^8 || ^9 || ^10 || ^11`. No routes, no permissions, no admin UI, no shipped config.

## Mechanism (the whole module)
- One service: `Drupal\rest_absolute_urls\Normalizer\StringDataNormalizer`, extending core
  `PrimitiveDataNormalizer`, tagged `normalizer` at **priority 6** — one above core's priority-5
  string normalizer, so it takes over normalising **every `StringInterface`** typed-data value in
  **any** serialization (JSON:API, REST, custom). Specialised normalizers at priority 20
  (datetime, timestamp, password) still win for their types.
- `normalize()` calls the parent, then returns
  `Html::transformRootRelativeUrlsToAbsolute($value, $base_url)`. That core helper loads the value
  as an HTML fragment and prefixes `$base_url` onto root-relative URLs (leading `/`, **not** `//`)
  inside URI attributes: `href`, `src`, `srcset`, `poster`, `cite`, `data`, `action`, `formaction`,
  `about`.
- Base URL source: config `rest_absolute_urls.base_url`; if empty, fallback is
  `Request::createFromGlobals()->getSchemeAndHttpHost()` (current request scheme+host).

## Configuration
- Only knob, set in `settings.php`:
  `$config['rest_absolute_urls']['base_url'] = 'https://example.com';`
- Set it whenever the requesting host is not the public host: behind a reverse proxy / CDN, or when
  a Docker/node.js SSR renderer calls Drupal by container name (`http://nginx/`). The auto-detected
  host also depends on `trusted_host_patterns` and reverse-proxy settings — get those wrong and the
  absolute URLs are wrong in the API while the browser looks fine, so the bug is usually found late.
- The value must be scheme+host(+port) only. A value containing a path trips a core assertion in
  development builds.

## Caveats
- Applies to **all** string primitives, not just formatted-text fields. Every serialised string is
  round-tripped through `Html::load()`/`Html::serialize()`, so plain-text values can be re-encoded
  (a bare `&` becomes `&amp;`, stray markup normalised).
- Only rewrites root-relative URLs found inside HTML URI attributes; bare path strings and values
  core already emits absolute are untouched.

## Deeper docs
- `agent/serialization/normalizer.md` — full normalizer behaviour, priority interaction, base-URL
  resolution and edge cases.
