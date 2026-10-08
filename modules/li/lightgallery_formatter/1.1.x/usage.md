<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LightGallery Formatter provides a media field formatter that displays image, remote-video and PDF Document media as a lightGallery lightbox.

---

LightGallery Formatter provides a **media field formatter driven by reusable profiles** — it renders an
entity-reference media field (images, YouTube/Vimeo remote video, and standard PDF Documents) as a
lightGallery lightbox. The gallery is rendered by a bundled React build (lightGallery 2.9.0 + React 18.2.0,
no external library install), with a static image/PDF-link fallback in the Twig template for SEO and
no-JavaScript graceful degradation. Behaviour is configured through `lightgallery_profile` config entities
at `/admin/config/media/lightgallery`; each profile turns 11 feature plugins (general, thumbnail, zoom,
fullscreen, pager, rotate, autoplay, share, hash, medium_zoom, relative_caption, video) on or off. Depends
on core `media` and `media_library`, provides one admin permission and config schema, ships demo and preview
submodules, in the LightGallery package. Core `^10.3 || ^11 || ^12`.

Use it to present a media reference field as an interactive gallery. It is a media/content-display feature;
rendered media follows core media/file entity access (referenced media and the PDF-thumbnail media are
access-checked, captions and PDF filenames are escaped) and it has no access-control role beyond the single
`administer lightgallery_formatter` permission that gates the profile admin UI. Choose the LightGallery
formatter on a media field, pick a profile, and optionally set per-bundle source fields, an inline-thumbnail
image style, and a shared PDF thumbnail.

---

- Display a media reference field as a lightGallery lightbox.
- Render images, remote video (YouTube/Vimeo), and PDF Documents in one ordered gallery.
- Create reusable gallery profiles and switch displays between them.
- Enable/disable the 11 feature plugins per profile (thumbnails, zoom, fullscreen, autoplay, etc.).
- Configure general lightbox options (loop, transition mode/speed, controls, drag/swipe).
- Add a thumbnail navigation strip to the lightbox.
- Enable image zoom, rotate/flip, or Medium-style zoom.
- Turn on autoplay/slideshow with a progress bar.
- Enable social sharing (Facebook/Twitter/Pinterest) or URL-hash deep links.
- Set a separate inline gallery-grid thumbnail image style.
- Set the lightbox thumbnail-strip image style via the profile.
- Extract remote-video thumbnails automatically from provider metadata.
- Show PDFs as native-viewer slides with a shared selectable thumbnail.
- Provide a static fallback gallery before React loads or if JS fails.
- Clone an existing profile as a starting point.
- Export/sync gallery profiles as standard Drupal configuration.
- Select which media-type field supplies each gallery item.
- Apply a Media Library-selected published image as the PDF thumbnail.
- Restrict profile administration to the module's admin permission.
- Rely on bundled JS so no Composer/library download is needed.
- Preview a profile live via the preview submodule.
- Spin up demo content via the demo submodule for testing.
- Keep galleries working on mobile with touch gestures.
