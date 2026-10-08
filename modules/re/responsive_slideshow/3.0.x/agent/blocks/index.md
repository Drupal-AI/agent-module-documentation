<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: Responsive Slideshow

Single block plugin. Class `Drupal\responsive_slideshow\Plugin\Block\SlideshowBlock`
(`src/Plugin/Block/SlideshowBlock.php`), extends `Drupal\Core\Block\BlockBase`.

```
@Block(
  id = "responsive_slideshow",
  admin_label = @Translation("Responsive Slideshow"),
  category = @Translation("Blocks")
)
```

Place it through the core block UI (`Structure › Block layout`, `administer blocks`). It takes no
block-instance configuration; all behavior comes from `responsive_slideshow.settings` and from the
`responsive_slideshow` nodes on the site.

## `build()`

```php
$sliders = responsive_slideshow_homepage();
return [
  '#theme'    => 'slideshow_data',
  '#data'     => $sliders,
  '#attached' => ['library' => ['responsive_slideshow/responsive-styling']],
  '#cache'    => ['max-age' => 0],
];
```

The block is **uncached** (`max-age 0`) — the query runs on every uncached page render. It attaches
only the CSS library; there is no JS attachment (the theme's Bootstrap JS drives the carousel).

## The query — `responsive_slideshow_homepage()` (`responsive_slideshow.module`)

- `SELECT n.nid FROM node_field_data n INNER JOIN node__field_slideshow_image img ON n.nid = img.entity_id`
- `WHERE n.type = 'responsive_slideshow' AND n.status = 1`
- `AND n.langcode IN (current, und) AND img.langcode IN (current, und)`
- `ORDER BY n.changed DESC` — most-recently-changed slides first (no manual ordering field).
- `->range(0, responsive_slideshow_no_of_slides)`
- `->addTag('node_access')` — respects node access grants.

Nodes are then loaded and translated (current language, falling back to the default language). Per
slide the function builds:

- **image**: `ImageStyle::load('responsive_slideshow_style')->buildUrl($uri)`; `alt`/`title` from the
  image field, each `Html::escape()`d, defaulting to the escaped node title.
- **title**: node title, `strip_tags` + `Html::escape`, truncated to 90 chars with an ellipsis.
- **description**: `field_slide_teaser` if present, else `field_body_desc` run through
  `check_markup(..., 'restricted_html')`; then `strip_tags`, truncated to
  `responsive_slideshow_description_length` (0 = full) with a trailing `...`.
- **link / target**: see below.
- **link** (edit link): only for users with `administer nodes` — a rendered `Edit` link to the node
  edit form, produced by the core link generator.
- top-level `interval` = `responsive_slideshow_interval`, `count` = number of slides.

## Link resolution — `responsive_slideshow_get_link()`

Default: the slide links to its own node canonical URL. If `field_slide_link` is set **and**
`field_hide_external_link` (Hide Detail Page) is truthy, the Link field value is used instead:

- `entity:node/N` → alias of `/node/N` (language-prefixed for non-`en`), target unset.
- `internal:/path` → that path (language-prefixed), target unset.
- anything else (external URL) → the raw `uri`, `target = _blank`.

If the Link field is empty and Hide Detail Page is set, the slide has no link. The `href` is emitted
by Twig with autoescaping; the link field's own scheme validation is what constrains the URI, and
slides are authored content (not anonymous input).

## Template — `templates/slideshow-data.html.twig`

Emits Bootstrap 5 carousel markup: `#carouselExampleCaptions.carousel.slide` with
`data-bs-ride="carousel"` and `data-bs-interval="{{ data.interval }}"`. Indicators and prev/next
controls render only when `data.count > 1`. Each `.carousel-item` has the image (`d-block w-100`),
a `.carousel-caption` with the linked/plain title, a `.description-inline` span, and (for privileged
users) the edit link. All hardcoded to Bootstrap 5 class names and `data-bs-*` attributes.
