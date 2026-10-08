Blazy PhotoSwipe registers PhotoSwipe as a lightbox ("Media switch") option for Blazy-powered field formatters and Views fields, so images (and swipeable local videos) open in a zoomable, swipeable PhotoSwipe gallery.

---

The module is a thin integration layer between the Blazy module (>= 3.x) and the PhotoSwipe JavaScript library — it ships no field type, no formatter, and no configure route of its own. Instead it hooks into Blazy: `hook_blazy_lightboxes_alter()` adds `photoswipe` to Blazy's list of lightboxes, which makes an **"Image to PhotoSwipe"** choice appear in the **Media switch** select on any Blazy, GridStack, Splide, or Slick formatter (and Blazy Views fields). When a display uses that switch, `hook_blazy_attach_alter()` attaches the `blazy_photoswipe/load` (PhotoSwipe 4) or `blazy_photoswipe/load5` (PhotoSwipe 5) library and passes options to `drupalSettings.photoswipe.options`. It supports both library majors: PhotoSwipe 4 is used by default, and PhotoSwipe 5 is switched on via a **PhotoSwipe** select added to Blazy's own settings form (`/admin/config/media/blazy`), stored as an integer in `blazy.settings` under `extras.photoswipe` (value `5` = PS5). `hook_blazy_settings_alter()` flags the build as a "richbox"/"encodedbox" so local videos can play inside the lightbox. Options passed to the library can be overridden by implementing `hook_blazy_photoswipe_js_options_alter()`. The PhotoSwipe library itself (and, for PS4, the optional `photoswipe` contrib module) must be present under `/libraries/photoswipe`.

---

- Let visitors open Blazy-formatted images in a zoomable, swipeable PhotoSwipe lightbox.
- Add "Image to PhotoSwipe" as the Media switch on an Article image field's Blazy formatter.
- Build a swipeable photo gallery from a multi-value image field using the Blazy formatter.
- Present a Media (image) reference field as a PhotoSwipe lightbox gallery.
- Turn a Blazy Views field (File ER or Media) into a PhotoSwipe gallery on a listing page.
- Give Slick or Splide carousels a PhotoSwipe "click to zoom" lightbox behaviour.
- Play local (self-hosted) videos inside the PhotoSwipe lightbox via Blazy's richbox support.
- Switch a whole site from PhotoSwipe 4 to PhotoSwipe 5 with one Blazy Extras setting.
- Provide pinch-to-zoom and swipe navigation on touch devices for gallery images.
- Offer keyboard (arrow / Esc) navigation in an image lightbox without custom JS.
- Customise PhotoSwipe animation, background opacity, or zoom via a small alter hook.
- Standardise the lightbox experience across many content types by reusing the Blazy formatter.
- Replace Colorbox/Magnific with PhotoSwipe on a Blazy-based image display.
- Add a responsive-image-aware lightbox that respects Blazy's lazy loading.
- Show a thumbnail grid that expands to full-resolution images in an overlay.
- Configure PhotoSwipe options centrally through the optional photoswipe contrib module's settings.
- Deploy the lightbox choice through exported config (the formatter's `media_switch: photoswipe`).
- Keep the initial page light by lazy-loading images and only loading PhotoSwipe on demand.
- Provide a gallery for a product image field on a Commerce product display.
- Present taxonomy-term or media-library images in a swipeable overlay.
- Give editors a no-code toggle (a select option) to enable the lightbox per display.
- Pair a low-res thumbnail style with a high-res lightbox image style for fast, sharp galleries.
- Enable modern touch-friendly galleries without writing any JavaScript.
