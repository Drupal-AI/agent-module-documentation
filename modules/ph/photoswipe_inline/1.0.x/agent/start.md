<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PhotoSwipe Inline Text Filter (photoswipe_inline) — agent index

A single text-format **`@Filter` plugin** (`id: photoswipe_inline`) that rewrites bare inline
`<img>` tags at render time so body-content images open in a **PhotoSwipe** lightbox — no manual
anchor/CSS markup. Depends on the **`photoswipe`** module (`>= 5`). Version **1.0.2**. Core
`^10 || ^11`. License GPL-2.0-or-later. No settings form, no permission, no config schema, no Drush.

## What it actually does
- Filter `process($text, $langcode)` (`src/Plugin/Filter/PhotoswipeInline.php`):
  1. Wraps the whole text in `<div class="photoswipe-gallery">…</div>`.
  2. DOM-parses it with `Html::load()` and iterates every `<img>`.
  3. **Skips** an `<img>` if any ancestor is an `<a>` (walks `parentNode` up), or if it already has a
     class containing the substring `photoswipe`. (Editors can opt an image out by adding a
     `photoswipe` class in CKEditor; already-linked images are left as links.)
  4. Otherwise creates an `<a>`, moves the `<img>` inside it, sets the anchor **`href` = the image
     `src`**, and sets `data-pswp-width` / `data-pswp-height` (needed by PhotoSwipe).
  5. Copies the image's existing class list onto the anchor and appends ` photoswipe`; if the image
     had no class, the anchor class is just `photoswipe`.
  6. Returns `new FilterProcessResult(Html::serialize($dom))`.
- **Dimensions** come from `getimagesize($source)`:
  - if `parse_url($src)['host']` is set → `getimagesize($src)` on the **remote URL** (needs
    `allow_url_fopen`);
  - else → `getimagesize(DRUPAL_ROOT . urldecode(strtok($src, '?')))` on the **local path**.
  - Falls back to the image's own `width` / `height` attributes when `getimagesize` returns falsey.
- `photoswipe_inline.module`: `hook_page_attachments()` attaches `photoswipe/photoswipe.init` on
  every page; `hook_help()` dumps `README.md`.

## Type & mechanism
- `FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE`, **weight `-10`** (declared in the plugin
  annotation — runs early in the filter pipeline).
- Markup is built via **DOMDocument** (`createElement` / `setAttribute` / `insertBefore` /
  `appendChild`), not string concatenation — attribute values are entity-escaped on serialization.
- Returns a plain `FilterProcessResult`; it does **not** mark output as safe or re-open filtering
  beyond normal filter output.
- Only control surface: which **text formats** enable the filter, at
  `/admin/config/content/formats` (core `administer filters`, trusted-roles-only).

## Watch for
- **Filter ordering.** At weight `-10` it typically runs alongside/near core "Limit allowed HTML
  tags" (`filter_html`, also `-10`). The generated `<a href>` is copied verbatim from the image
  `src`. See `agent/filters/mechanism.md`.
- **Server-side fetch of author-supplied URLs.** The remote-`src` branch makes the *server* call
  `getimagesize()` on the image URL during rendering (no allowlist, no explicit timeout). Details in
  `agent/filters/mechanism.md`.
- **Every image is affected**, not just intended galleries — any un-linked, un-`photoswipe`-classed
  `<img>` in the filtered text is wrapped.
- **`photoswipe` module (>= 5) must be present**; the init library is attached on every page.

## Files
- `usage.md` — short / dense / use-case bullets.
- `agent/filters/mechanism.md` — the `process()` algorithm, dimension logic, ordering, and library.
