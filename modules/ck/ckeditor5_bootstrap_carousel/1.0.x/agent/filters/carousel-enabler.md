<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter: Carousel enabler (filter_bootstrap_carousel)

Class `Drupal\ckeditor5_bootstrap_carousel\Plugin\Filter\BootstrapCarousel`
(`src/Plugin/Filter/BootstrapCarousel.php`), extends `FilterBase`.

- Annotation id `filter_bootstrap_carousel`, title "Carousel enabler",
  type `TYPE_TRANSFORM_IRREVERSIBLE`, weight `10`.
- Must be enabled on the same text format as the CKEditor plugin (the plugin's `conditions.filter`
  requires it). Enable at `/admin/config/content/formats` → the format's filter list.

## What `process($text, $langcode)` does

1. Fast-exits (returns text unchanged) unless the raw text contains the substring
   ` data-carousel-id` (`stristr(...) === FALSE`). So non-carousel content is untouched.
2. Loads the HTML with `Html::load($text)` and runs XPath over it.
3. For each `//div[@data-carousel-id]` that also has class `carousel`:
   - Reads `data-carousel-id`, builds `$carouselId = 'carousel-' . <value>`, and sets `id`,
     `data-bs-ride=carousel`, `data-bs-interval=5000`, `data-bs-pause=false`, `data-bs-wrap=true`,
     `data-bs-keyboard=true` on the div.
   - Un-nests any `<bootstrap-carousel-controls>` that the "Convert line breaks into HTML" filter
     wrapped in a `<p>`.
   - Collects each `.carousel-item`'s active state and `data-carousel-item-label`.
   - Replaces `<bootstrap-carousel-indicators>` with one `<button>` per item
     (`data-bs-target=#<id>`, `data-bs-slide-to=<n>`, `active`/`aria-current` on the active one, and
     `aria-label` = the item label or "Slide N").
   - Replaces `<bootstrap-carousel-controls>` with prev/next control buttons
     (`carousel-control-prev`/`-next`, `data-bs-slide=prev|next`, icon span + visually-hidden text).
4. Serializes back with `Html::serialize($dom)` into the `FilterProcessResult`.

All generated attributes are set through the DOM API (`createElement`/`setAttribute`) and the values
are fixed constants or come from the parsed document, then re-serialized — the filter builds structure,
it does not concatenate raw strings into markup.

`getClassesFromElement(\DOMElement)` is a helper returning the element's `class` list as an array.

## Operating notes

- Order matters relative to core filters: this filter fixes markup that "Convert line breaks into
  HTML" may have wrapped in `<p>`; weight `10` places it late in the pipeline.
- The filter only adds runtime Bootstrap behaviour. Visual result still requires the theme to load
  Bootstrap 5 CSS + JS; the module ships neither.
- No configuration form/settings — it either runs or it doesn't, per text format.
