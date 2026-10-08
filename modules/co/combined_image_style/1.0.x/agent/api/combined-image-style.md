<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CombinedImageStyle entity & fluent API

`src/Entity/CombinedImageStyle.php` — extends `src/Entity/ImageStyle.php`, which extends core
`Drupal\image\Entity\ImageStyle`. This is an **in-memory helper object, not a saved config entity**;
you construct it, set a source URI and a list of styles, and ask it for a URI/URL/render array. All
derivative generation reuses core `ImageStyle` machinery.

## Construction & fluent setters

- `new CombinedImageStyle()` — plain constructor (no id).
- `->setSourceUri(string $uri)` — the original image URI (e.g. `public://cat.jpg`). Stored in a
  private `$sourceUri`.
- `->setImageStyles(array $styles)` — array of style ids **or** `ImageStyleInterface` objects; each
  scalar is resolved with `ImageStyle::load()` and non-loadable entries are dropped
  (`array_filter`). Replaces the current list.
- `->addImageStyle($style)` — append one (id or object).
- `->hasImageStyles()` / `->getImageStyles()` — presence / the resolved `ImageStyleInterface[]`.

## Identity & folder scheme

- `id()` = `implode('-', [styleId1, styleId2, ...])` over the loaded styles (SEPARATOR constant is
  `'-'`). This string is the `styles/<id>/…` derivative folder name and exactly what
  `CombinedImageStyle::fromName()` parses back (see routing doc). **Note:** the derivative directory
  is keyed by this hyphen-joined id, so combining the same set of styles in a different order (or
  repeating an id) yields a different folder and a distinct derivative.
- `static fromName(string $name)` — `explode('-', $name)` → `ImageStyle::loadMultiple($ids)` →
  `new static()->setImageStyles(...)`. Used by the delivery controller to rebuild the object from the
  URL path segment. Unknown ids simply don't load (empty/partial style set), they are never used as a
  filesystem path.
- `static loadCombinedBySingle(ImageStyleInterface $style)` — scans every writable stream wrapper's
  `styles/` directory (non-recursive) for folder names matching `/.*<id>.*/` and rebuilds a
  `CombinedImageStyle` per match. Drives the flush cascade below.

## Effects, dimensions, output

- `getEffects()` — lazily builds one `ImageEffectPluginCollection` by taking each listed style's
  effects (`->getEffects()->getIterator()` → each effect's `getConfiguration()`) and
  `array_merge`-ing them **in list order** into a single pipeline. So `square-thumbnail` runs
  square's effects, then thumbnail's, on one source.
- `getPathToken($uri)` — **overridden**; instead of one HMAC it emits a hyphen-joined string of
  per-style 8-char `Crypt::hmacBase64` tokens (each keyed by that style's private key + hash salt on
  `styleId:uriWithExtension`). This is the itok the delivery route validates. Detailed in the routing
  doc.
- `getDimensions($uri)` — computes width/height by loading the source through `image.factory` and
  running `transformDimensions()`, **memoized in the custom `cache.image_dimensions` bin** keyed by
  the derivative URI. `getWidth()`/`getHeight()` read from it.
- `buildCombinedUri()` — `buildUri($sourceUri)` → the derivative URI (`scheme://styles/<id>/…`).
- `buildCombinedUrl(?bool $clean_urls = NULL)` — the absolute URL, appending the itok query
  (`getPathToken`) unless `image.settings:suppress_itok_output` is TRUE; mirrors core's clean-URL /
  insecure-derivative handling. Uses `DeprecationHelper` for the `ImageStyleInterface::TOKEN` vs
  legacy `IMAGE_DERIVATIVE_TOKEN` constant across core versions.
- `toImage()` — a `#theme => 'image'` render array with `#uri => buildCombinedUrl()` and computed
  width/height.
- `createDerivative($original, $derivative, $overwrite = FALSE)` — delegates to core
  `createDerivative`, then invalidates the `image_dimensions` cache entry for the new file; returns
  whether the file now exists.

## Flush cascade (cache correctness)

`src/Entity/ImageStyle.php` overrides:

- `postSave()` — invalidates cache tags; on rename, flushes the old style and calls
  `replaceImageStyle()` to fix field settings; otherwise flushes only when the effect configuration
  actually changed.
- `flush($path)` — before delegating to the parent, calls
  `CombinedImageStyle::loadCombinedBySingle($this)` and flushes **every combined derivative that
  includes this style**, so editing a building-block style clears all combined derivatives built from
  it. `CombinedImageStyle::flush()` additionally deletes the `image_dimensions` cache entry for its
  derivative URI.
