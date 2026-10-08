<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Splidebox opens gallery images and media in a full-screen lightbox powered by the Splide slider, letting the whole set be swiped, zoomed, and navigated in place. It has no formatter of its own — you turn it on by choosing "Image to Splidebox" under the Media switcher option of a Blazy or Splide formatter, the Blazy Filter, or a Blazy-related Views style.

---

Splidebox is a thin integration layer on top of Blazy and Splide rather than a standalone lightbox: it registers itself as a Blazy lightbox (`hook_blazy_lightboxes_alter`), and its entire trigger surface is the "Image to Splidebox" choice in Blazy's Media switcher select. Any Blazy-based renderer — the Blazy or Splide field formatters, the Blazy Filter text-format filter for inline images, Blazy Views fields, and Blazy Grid/Splide/Table/List Views styles — inherits it for free, so there is no per-module configuration to learn. When applicable, the module serializes the lightbox's Splide optionset (zoom, fullscreen, media, and thumbnail-nav settings) to a base64-encoded JSON string in a `data-splidebox` attribute; the client-side loader (`js/splidebox.load.min.js`, decoding via `atob` + JSON parse) reads it and builds the lightbox DOM on demand from a dummy template. Two config entities ship as install config: the `splide.optionset.splidebox` main optionset (default skin Skyblue) and `splide.optionset.splidebox_nav` for the asNavFor thumbnail strip; both are edited through the normal Splide UI at `/admin/config/media/splide` (needs the `splide_ui` submodule and `administer splide`), while thumbnail navigation is selected under Blazy's Extras settings at `/admin/config/media/blazy` (needs `blazy_ui`). Beyond images it supports responsive/picture images, local audio/video, remote video (SoundCloud, iframe providers), SVG, data-URI, and AJAX-loaded node content via a per-formatter "Lightbox AJAX link" select that pulls a single-value link field and loads that node as the lightbox body — access-checked server-side. Everything is vanilla JS (no jQuery), which is the reason to prefer it over Colorbox/Fancybox on a modern site; the real cost is that it drags in Blazy (a large media module) as a hard dependency. Core requirement is `>=8.8` (runs on 10 and 11). Accessibility is the thing to verify by hand: Escape closes the dialog, but confirm focus is trapped in the lightbox and returns to the trigger, and that the dialog exposes an appropriate role and name.

---

- Open a field's gallery images in a Splide lightbox.
- Turn a lightbox on via the Media switcher "Image to Splidebox" option — no separate formatter.
- Add a modern, jQuery-free lightbox to a Blazy or Splide field formatter.
- Lightbox inline images in body text through the Blazy Filter.
- Lightbox images rendered by a Blazy Grid / Splide / Table / List Views style.
- Add thumbnail (asNavFor) navigation under the lightbox images.
- Enable wheel and click zoom on full-size images.
- Open the lightbox in a fullscreen window.
- Swipe a photo set full-size on touch devices.
- Lightbox local audio and video, and remote video (iframe providers).
- Lightbox responsive/picture images, SVG, and data-URI sources.
- Load a node's rendered content into the lightbox via AJAX ("Lightbox AJAX link").
- Show a product image gallery without ElevateZoom Plus.
- Show captions as an overlay or inline (Colorbox-style) in the lightbox.
- Reuse the same Splide component a Splide-themed site already loads.
- Combine Blazy lazy loading with a lightbox on image-heavy articles.
- Pick a lightbox skin (default Skyblue) via the `splidebox` Splide optionset.
- Override per-field behavior (`box_nav`, `box_ajax_only`, `box_layout`, `box_caption_pos`) through `hook_splidebox_attach_alter`.
- Provide keyboard-closable (Escape) full-size viewing for a portfolio or case study.
- Replace a Colorbox/Fancybox integration on a site that has dropped jQuery.
