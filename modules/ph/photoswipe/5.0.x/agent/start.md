# photoswipe — agent start

Integrates the PhotoSwipe 5 JavaScript lightbox with Drupal image/media fields via two field
formatters — **Photoswipe** (`photoswipe_field_formatter`) and **Photoswipe Responsive**
(`photoswipe_responsive_field_formatter`, needs core Responsive Image). Package **Media**;
no module dependencies. The PhotoSwipe JS library is a third-party asset you supply
(`composer require npm-asset/photoswipe:^5` into `/libraries/photoswipe`) or load from CDN.
Config UI: **Admin → Config → Media → PhotoSwipe** (`/admin/config/media/photoswipe`);
settings route `photoswipe.settings`.

- Apply the formatter, choose thumbnail/lightbox image styles, gallery grouping, library & global settings → [configure/photoswipe.md](configure/photoswipe.md)
- `attach_photoswipe()` Twig function, the assets manager service, and `hook_photoswipe_js_options_alter()` → [api/photoswipe.md](api/photoswipe.md)
- Captions inside the lightbox → submodule **photoswipe_dynamic_caption** (see `modules/photoswipe_dynamic_caption/5.0.x/`)
