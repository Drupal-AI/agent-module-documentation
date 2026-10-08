<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flickr Integration Suite Filter Colorbox makes images embedded by the Flickr filter open in a Colorbox lightbox instead of navigating away.

---

Inline photos in an article are usually shown small, and a reader who wants to look properly has two options: click through to Flickr and leave the site, or squint. A lightbox is the third — the image opens over the page at full size, and closing it returns the reader exactly where they were.

This submodule wires the filter's output to Colorbox so that happens without any per-image markup. It nests under `flickr_integration_suite_filter` because it only makes sense with it: there is nothing to lightbox unless the filter put images in the text.

Two practical notes. Colorbox is a jQuery library, so this brings jQuery into the page on any article containing a Flickr embed — worth knowing on a site that has otherwise moved off it. And a lightbox is a keyboard and screen-reader surface: check that focus moves into the lightbox when it opens, returns when it closes, and that Escape works, because a lightbox that traps focus is worse than a link.

---

- Open an embedded Flickr image in a lightbox.
- Keep readers on the page when viewing photos.
- Show a full-size image over an article.
- Return the reader to their place on close.
- Avoid clicking through to Flickr.
- Add lightbox behaviour without per-image markup.
- Browse several embedded photos in sequence.
- Improve reading flow in photo-heavy articles.
- Check keyboard operation of the lightbox.
- Verify focus returns after closing.
- Confirm Escape closes the lightbox.
- Weigh the jQuery dependency Colorbox brings.
- Style the lightbox to match the site.
- Enable it only where the filter is used.
- Audit accessibility of lightbox behaviour.