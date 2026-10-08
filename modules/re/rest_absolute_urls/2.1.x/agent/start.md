<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Absolute URLs (rest_absolute_urls) — agent index

Rewrites root-relative URLs to absolute in serialised formatted-text, processed text and rendered
markup. Depends on core `serialization`. Core requirement `^11.3 || ^12`. No routes, no permissions,
no admin UI, no shipped config.

## Mechanism (the whole module)
Three `normalizer` services, each taking `@config.factory`, each delegating to
`Html::transformRootRelativeUrlsToAbsolute($value, $base_url)`:

- `Drupal\rest_absolute_urls\Normalizer\StringDataNormalizer` — extends core
  `PrimitiveDataNormalizer`, `getSupportedTypes()` = `StringInterface`, **priority 6** (one above
  core's priority-5 string normalizer). Unlike earlier releases it does **not** rewrite every
  string: `normalize()` calls the parent, then rewrites **only** when `isFormattedText()` is true —
  i.e. the parent field item declares a property whose `text source` setting names this string
  (the raw markup of a formatted-text field, e.g. `value`/`summary`). All other strings (titles,
  plain fields) are returned unchanged and are **not** DOM round-tripped.
- `Drupal\rest_absolute_urls\Normalizer\TextProcessedNormalizer` — extends `NormalizerBase`,
  `getSupportedTypes()` = `Drupal\text\TextProcessed`, **priority 6**. `TextProcessed` extends
  `TypedData` directly and is **not** a `StringInterface`, so the string normalizer skips it; this
  one covers the computed `processed` output. Adds the object as a cacheable dependency, then
  rewrites `(string) $object->getValue()`.
- `Drupal\rest_absolute_urls\Normalizer\MarkupNormalizer` — extends `NormalizerBase`,
  `getSupportedTypes()` = `Drupal\Component\Render\MarkupInterface`, **priority 10**. Rewrites every
  `MarkupInterface` value handed to the serializer. Main case: the Views REST Export "Fields" row
  plugin renders each field to a `Markup` value that `StringDataNormalizer` never sees.

- The core helper `Html::transformRootRelativeUrlsToAbsolute()` loads the value as an HTML fragment
  and prefixes `$base_url` onto root-relative URLs (leading `/`, **not** `//`) inside URI
  attributes: `href`, `src`, `srcset`, `poster`, `cite`, `data`, `action`, `formaction`, `about`.
- Base URL source (all three normalizers): config `rest_absolute_urls.base_url`; if empty, fallback
  is `Request::createFromGlobals()->getSchemeAndHttpHost()` (current request scheme+host).

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
- Rewriting is scoped to formatted text, processed text and markup — plain-text string primitives
  are no longer rewritten or DOM round-tripped (behavioural narrowing vs 2.0.x, where every string
  primitive was processed and could be re-encoded).
- Only rewrites root-relative URLs found inside HTML URI attributes; bare path strings and values
  core already emits absolute are untouched.
- Views "Raw output" field option returns a plain scalar that bypasses every normalizer, so those
  URLs are not rewritten; use the Entity row plugin or turn Raw output off.

## Deeper docs
- `agent/serialization/normalizer.md` — the three normalizers, priority interaction, base-URL
  resolution, the formatted-text gate and edge cases.
