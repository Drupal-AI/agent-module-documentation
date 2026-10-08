<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PhotoSwipe Inline is a single text-format `@Filter` plugin that finds bare `<img>` tags in rendered body content and wraps each in an `<a class="photoswipe">` linking to the image, so inline editorial images open in a PhotoSwipe lightbox with no manual markup.

---

The `photoswipe` module wires the PhotoSwipe lightbox to image **fields** as a field formatter, which does nothing for images an author drops into body text through CKEditor. PhotoSwipe Inline closes that gap with one transform filter (`id: photoswipe_inline`, `TYPE_TRANSFORM_IRREVERSIBLE`, weight `-10`). At render time its `process()` wraps the whole text in `<div class="photoswipe-gallery">`, DOM-parses it with `Html::load()`, and for every `<img>` that is **not already inside an `<a>`** and does **not already carry a `photoswipe` class**, it creates an anchor, moves the image inside it, sets the anchor `href` to the image's `src`, and computes `data-pswp-width` / `data-pswp-height` that PhotoSwipe needs. Dimensions come from `getimagesize()` — called on the remote URL when the `src` has a host, otherwise on `DRUPAL_ROOT . <path>` — falling back to the image's own `width`/`height` attributes. Images that already sit in a link, or already have a `photoswipe` class from CKEditor, are deliberately left alone. The module also attaches the parent module's `photoswipe/photoswipe.init` library on every page via `hook_page_attachments()`, and there is no settings form, no permission, and no config — the only control is which text formats you enable the filter on at `/admin/config/content/formats`. Because it is a transform filter, it changes only rendered/filter-cached output; stored content is untouched. Note the remote-`src` branch means the server itself fetches author-supplied image URLs during rendering, and `getimagesize()` requires `allow_url_fopen` for that path.

---

- Make images inserted through CKEditor open in a PhotoSwipe lightbox automatically.
- Add a lightbox to images in a node's body field without hand-writing anchor markup.
- Give long-form editorial with embedded photographs click-to-zoom behaviour.
- Let readers pinch-zoom body-content images on mobile.
- Provide swipe navigation between multiple images in one article.
- Turn a photo essay written in the body field into a gallery.
- Show a high-resolution version of a thumbnail placed inline in text.
- Enable PhotoSwipe on images that live outside an image field.
- Add touch-friendly full-screen image viewing to article pages.
- Wrap product-description images so they open at full size.
- Keep manually linked images (already inside `<a>`) untouched while enhancing the rest.
- Skip specific images from the lightbox by giving them a `photoswipe` class in the editor.
- Apply PhotoSwipe to images across any text format you choose to enable the filter on.
- Present exhibition or press photographs embedded in a story.
- Add captioned lightbox images to a blog post.
- Standardise lightbox behaviour for all inline images site-wide via one shared text format.
- Give a portfolio write-up zoomable inline images.
- Avoid teaching editors the manual PhotoSwipe HTML/CSS convention.
- Populate the `data-pswp-width`/`data-pswp-height` PhotoSwipe expects without editor effort.
- Combine with the parent PhotoSwipe module so field galleries and inline images share one viewer.
