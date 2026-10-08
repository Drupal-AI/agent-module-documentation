<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST Absolute URLs rewrites root-relative URLs in serialised formatted-text and rendered markup to absolute ones, so an API consumer receives image sources and links it can actually resolve.

---

Drupal stores links and image sources as root-relative paths (`/sites/default/files/photo.jpg`, `/node/12`), which are correct inside a rendered page and useless in an API response consumed from another origin. This module installs three `normalizer` services that cover the serialization paths such content travels: a `StringDataNormalizer` (priority 6) for formatted-text string properties, a `TextProcessedNormalizer` (priority 6) for the computed `processed` output of text fields, and a `MarkupNormalizer` (priority 10) for any `MarkupInterface` value the serializer receives. Each resolves a base URL — the config override `rest_absolute_urls.base_url`, falling back to `Request::createFromGlobals()->getSchemeAndHttpHost()` (the scheme and host of the current request) — and passes the value through `Html::transformRootRelativeUrlsToAbsolute($value, $base_url)`, which parses it as an HTML fragment and prefixes `$base_url` onto any root-relative URL (leading `/` but not protocol-relative `//`) found in URI attributes (`href`, `src`, `srcset`, `poster`, `cite`, `data`, `action`, `formaction`, `about`). A key difference from older releases: `StringDataNormalizer` no longer touches every string primitive — it checks the parent field item's property definitions and only rewrites a string whose `text source` setting names it (i.e. the raw markup of a formatted-text field such as `value` or `summary`), so plain-text fields, titles and ordinary strings are returned untouched and are no longer round-tripped through the DOM parser. The `TextProcessedNormalizer` exists because `Drupal\text\TextProcessed` extends `TypedData` directly and does not implement `StringInterface`, so it would otherwise be skipped; the `MarkupNormalizer` exists because some callers (notably the Views REST Export "Fields" row plugin) hand the serializer rendered `Markup` values rather than typed data. There is no admin UI, no route, no permission and no shipped config: the only knob is the settings.php override `$config['rest_absolute_urls']['base_url'] = 'https://example.com';`, which you should set whenever the requesting host is not the public host — behind a reverse proxy or CDN, or when a server-side renderer (Docker/node.js) calls Drupal by its container name (`http://nginx/`). The base URL must be scheme+host(+port) only — a value with a path trips a core assertion in development builds. Requires Drupal core 11.3 or later (including 12).

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
- Rewrite the computed `processed` text output of a formatted-text field, not just its raw `value`.
- Cover Views REST Export displays: both the Entity and Fields row plugins have their markup rewritten.
- Support a headless / progressively-decoupled architecture where Drupal is the API origin.
- Reduce per-consumer URL-handling bugs in a decoupled build.
- Cover any serializer that normalises formatted text, processed text or markup, not just JSON:API.
- Keep relative URLs inside the site while emitting absolute URLs to external clients.
- Rely on it rewriting only formatted-text/markup values now — plain strings, titles and non-text fields are left untouched (no DOM round-trip, no entity re-encoding).
- Note that it only rewrites root-relative URLs inside HTML URI attributes — not bare path strings, and not link/file field `uri` values core already exposes absolute.
- Expect raw-output Views fields to be skipped: "Raw output" returns a plain scalar that bypasses every normalizer, so its URLs stay relative.
- Set the base URL explicitly whenever `trusted_host_patterns`/reverse-proxy settings could make the auto-detected host wrong.
