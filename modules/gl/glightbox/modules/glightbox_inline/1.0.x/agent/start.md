<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GLightbox Inline — agent index

Submodule of **GLightbox**. Opens on-page elements, pages, videos, or images in a GLightbox popup
when a link carries the `glightbox-inline` class. No configuration, permissions, Drush, or config.

## How to use it

Enable the module (`drush en glightbox_inline -y`), then add markup:

```html
<!-- open the first element matching a selector -->
<a class="glightbox-inline" href="#user-login">User Login</a>

<!-- load a page/node into the popup -->
<a class="glightbox-inline" href="/node/42">Open page</a>

<!-- play a video / show an image by URL -->
<a class="glightbox-inline" href="https://youtu.be/g2coDPosRSs">Watch</a>

<!-- control modal size -->
<a class="glightbox-inline" href="#promo" data-glightbox="width: 700; height: auto">Promo</a>
```

Key facts:
- Depends on the parent `glightbox` module (which must have the GLightbox JS library in `/libraries`).
- `hook_page_attachments()` attaches `glightbox.attachment` and the `glightbox_inline/glightbox_inline`
  library (deps: `glightbox/glightbox`, `core/once`) on every page.
- Trigger class: **`glightbox-inline`**; `href` = selector, path/URL, or media URL; optional
  `data-glightbox` sets size; content can load via AJAX.
- Captions/controls are sanitized via `Drupal.glightbox.sanitizeMarkup` (DOM Purify).
- Parent module docs: [parent GLightbox](../../../../1.0.x/agent/start.md).
