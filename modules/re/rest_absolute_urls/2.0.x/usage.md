<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST Absolute URLs rewrites root-relative URLs in serialised string values to absolute ones, so an API consumer receives image sources and links it can actually resolve.

---

Drupal stores links and image sources as root-relative paths (`/sites/default/files/photo.jpg`, `/node/12`), which are correct inside a rendered page and useless in an API response consumed from another origin. This module installs one service — a `StringDataNormalizer` extending core's `PrimitiveDataNormalizer` and registered as a `normalizer` at **priority 6**, one above core's priority-5 string normalizer — so it wins for every `StringInterface` typed-data value in any serialization (JSON:API, REST, or a custom serializer), not only formatted-text fields. For each string it takes the parent-normalized value and passes it through `Html::transformRootRelativeUrlsToAbsolute($value, $base_url)`, which parses the value as an HTML fragment and prefixes `$base_url` onto any root-relative URL (leading `/` but not protocol-relative `//`) found in URI attributes (`href`, `src`, `srcset`, `poster`, `cite`, `data`, `action`, `formaction`, `about`). The base URL comes from the config override `rest_absolute_urls.base_url`; if that is unset it falls back to `Request::createFromGlobals()->getSchemeAndHttpHost()` — the scheme and host of the current request. There is no admin UI, no route, no permission and no shipped config: the only knob is the settings.php override `$config['rest_absolute_urls']['base_url'] = 'https://example.com';`, which you should set whenever the requesting host is not the public host — behind a reverse proxy or CDN, or when a server-side renderer (Docker/node.js) calls Drupal by its container name (`http://nginx/`). Two behaviours to keep in mind: because it applies to *all* string primitives, every serialised string is round-tripped through the DOM parser (`Html::load()`/`Html::serialize()`), so plain-text values can be re-encoded (e.g. a bare `&` becomes `&amp;`); and the base URL must be scheme+host(+port) only — a value with a path trips a core assertion in development builds.

---

- Return absolute image URLs to a decoupled front end fetching JSON:API.
- Give a mobile app resolvable links and image sources without client-side URL prefixing.
- Fix images that render in Drupal but break in a React/Angular/Vue front end on another origin.
- Rewrite root-relative URLs once, at the serialisation layer, for every REST consumer.
- Serialise `href`/`src`/`srcset` values a consumer can follow or load directly.
- Feed a static site generator content with usable absolute URLs.
- Provide absolute URLs in an exported feed or downstream integration.
- Set `$config['rest_absolute_urls']['base_url']` to force the public host behind a proxy or CDN.
- Override the base URL when a Docker/node.js SSR renderer reaches Drupal by container name (`http://nginx/`).
- Avoid inconsistent, duplicated base-URL prefixing scattered across consumer code.
- Depend only on core `serialization`; install and enable, no configuration required for the common case.
- Apply uniformly to CKEditor-embedded images in body fields exposed over REST.
- Support a headless / progressively-decoupled architecture where Drupal is the API origin.
- Reduce per-consumer URL-handling bugs in a decoupled build.
- Cover any serializer that normalises string primitives, not just JSON:API.
- Keep relative URLs inside the site while emitting absolute URLs to external clients.
- Note that it only rewrites root-relative URLs inside HTML URI attributes — not bare path strings, not link/file field `uri` values that core already exposes absolute.
- Expect plain-text string fields to be DOM round-tripped, which may re-encode entities.
- Set the base URL explicitly whenever `trusted_host_patterns`/reverse-proxy settings could make the auto-detected host wrong.
