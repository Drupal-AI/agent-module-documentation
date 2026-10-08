<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Preload Font emits `<link rel="preload">` resource hints in the page head for a site-admin-supplied list of web fonts, so the browser fetches them at the start of the page load instead of after it has parsed the CSS that references them.

---

The entire module is one `hook_page_attachments_alter()` implementation (`preload_font.module`) plus a `ConfigFormBase` settings form. An admin enters one URL per line into a single `fontPaths` textarea at `/admin/config/user-interface/preload-font` (route `preload_font.config`, permission **`administer site configuration`**); the value is stored as a newline-joined string in the config object **`preload_font.settings`** (no schema ships, so the config is untyped). On every response, `preload_font_page_attachments_alter()` splits that string on `PHP_EOL` and runs `_preload_fonts()` over each line, branching three ways: (1) a path containing `fonts.googleapis.com` is treated as a **Google Fonts stylesheet** — it emits a `<link rel="preconnect" href="//fonts.gstatic.com/" crossorigin>` plus a `<link rel="preload" as="style" href="…" crossorigin onload="this.onload=null;this.rel='stylesheet'">` (the load-then-swap CSS trick); (2) a path starting with `/` or `http` is treated as a **font file** — it emits `<link rel="preload" as="font" href="…" crossorigin>` and, when `pathinfo()` yields an extension, a `type="font/{ext}"` attribute derived from that extension (e.g. `font/woff2`); (3) anything else is silently ignored. Every hint carries **`crossorigin`** unconditionally (mandatory for CORS-mode font fetches, even same-origin, or the browser fetches the file twice). All entries are injected via `$attachments['#attached']['html_head_link']`, which Drupal's `HtmlResponseAttachmentsProcessor` renders through the `html_tag` element with standard attribute escaping. The form's `validateForm()` deduplicates lines and rejects any path that is not a valid URL, does not start with `/` or `http`, or ends with a trailing `/`; a `fonts.googleapis.com` URL missing `display=swap` is also rejected (to avoid FOIT). The module ships no permissions, no services, no plugins, and no Drush commands — it is purely path strings (not managed files) turned into head links.

---

- Preload a theme's primary self-hosted font file (`.woff2`).
- Reduce a flash of unstyled text (FOUT) on first paint.
- Reduce a font-driven cumulative layout shift (CLS).
- Improve Largest Contentful Paint when the LCP element is text.
- Fix a Lighthouse / Core Web Vitals "preload key requests" warning.
- Load a heading or display font earlier than the CSS would.
- Preload only the specific above-the-fold weights and subsets.
- Preload an icon font used in the header.
- Preload a variable font.
- Add a Google Fonts stylesheet with the recommended preconnect + preload-swap pattern.
- Reference a font via absolute URL (`https://…`) from a CDN.
- Reference a self-hosted font via root-relative path (`/themes/…/font.woff2`).
- Add font preload hints in configuration without editing a theme template.
- Emit the mandatory `crossorigin` attribute so same-origin fonts are not fetched twice.
- Auto-derive the `type="font/woff2"` attribute from the file extension.
- Enforce `display=swap` on Google Fonts URLs at config-save time.
- Deduplicate a font list before it is emitted.
- Centralise font preload hints for a multi-theme site in one config object.
- Improve perceived page speed / mobile load experience.
- Prioritise typography that appears above the fold on a landing page.
- Manage font hints as exportable configuration (`preload_font.settings`).
