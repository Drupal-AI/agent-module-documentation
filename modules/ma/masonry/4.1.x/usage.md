<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Masonry API is a developer-facing bridge to David DeSandro's Masonry and imagesLoaded JavaScript libraries: it exposes one service that builds a settings form and attaches a configured Masonry layout to any render array.

---

The module deliberately ships **no UI of its own** — no settings form, no configure route, no permissions, no blocks and no Views style. Its whole surface is the `masonry.service` (`Drupal\masonry\Services\MasonryService`) plus three alter hooks and three asset libraries. `getMasonryDefaultOptions()` returns the fifteen supported options (`layoutColumnWidth`, `gutterWidth`, `isLayoutResizable`, `isLayoutAnimated`, `layoutAnimationDuration`, `isLayoutFitsWidth`, `isLayoutRtlMode`, `isLayoutImagesLoadedFirst`, `isLayoutImagesLazyLoaded`, `imageLazyloadSelector`, `imageLazyloadedSelector`, `stampSelector`, `isItemsWidthForce`, `isItemsPositionInPercent`, `extraOptions`), pre-filling the RTL flag from the current language and the lazy-load class names from the **Lazy** module when it is installed. `buildSettingsForm()` returns a ready-made form fragment for those options — this is what consuming modules such as *Masonry Views* embed in their own settings — with a validator that rejects unitless column/gutter values. `applyMasonryDisplay($form, $container, $item_selector, $options, $masonry_ids)` normalises the width units (px, %, or a CSS selector), maps the camelCase option names onto the snake_case keys the JavaScript expects, runs `hook_masonry_script_alter()` (module **and** theme), attaches the `masonry/masonry.layout` library and merges the result into `drupalSettings.masonry[<container selector>]`. The client behaviour then calls jQuery Masonry on each container, re-layouts on resize, optionally waits for imagesLoaded, and installs a `MutationObserver` to re-layout lazysizes-loaded images. The two JavaScript libraries are **not** shipped: they must be dropped into `/libraries/masonry/dist/masonry.pkgd.min.js` and `/libraries/imagesloaded/imagesloaded.pkgd.min.js` (or installed via the bundled `composer.libraries.json`), and `hook_requirements()` flags them on the status report when missing.

---

- Give a Views listing a Pinterest-style cascading grid via the Masonry Views module.
- Attach a Masonry layout to a custom render array from your own module's code.
- Build a photo gallery whose tiles have different heights.
- Lay out a card grid where the cards are sized by CSS classes rather than fixed pixels.
- Set the column width from a CSS selector (`.grid-sizer`) instead of a hard pixel value.
- Add a gutter between columns expressed in pixels or percent.
- Wait for all images to load before laying out, so tile heights are correct.
- Keep a Masonry grid correct when images are lazy-loaded by lazysizes.
- Pick up the Lazy module's `lazyClass`/`loadedClass` automatically instead of hard-coding them.
- Re-layout a grid automatically when the browser window is resized.
- Animate item repositioning and control the animation duration.
- Centre a grid by enabling Masonry's `fitWidth`.
- Keep a "featured" item pinned in place with a stamp selector.
- Render items positioned in percentages so resizing does not animate them.
- Support right-to-left languages automatically from the current language direction.
- Pass Masonry options the module does not expose through `extraOptions`.
- Add an extra option (e.g. easing) site-wide with `hook_masonry_default_options_alter()`.
- Add a matching form control for that option with `hook_masonry_options_form_alter()`.
- Rewrite the per-container JS settings just before they are attached with `hook_masonry_script_alter()`.
- Alter Masonry settings from a **theme** (the service runs the theme alter as well as the module one).
- Target one specific display with `masonry_ids` so an alter hook can distinguish it.
- Reuse the module's settings form fragment inside your own plugin's configuration form.
- Detect a missing Masonry/imagesLoaded library from the Drupal status report before launch.
- Install both libraries through Composer using the module's `composer.libraries.json` with the merge plugin.
