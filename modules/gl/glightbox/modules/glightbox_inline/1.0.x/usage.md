<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GLightbox Inline is a submodule of GLightbox that opens content already on the page — or a page, video, or image referenced by URL — inside a GLightbox popup, triggered by adding the `glightbox-inline` class to a link. It has no configuration.

---

Once enabled, the module attaches its behavior (and the GLightbox library) to every page via `hook_page_attachments()` and the `glightbox_inline/glightbox_inline` library (which depends on `glightbox/glightbox` and `core/once`). You mark up a link with `class="glightbox-inline"` and point its `href` at what should open: a CSS selector (`href="#user-login"`) opens the first matching on-page element in the modal; a path or URL (`href="/node/42"` or an external URL) loads that page; a media URL (an `.mp4` file or a YouTube link) plays the video. An optional `data-glightbox` attribute (e.g. `data-glightbox="width: 700; height: auto"`) controls the modal size, and content can be loaded via AJAX. Captions are sanitized through DOM Purify (`Drupal.glightbox.sanitizeMarkup`). The module requires the main GLightbox module and, like it, the GLightbox JS library in `/libraries`. There is no admin UI, permissions, config, or Drush — enabling the module and adding the class is the whole setup.

---

- Open a hidden on-page `<div>` (e.g. a sign-up form) in a lightbox from a link.
- Show the site's login block in a modal via `href="#block-login"`.
- Load a full page/node into a popup by URL (`href="/node/42"`).
- Play a YouTube or MP4 video in a GLightbox modal from a plain link.
- Display an external image in the lightbox without a field formatter.
- Control the popup size per link with `data-glightbox="width: 700; height: auto"`.
- Load remote or internal content into the modal via AJAX.
- Add a "quick view" popup to a listing without building a custom modal.
- Reuse an existing on-page component (map, gallery, form) inside a lightbox.
- Open terms/policy text in a modal from a checkout or registration link.
- Provide a modal preview of a linked page for editors.
- Trigger a lightbox from a menu link or CTA button by adding one class.
- Show a promotional video in a popup on a landing page.
- Present help content inline in a modal instead of navigating away.
- Open an iframe (embedded form, map) in the lightbox.
- Add lightbox popups in custom Twig templates or block content by hand.
- Sanitize modal caption/control markup automatically via DOM Purify.
- Combine with the main GLightbox formatters to mix field-based and inline lightboxes on one page.
