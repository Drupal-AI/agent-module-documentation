<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Carousel adds a ready-made Carousel paragraph type built on Tiny Slider, with slides selected from the media library and an optional link per slide.

---

Part of the Extra Paragraph Types family, sharing `ept_core` for spacing, background and container settings. The library choice is the distinguishing detail: **Tiny Slider** is a small vanilla-JavaScript slider with no jQuery dependency, which matters because the alternative in this space is usually Slick or Owl — both jQuery-era, both heavier, and both increasingly awkward on a Drupal that has removed jQuery from core's front end. It requires core `link`, `media` and `media_library` alongside `ept_core` and `paragraphs`, and note the same installation prerequisite as the rest of the family: the **`media.type.image`** configuration must exist, so on a minimal profile the install fails with an unmet configuration dependency until an image media type is created. Version **2.0.1**, core requirement `^10.1 || ^11 || ^12`. The question worth asking before building any carousel is the same one: **engagement with slides after the first is consistently very low**, auto-advance is an accessibility problem because content moves while it is being read, and on mobile a carousel pushes real content below the fold. Where it is chosen for a genuine reason — a visitor-driven gallery, a logo strip, an editorial rotation somebody actually curates — it is fine. Where it exists because several teams each wanted the top of the homepage, say plainly that everything after slide one is close to unseen.

---

- Add an image carousel to a page.
- Show a rotating set of features.
- Build a logo strip.
- Add a testimonial slider.
- Show product images in sequence.
- Build a gallery with links per slide.
- Add a carousel without jQuery.
- Show case studies in rotation.
- Add a lightweight slider.
- Build a partner showcase.
- Show a photo sequence.
- Add a hero carousel.
- Show event highlights.
- Build a swipeable image set.
- Give editors a ready-made carousel.
- Add a linked-slide promotion.
- Show a project's images.
- Build a news rotation.
