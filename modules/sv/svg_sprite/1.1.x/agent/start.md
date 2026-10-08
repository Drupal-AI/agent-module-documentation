<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SVG Sprite (svg_sprite) — agent index

**Adds an SVG Sprite field type, widget, formatter, Twig function, and token that let editors select and render `<symbol>` icons from an SVG sprite file via `<use href="file.svg#id">`.**

- **Version:** 1.1.x
- **Core:** ^10.3 || ^11
- **Configure route:** `svg_sprite.settings` → `/admin/config/content/svg_sprite`, permission `administer site configuration`
- **Field:** field type `svg_sprite`, widget `svg_sprite` (a `<select>`), formatter `svg_sprite`
- **Service:** `svg_sprite` (`SvgSpriteService`: `fetchSvgDataFromSource()`, `extractSpriteInfoFromSvgData()`, `getSvgHref()`)
- **Twig / token:** `{{ svg_sprite('id', {...}) }}`; `[svg_sprite:sprite:ID]`
- **Sub-module:** `svg_sprite_ckeditor5` (CKEditor 5 insert button)
- **Security:** the sprite source is admin-configured (site-configuration permission); output references the external sprite file via `<use href>` rather than inlining uploaded SVG, and `href`/`sprite_id` pass through Twig autoescaping in `svg-sprite.html.twig`; widget option labels are tag-stripped/decoded; the settings preview and token render allow-list only `svg`/`use` tags. Source parsing uses `SimpleXMLElement` on the admin-supplied file. No anonymous or mutating endpoints.

See [configure/settings.md](configure/settings.md) and [api/twig-token.md](api/twig-token.md).