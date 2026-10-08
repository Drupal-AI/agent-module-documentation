<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Splide X ships ready-made examples for the Splide module — a set of demo optionsets, image styles, a sample View, and an extra skin plugin — so site builders can see working slider setups and clone them, rather than building every carousel from scratch.

---

Splide X is a "learn from examples" submodule (depends on `splide`). On install it imports nine example `splide` optionsets — **`x_main`**, **`x_carousel`**, **`x_grid`**, **`x_fullscreen`**, **`x_overlay`**, **`x_split`**, **`x_vtabs`**, **`x_splide_for`**, **`x_splide_nav`** — each demonstrating a different pattern (loop with focus/center, fullscreen, grid, thumbnail nav via asNavFor, vertical tabs, overlay). It also installs image styles (`splide`, `splide_fullscreen`, `splide_lighbox`, `splide_rectangle`, `splide_square`, `splide_thumbnail`), a demo View (`views.view.splide_x`), and a `SplideXSkin` plugin (id `splide_x_skin`) providing extra CSS skins (`d3-back`, `boxed`, `rounded`, `vtabs`, `x-testimonial`, …). Its README requires that image fields `field_image` (single) and `field_images` (multi-value) exist **before** enabling the module. The maintainers explicitly suggest cloning these examples into your own module rather than depending on Splide X in production, since it may change. It has no admin UI, permissions, or Drush of its own.

---

- Enable it to get nine working example optionsets to study and clone.
- Use the `x_main` optionset as a starting point for a full-width looping hero slider.
- Try `x_carousel` for a multi-item carousel with breakpoints.
- Use `x_grid` to render a grid-style slider.
- Demo a fullscreen slider with `x_fullscreen` and the `splide_fullscreen` image style.
- Build thumbnail navigation by pairing `x_splide_for` (main) and `x_splide_nav` (nav).
- Explore vertical-tab sliders via `x_vtabs` and the `vtabs` skin.
- Show an overlay-style slider using `x_overlay`.
- Reuse the shipped image styles (`splide_square`, `splide_thumbnail`, …) for slide images.
- Inspect the demo View (`views.view.splide_x`) to learn the Splide Views style setup.
- Apply the extra `splide_x_skin` skins (d3-back, boxed, rounded) to your own optionsets.
- Copy an example optionset's YAML into your own module as a production preset.
- Compare optionset settings side by side to learn Splide.js options.
- Prototype a slideshow quickly without configuring an optionset by hand.
- Teach a team the recommended Splide setup patterns.
- Seed a new site with sensible slider presets, then customize.
- Use `x_split` to demonstrate a split-layout slider.
- Provide reference config for testimonial sliders (`x-testimonial` skin).
