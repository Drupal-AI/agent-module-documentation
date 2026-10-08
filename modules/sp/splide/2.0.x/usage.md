<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Splide integrates the vanilla-JavaScript Splide slider library into Drupal (no jQuery), providing reusable slider "optionsets" as config entities and a family of Blazy-powered field formatters, a Views style, and a text-filter shortcode to render images, media, paragraphs, or view results as carousels/slideshows.

---

The core module (which depends on **Blazy** for lazy-loading and shared plumbing) defines a `splide` **optionset** config entity that stores a named bundle of Splide.js options — type (slide/loop/fade), `perPage`, `perMove`, gap, autoplay/interval, arrows, pagination, drag, breakpoints, a chosen skin, and a `group` — created and edited through the **Splide UI** submodule at `/admin/config/media/splide`. You then point a renderer at an optionset: the field formatters **`splide_image`**, **`splide_media`**, **`splide_file`**, **`splide_text`**, **`splide_entityreference`**, **`splide_paragraphs_media`**, and **`splide_paragraphs_vanilla`**; the **`splide`** Views style; or the **`splide_filter`** text-format shortcode. Skins are provided by a plugin type (`@SplideSkin`, manager `splide.skin_manager`) and shipped CSS themes (default, classic, fullwidth, seagreen, split, …). The module's own settings (`splide.settings`: `module_css`, `splide_css`, `sitewide`) toggle bundled CSS. Rendering flows through the `splide.manager` and `splide.formatter` services (both extend Blazy equivalents), and behavior can be tuned with alter hooks (`hook_splide_optionset_alter`, `hook_splide_options_alter`, `hook_splide_settings_alter`, `hook_splide_overridable_options_info_alter`). It requires the Splide JS library (v4+) placed under `/libraries`. Two submodules extend it: **Splide UI** (the optionset admin UI + `administer splide` permission) and **Splide X** (ready-made example optionsets, image styles, a demo View, and an extra skin plugin).

---

- Turn a multi-value image field into a responsive carousel with the `splide_image` formatter.
- Build a media-entity slideshow (images/video) using the `splide_media` formatter.
- Render a paragraphs field as a slider with the `splide_paragraphs_*` formatters.
- Display Views results as a carousel via the `splide` Views style.
- Add a slider to rich text with the `[splide]` shortcode from the `splide_filter` text filter.
- Create reusable slider presets (optionsets) and apply the same config to many fields.
- Configure autoplay with a custom interval and pause-on-hover.
- Set responsive breakpoints so `perPage` changes on smaller screens.
- Make a loop/infinite carousel vs a finite slide type per optionset.
- Add thumbnail navigation (asNavFor) pairing a main slider with a nav slider.
- Choose a visual skin (default, classic, fullwidth, seagreen, split) per optionset.
- Enable/disable arrows, pagination, drag, and keyboard control per slider.
- Lazy-load slide images (via Blazy) for better performance on image-heavy pages.
- Ship optionsets as exported config for consistent sliders across environments.
- Grant editors the `administer splide` permission (Splide UI) to manage optionsets.
- Duplicate an existing optionset as a starting point for a new slider.
- Use Splide X's example optionsets (x_main, x_carousel, x_grid, x_fullscreen…) to learn setups.
- Present a fullscreen or overlay slider using Splide X presets.
- Add a vanilla JS (no jQuery) slider to reduce front-end dependencies.
- Override individual Splide options per render with `hook_splide_options_alter()`.
- Programmatically alter an optionset before rendering with `hook_splide_optionset_alter()`.
- Toggle the module's bundled CSS with the `splide.settings` (`module_css`/`splide_css`) options.
- Build a testimonial or logo carousel from a content type's fields.
- Create a product-image gallery slider on commerce pages.
- Serve breakpoint-dependent multi-image sliders leveraging Blazy's advanced lazyloading.
