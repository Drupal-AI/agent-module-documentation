PhotoSwipe Dynamic Caption adds captions inside the PhotoSwipe 5 lightbox for images shown by the PhotoSwipe field formatters, sourcing the caption text from the image's alt/title, the entity label, another field, or a custom token pattern.

---

This submodule of **PhotoSwipe** integrates the [photoswipe-dynamic-caption-plugin](https://github.com/dimsemenov/photoswipe-dynamic-caption-plugin) (PhotoSwipe 5 moved captions into a separate plugin). It depends on the main `photoswipe` module and, like it, needs the caption JS library provided locally (`composer require npm-asset/photoswipe-dynamic-caption-plugin:^1.2` into `/libraries/photoswipe-dynamic-caption-plugin`) or loaded via the main module's CDN option; a `hook_requirements` check reports if the library is missing. When enabled, it adds a **"Photoswipe image caption"** third-party setting to the Photoswipe and Photoswipe Responsive field formatters (on the field's Manage display page). You choose the caption source: **Image title tag**, **Image alt tag**, **Entity label**, **Media entity name** (media targets), another field of the parent or referenced entity, or **Custom (with tokens)** — the custom option shows a textarea and, if the Token module is installed, a token browser. At render time it preprocesses the `photoswipe_image_formatter` / `photoswipe_responsive_image_formatter` theme hooks and writes the resolved caption to a `data-overlay-title` attribute the JS plugin reads. Global caption behavior (position: auto/below/aside, mobile breakpoint, edge threshold, overlap ratio, vertical centering) lives in the `photoswipe_dynamic_caption.settings` config object, editable at `/admin/config/media/photoswipe_dynamic_caption`. The module also implements `hook_photoswipe_js_options_alter()` to merge its options into `captionOptions` passed to PhotoSwipe. **Note:** the caption third-party setting appears on the entity display page but, due to a Drupal core issue, is missing from the Views UI unless core is patched.

---

- Show a caption inside the PhotoSwipe lightbox for gallery images.
- Use the image's **alt** text as the lightbox caption.
- Use the image's **title** text as the lightbox caption.
- Use the parent **entity label** (e.g. the node title) as the caption.
- Use the **media entity name** as the caption for media-reference fields.
- Use another field of the parent entity as the caption source.
- Use a field of a referenced entity as the caption source.
- Build a **custom caption from tokens** (with the Token module for a token browser).
- Position captions automatically based on available space (`auto`).
- Force captions to always appear **below** the image.
- Force captions to always appear **aside** (to the right of) the image.
- Set the mobile layout breakpoint at which captions switch to mobile layout.
- Tune the horizontal edge threshold for edge-styling captions.
- Adjust the mobile caption overlap ratio.
- Vertically center the image in the remaining space when captions are shown.
- Provide the caption plugin library locally or via CDN.
- Alter global caption options in code via `captionOptions` in `hook_photoswipe_js_options_alter()`.
- Add captions to a Photoswipe Responsive gallery.
- Deploy caption settings as configuration between environments.
