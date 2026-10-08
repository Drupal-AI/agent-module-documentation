<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UIkit Image Formatter adds three field formatters — **UIkit Lightbox** (a masonry grid whose thumbnails open a `uk-lightbox` gallery), **UIkit Slideshow** (`uk-slideshow`) and **UIkit Slider** (`uk-slider`/carousel) — that you select on Manage Display for an image field or a media entity-reference field, on a site whose theme already provides the UIkit 3 CSS/JS.

---

The whole point sits in the qualifier. Every formatter here does nothing but emit UIkit's own markup and `data-uk-*` attributes — the grid, the lightbox link, the slideshow/slider list, the slidenav/dotnav/thumbnav — and then relies on **UIkit 3's JavaScript**, loaded by the theme, to make it interactive. The module ships **no library of its own** (there is no `.libraries.yml`); the README states it requires the [UIkit base theme](https://www.drupal.org/project/uikit) or that you load UIkit 3 yourself. So on a UIkit site it is the natural choice — no second JS library, no weight, markup that matches the rest of the site — and on any other site it renders inert `data-uk-*` attributes and broken-looking grids. All three formatters accept both core `image` fields **and** `entity_reference` fields to media (they resolve the media source field in `viewElements()`, and the lightbox/slideshow preprocess even special-cases `video`/`remote_video` media bundles to use the thumbnail and the video URL). Settings are extensive but purely display-side (image styles for thumbnail and lightbox, `uk-child-width-*` grid columns per breakpoint, autoplay/interval/animation, caption overlay position/transition/background, slidenav/dotnav/thumbnav) and are configured on Manage Display, which is gated by the entity's "administer display" permission. Captions come from the image **alt** (falling back to **title**); they are rendered through Twig autoescaping and Drupal `Attribute` objects, so they are HTML-escaped on output. Version **8.x-1.13**, core `^10.1 || ^11`, no module dependencies, no config schema — verify UIkit's assets are actually present before recommending it, because nothing in the dependency graph enforces that.

---

- Turn a multi-value image field into a UIkit masonry gallery whose thumbnails open a `uk-lightbox`.
- Present product photos as a UIkit slideshow with autoplay and a chosen animation (slide/fade/scale).
- Build a UIkit slider (carousel) of images with configurable columns per breakpoint.
- Show a media reference field (image media) as a lightbox gallery without a second JS library.
- Display remote-video or file-video media in a UIkit slideshow using its thumbnail as the poster.
- Match gallery/carousel styling to an existing UIkit 3 theme by default.
- Add per-breakpoint column counts (`uk-child-width-1-2@s` … `-1-6@xl`) to a gallery grid.
- Use a small image style for thumbnails and a large one for the lightbox view.
- Add caption overlays (from alt/title) positioned top/center/bottom over slideshow/slider items.
- Enable a thumbnav strip under a slideshow using a dedicated thumbnail image style.
- Add dotnav and slidenav controls to a slider, optionally placed outside the slider.
- Show captions only on hover via the "display legend only on hover" toggle.
- Enable a lightbox on top of a slider or slideshow so items open full-size.
- Reduce page weight on a UIkit site by reusing the framework already loaded.
- Override `field--uikit-lightbox.html.twig` (or the slideshow/slider variants) to customise gallery markup.
- Use the formatters inside Views by enabling the field-template ("enable field template") styling option.
- Build a portfolio or press-photo gallery that opens each image in a lightbox.
- Create an autoplaying hero slideshow from an image field with a fixed 16:9 ratio.
- Apply a gutter/grid between slider items.
- Add the `.uk-light` inverse styling to navigation over dark imagery.
- Center the active slide in a slider and disable infinite looping.
- Confirm a UIkit theme is active before choosing this over a framework-independent lightbox module.
