<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# photoswipe_inline — filter mechanism & configuration

Single plugin: `\Drupal\photoswipe_inline\Plugin\Filter\PhotoswipeInline`
(`src/Plugin/Filter/PhotoswipeInline.php`), `id: photoswipe_inline`, title
"PhotoSwipe Inline Text Filter", `type: TYPE_TRANSFORM_IRREVERSIBLE`, `weight: -10`. No settings,
no config schema, no permissions.

## The rewrite (`process($text, $langcode)`)
1. `$text = '<div class="photoswipe-gallery">' . $text . '</div>';` — the outer gallery wrapper
   PhotoSwipe uses to scope a gallery.
2. `$dom = Html::load($text);` — parse to a DOMDocument (core `Html` helper).
3. `$elements = $dom->getElementsByTagName('img');` — if none, serialize and return unchanged.
4. For each `<img>`:
   - **Ancestor-anchor skip:** walk `parentNode` upward; if any ancestor `nodeName === 'a'`,
     `continue 2` (skip this image entirely — an already-linked image is left as a link).
   - **Existing-class skip:** if the image has a `class` attribute whose value *contains* the
     substring `photoswipe`, skip it (an editor opt-out convention).
   - Otherwise:
     - `createElement('a')`, `insertBefore` it before the image, then `appendChild` the image into
       the anchor (moves the `<img>` inside the new `<a>`).
     - `$source = $element->getAttribute('src'); $anchor->setAttribute('href', $source);` — the
       anchor href is the **image src, copied verbatim**.
     - Dimension logic (see below) sets `data-pswp-width` / `data-pswp-height`.
     - Class: if the image has a class, anchor class = `"<img class> photoswipe"`; otherwise
       `"photoswipe"`.
5. `return new FilterProcessResult(Html::serialize($dom));`

Markup is constructed entirely through **DOMDocument APIs** (`createElement`, `setAttribute`,
`insertBefore`, `appendChild`). Attribute values are entity-escaped by `Html::serialize()`, so an
`alt`/`class`/`src` value cannot break out of its attribute.

## Dimension logic (`data-pswp-width` / `data-pswp-height`)
```php
$source = $element->getAttribute('src');
$anchor->setAttribute('href', $source);
if (isset(parse_url($source)['host'])) {
  [$img_width, $img_height, $type, $attr] = getimagesize($source);          // remote URL
}
else {
  $path = urldecode(strtok($source, '?'));
  [$img_width, $img_height, $type, $attr] = getimagesize(DRUPAL_ROOT . $path); // local path
}
$anchor->setAttribute('data-pswp-width', $img_width ?: $element->getAttribute('width'));
$anchor->setAttribute('data-pswp-height', $img_height ?: $element->getAttribute('height'));
```
- **Remote branch:** when the `src` has a `host` component, `getimagesize()` is called on the URL
  directly — the *server* performs an HTTP(S) request to the author-supplied host (requires
  `allow_url_fopen`; no allowlist, no explicit timeout). If the fetch fails, `getimagesize` returns
  `false`; the `list()` destructure yields nulls and the code falls back to the `<img>`'s own
  `width`/`height` attributes.
- **Local branch:** `strtok($source, '?')` drops any query string, `urldecode()` decodes it, and the
  path is appended to `DRUPAL_ROOT`. No traversal normalisation is applied to the path.
- The point of the `data-pswp-*` attributes is that PhotoSwipe needs the natural pixel size to lay
  out the zoomed view; this filter derives them from the source file, falling back to the inline
  attributes (so a downscaled inline `<img width="20">` still opens at its true resolution — verified
  by the module's own `testInlinePhotoSwipeResizedImages`).

## Library & help
- `photoswipe_inline.module` `hook_page_attachments()` unconditionally attaches
  `photoswipe/photoswipe.init` on **every** page (from the parent `photoswipe` module).
- `hook_help()` for `help.page.photoswipe_inline` returns `README.md` wrapped in `<pre>` and
  `Html::escape()`-d.

## Configuration
- **No** settings form, **no** module permission, **no** config schema (there is no `config/`
  directory). The only configuration is enabling the filter on a text format at
  `/admin/config/content/formats`, which requires core **`administer filters`**
  (trusted-roles-only). `configure` is `null`.
- Because the filter is `TYPE_TRANSFORM_IRREVERSIBLE`, it changes only rendered / filter-cached
  output; stored field content is never modified.

## Filter ordering guidance
- Weight `-10` places it early. Core "Limit allowed HTML tags" (`filter_html`) also defaults to
  weight `-10`; equal-weight ordering follows configuration order and is not guaranteed.
- The filter **adds** an `<a>` element and copies the image `src` verbatim into its `href`.
- It returns a bare `FilterProcessResult` and does not re-mark text as safe or re-open filtering.

## Tests
- `tests/src/FunctionalJavascript/PhotoswipeInlineFilterTest.php` covers: basic wrapping + `<a
  class="photoswipe">` + `data-pswp-width`; an image with an existing (`align-right`) class; a
  downscaled image still getting true dimensions; and an already-`<a>`-wrapped image being left
  untouched. `tests/modules/photoswipe_library_test/` is a helper that rewrites the PhotoSwipe
  library JS paths for the test environment.
