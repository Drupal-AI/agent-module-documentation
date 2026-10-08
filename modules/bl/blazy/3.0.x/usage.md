Blazy provides media lazy loading for Drupal — deferring off-screen images, iframes, and media until they are about to enter the viewport, and multi-serving responsive images to cut initial page weight.

---

Blazy is a foundational performance and media-display library used by dozens of other contrib modules (Slick, Splide, GridStack, Mason, ElevateZoom, etc.). At its core it wraps the bLazy/native lazy-loading techniques with an IntersectionObserver-based loader, so browsers only fetch images, iframes, video, and oEmbed media once they approach the visible area. It ships several field formatters (image, media, oEmbed, SVG, text, title, entity reference) that render fields lazily with optional aspect-ratio boxes, blur-up/placeholder LQIP effects, grids, and lightboxes. A `blazy` text filter lets editors lazy-load and lightbox images embedded in body/CKEditor content, and Views style/field plugins expose the same grid and media handling to listings. Developers integrate through a small set of services — chiefly `blazy.manager` and `blazy.formatter` — plus a rich set of alter hooks (`hook_blazy_settings_alter`, `hook_blazy_alter`, `hook_blazy_attach_alter`, etc.) to customize markup, attachments, and lightbox integrations. It defines a `BlazySkin` plugin type so modules can register reusable CSS skins, and provides typed config schema for its settings. The base module has no admin UI on its own; the optional Blazy UI submodule adds a global settings form, and Blazy Layout adds a dynamic-region Layout Builder layout. It targets Drupal 9.4+ and depends only on core Filter and Media.

---

- Lazy-load large images so they only download when scrolled into view.
- Reduce initial page weight and improve Core Web Vitals (LCP/CLS) on image-heavy pages.
- Multi-serve responsive images with proper `srcset`/aspect-ratio boxes to prevent layout shift.
- Add a blur-up (LQIP) placeholder effect while the real image loads.
- Lazy-load embedded YouTube/Vimeo oEmbed videos and iframes.
- Display a media field as a lazy-loaded, lightbox-enabled gallery.
- Lazy-load images pasted into CKEditor/body content via the Blazy text filter.
- Lightbox body-content images without writing custom JS.
- Render an image grid (CSS grid, flexbox, or native columns) from a multi-value field.
- Provide the lazy-load engine that Slick, Splide, GridStack, and Mason build on.
- Serve WebP/AVIF-friendly responsive images with placeholders.
- Lazy-load SVG images and inline SVGs through the SVG formatter.
- Show entity-reference content (cards) with lazy media in a grid.
- Add aspect-ratio boxes so image containers reserve space before load.
- Apply a one-pixel or encoded data-URI placeholder to avoid broken-image flashes.
- Lazy-load audio/video file fields.
- Build Views listings with lazy-loaded media thumbnails and grids.
- Register a reusable CSS "skin" for grids/galleries via a BlazySkin plugin.
- Programmatically render any image or media lazily from custom code via `blazy.manager`.
- Alter Blazy's generated markup or settings globally with alter hooks.
- Integrate a custom lightbox library through the lightbox alter hooks.
- Respect privacy/consent by deferring third-party media embeds until interaction.
- Standardize responsive image handling across an entire content-heavy site.
- Defer below-the-fold hero and teaser images on landing pages.
- Feed a decoupled/AMP-style front end consistent lazy-loaded media markup.
- Add dynamic Layout Builder regions with the Blazy Layout submodule.
- Expose a global lazy-load configuration UI to site builders via Blazy UI.
