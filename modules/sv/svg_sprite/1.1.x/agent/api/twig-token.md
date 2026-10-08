<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering sprites: Twig function and token

## Twig function
```twig
{{ svg_sprite('lightbulb') }}
{{ svg_sprite('lightbulb', {'class': 'my_css_class'}) }}
```
Produces:
```html
<svg class="sprite sprite-lightbulb my_css_class" aria-hidden="true" focusable="false"><use href="file.svg#lightbulb"/></svg>
```
- Registered by `SvgSpriteExtension` as `svg_sprite(sprite_id, attributes = {})`.
- Builds a `#theme => 'svg_sprite'` render array via `SvgSpriteHelper::buildSvgSpriteRenderArray()`,
  which always adds `sprite` + `sprite-<id>` classes and `aria-hidden="true"` / `focusable="false"`.
- The `svg-sprite.html.twig` template emits `<svg{{ attributes }}><use href="{{ href }}#{{ sprite_id }}"/></svg>`;
  `href` and `sprite_id` are Twig-autoescaped. `href` defaults to the configured sprite file.

## Token
```
[svg_sprite:sprite:ID]
```
`hook_tokens()` matches `sprite:<id>`, builds the same render array, and renders it in isolation.
`SvgSpriteHelper::addSvgSpriteTagsToAdminTags()` can add `svg`/`use` to the XSS admin tag list so
the token survives some restricted (admin-filtered) contexts.

## Notes
- Output references the external sprite file with `<use>`; it does not inline uploaded SVG source.
- `SvgSpriteService::getSvgHref()` appends `?v=<filemtime>` for local files (cache-busting).
