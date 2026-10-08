Slick Lightbox opens images (and Media videos) inside a Slick carousel shown in a lightbox, exposed as an "Image to Slick Lightbox" **Media switcher** option on Blazy and Slick field formatters.

---

The module has no field formatter of its own; instead it registers a new lightbox with Blazy and plugs into the existing **Media switcher** dropdown on Blazy/Slick formatters and the Blazy Filter. `hook_blazy_lightboxes_alter()` adds `slick_lightbox` to Blazy's list of lightboxes, `hook_blazy_attach_alter()` builds the `drupalSettings.slickLightbox` payload (lightbox item selectors plus the Slick options taken from its optionset) and attaches the `slick_lightbox/load` library, and `hook_blazy_settings_alter()` flags rich/encoded box support so local Media videos are swipeable inside the lightbox. Its Slick behaviour is driven by a single ships-with-the-module Slick **optionset** config entity, `slick.optionset.slick_lightbox` (id `slick_lightbox`), which you can override at `/admin/config/media/slick/list/slick_lightbox/edit` once the Slick UI sub-module is enabled. The front-end needs the third-party **slick-lightbox** JS/CSS library from github.com/mreq/slick-lightbox installed at `/libraries/slick-lightbox/dist/`; a `hook_requirements()` check reports whether it is present. The module requires Slick 3.x (which brings Blazy) and ships no permissions, routes, services, or Drush commands.

---

- Turn a Blazy image field into a swipeable lightbox gallery by choosing "Image to Slick Lightbox" as its Media switcher.
- Open a Slick carousel's images in a full-screen lightbox slider.
- Show a gallery of images where clicking any thumbnail launches a Slick lightbox at that slide.
- Play local Media (core Media) videos swipeably inside a lightbox.
- Add lightbox behaviour to inline images via the Blazy Filter's Media switcher.
- Provide a lightbox for Blazy Views fields (File Entity and Media).
- Reuse one shared Slick optionset (`slick_lightbox`) to control all lightbox sliders site-wide.
- Tune lightbox slider behaviour (centerMode, lazyLoad, swipeToSlide) by editing the optionset.
- Enable mobile-first, lazy-loaded lightbox galleries out of the box.
- Register a custom Slick "skin" for the lightbox via the optionset's Skin option.
- Give product image fields a tap-to-zoom carousel lightbox on mobile.
- Build an editorial photo-gallery experience without writing a custom formatter.
- Swap Colorbox/PhotoSwipe for a Slick-based lightbox on existing Blazy formatters.
- Offer keyboard/swipe navigation between gallery items inside the modal.
- Deliver responsive lightbox breakpoints (defined in the optionset's responsives).
- Present media galleries where captions from a hidden `.visually-hidden` sibling appear in the lightbox.
- Standardise lightbox styling across many content types by pointing all formatters at the same switcher.
- Combine with Slick Views to lightbox an entire view result set.
- Keep the lightbox lazy-loading images on demand to reduce initial payload.
- Ship the optionset as exported config for consistent lightbox behaviour across environments.
- Provide a fallback default skin so the lightbox is usable before you design custom CSS.
