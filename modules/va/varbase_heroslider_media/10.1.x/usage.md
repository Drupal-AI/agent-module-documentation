<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Hero Slider is the pre-built full-width image-and-video slider for the top of a Varbase homepage: a "Hero slider" content type whose slides (title, text, one image/video, one call-to-action link) are ordered by an Entityqueue and rendered as a Slick carousel. **Its `info.yml` marks it `lifecycle: deprecated`** — document or migrate existing use, don't adopt it new.

---

The module ships almost no PHP — only a `hook_theme`/preprocess module file and an install helper. All the actual structure (the `varbase_heroslider_media` node type; the `field_media_single`, `field_brief` and `field_link` fields; the `varbase_heroslider_media` view with its Slick style + block display; the `varbase_heroslider_media` entityqueue; the `varbase_slick` Slick optionset; the creation tour; and a Rabbit Hole redirect) is shipped as a **Drupal recipe** at `recipes/default/` and is created by applying that recipe, **not** by enabling the module. Editors create slides (media is chosen through the Media Library and can be an image, a local video, or a remote YouTube/Vimeo video), add them to the fixed-size "Media Hero Slider" queue, and the queued nodes render in order via the view's block. Rabbit Hole redirects individual slide nodes to the front page so they are not reachable as standalone pages. Playback is handled by five bundled JavaScript behaviours: `video.heroslider.{local,youtube,vimeo}.js` run in the page and coordinate autoplay/pause with the carousel, while `oembed-frame.heroslider.{youtube,vimeo}.js` run **inside** the media oEmbed iframe. Three Twig templates (`node--media-hero-slide`, `views-view--media-hero-slider`, and an oEmbed-iframe override) delegate the visible markup to the active theme via `{% include active_theme ~ ':…' %}`, so a Varbase-compatible theme (Vartheme/Bootstrap) is expected. Dependencies on `varbase_media` and `varbase_components` mean it is not usable outside the Varbase stack, and it also requires the front-end Slick library in `/libraries/slick` (checked by `hook_requirements`).

---

- Understand an existing Varbase site's homepage hero slider.
- Display a mixed image-and-video slider above the fold.
- Add image slides to a homepage hero carousel.
- Add local-video slides that autoplay and advance the carousel.
- Play a YouTube or Vimeo video inside a hero slide.
- Give each slide a title, short text and a call-to-action link.
- Order slides explicitly with an Entityqueue rather than by date.
- Cap the number of homepage slides via the queue's max size (6).
- Stop individual slide nodes appearing as standalone pages (Rabbit Hole).
- Place the slider on the homepage using the view's block display.
- Apply the shipped recipe to recreate the whole feature on a fresh site.
- Constrain slide title/text length during editing (Maxlength + Length Indicator).
- Group the slide edit fields into a single "Slide information" fieldset.
- Pick slide media through the Media Library widget.
- Tune the carousel behaviour by editing the `varbase_slick` optionset (autoplay, fade, speed).
- Theme the hero slider by overriding the module's Twig templates or the theme includes they call.
- Control oEmbed iframe playback behaviour for hero video.
- Reuse Varbase's slider markup/JS pattern in a custom theme.
- Migrate a hero slider away from this deprecated module.
- Audit which Varbase features a site still depends on.
- Keep hero slide content out of search/listing views.
- Recreate the same hero pattern on another Varbase site.
- Decide whether a slider replacement is needed before upgrading.
- Read the shipped recipe to see the intended configuration.
- Diagnose which JS context (page vs oEmbed iframe) a video-playback bug lives in.
