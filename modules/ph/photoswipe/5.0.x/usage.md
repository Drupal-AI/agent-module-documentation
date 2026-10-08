PhotoSwipe provides image and media field formatters that render thumbnails and open the full images in a sleek, mobile-friendly PhotoSwipe JavaScript lightbox gallery (swipe, pinch-zoom, keyboard navigation).

---

PhotoSwipe integrates the [PhotoSwipe 5](https://photoswipe.com/) JavaScript lightbox library with Drupal image and media fields. It ships two field formatters — **Photoswipe** (`photoswipe_field_formatter`) and **Photoswipe Responsive** (`photoswipe_responsive_field_formatter`, which needs the core Responsive Image module) — that you select under *Manage display* for any image field or media/entity-reference field. Each formatter lets you pick a **thumbnail image style** (shown on the page), an optional **override style for the first image**, and a **modal/lightbox image style** (the large image shown inside PhotoSwipe); it also has native lazy/eager **image loading**, an optional **download button**, and an option to **remove the `photoswipe-gallery` wrapper class** so several fields can be merged into one shared gallery. The PhotoSwipe library itself is a third-party asset (the module's `composer require` is empty) that you provide via `composer require npm-asset/photoswipe:^5` into `/libraries/photoswipe`, or by enabling the built-in **CDN** option on the settings form at `/admin/config/media/photoswipe`. Global JS behavior (animations, zoom levels, background opacity, tooltips, key bindings, etc.) is stored in the `photoswipe.settings` config object and can be tuned on the settings form. Multiple values of a field are grouped into one gallery automatically (via the wrapper class); in Views you group images by adding the `photoswipe-gallery` class to a wrapper. Developers can attach PhotoSwipe inside a custom Twig template with the `attach_photoswipe()` Twig function, and alter the options passed to the library with `hook_photoswipe_js_options_alter()`. A submodule, **PhotoSwipe Dynamic Caption**, adds captions inside the lightbox.

---

- Turn a multi-value image field into a swipeable lightbox gallery on article/content pages.
- Display a media (image) reference field as a PhotoSwipe gallery.
- Show small thumbnails on the page that open large images in a fullscreen modal.
- Pick a dedicated thumbnail image style separate from the large lightbox image style.
- Give the first image of a gallery a larger/different thumbnail style than the rest.
- Serve a lighter, resized image style inside the lightbox instead of the original.
- Provide mobile users swipe-to-next and pinch-to-zoom photo browsing.
- Use the Photoswipe Responsive formatter with core Responsive Image for art-directed sources.
- Lazy-load gallery thumbnails with the native `loading="lazy"` attribute for performance.
- Add a download button to the PhotoSwipe toolbar so visitors can save images.
- Merge several image fields (or paragraphs) into one shared gallery by removing the wrapper class.
- Group image fields into a gallery inside a View by adding the `photoswipe-gallery` class to a row/wrapper.
- Open single images in the lightbox from a Views field without grouping them.
- Load the PhotoSwipe library from a CDN instead of installing it locally.
- Tune lightbox animation type and durations (zoom/fade) site-wide.
- Adjust background opacity, spacing, and zoom levels of the lightbox.
- Localize/translate the Close, Zoom, Previous, Next and Download tooltips.
- Configure keyboard (arrow/esc) and touch (tap/double-tap/drag) behavior.
- Embed a PhotoSwipe gallery inside a custom Twig template with `attach_photoswipe()`.
- Override PhotoSwipe options per template via `attach_photoswipe({'bgOpacity': 0.2})`.
- Programmatically alter the JS options passed to PhotoSwipe with `hook_photoswipe_js_options_alter()`.
- Disable or customize share buttons through the options alter hook.
- Pull the gallery image from a specific field of a referenced media/entity.
- Hide the on-page image entirely (thumbnail style "Hide") while still building the gallery.
- Add captions inside the lightbox using the PhotoSwipe Dynamic Caption submodule.
- Deploy PhotoSwipe global settings as configuration between environments.
