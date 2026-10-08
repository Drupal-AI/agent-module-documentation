# blazy — agent start

Media lazy-loading library: field formatters, a text filter, Views plugins, and a service API
that many gallery/slider modules build on. Depends on core `filter` + `media`. No admin UI in
the base module — install **Blazy UI** for global settings (route `blazy.settings`).

- Field formatters (image, media, oEmbed, SVG, text, title, entity) → [configure/formatters.md](configure/formatters.md)
- Lazy-load/lightbox images in CKEditor/body via the Blazy filter → [configure/filter.md](configure/filter.md)
- Render media lazily from code (`blazy.manager`, `blazy.formatter`) → [api/services.md](api/services.md)
- Alter markup, settings, attachments, lightboxes → [hooks/hooks.md](hooks/hooks.md)
- Register a reusable CSS grid/gallery skin (BlazySkin plugin) → [plugins/skin.md](plugins/skin.md)
- Theme hook `blazy` + `blazy.html.twig` → [theming/theming.md](theming/theming.md)
