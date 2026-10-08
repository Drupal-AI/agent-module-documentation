<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Output, theming and the inline pipeline

## Theme hook

`svg_formatter_theme()` registers one hook:

```php
'svg_formatter' => ['variables' => [
  'inline' => FALSE, 'svg_data' => NULL, 'attributes' => NULL, 'uri' => NULL,
]]
```

Template `templates/svg-formatter.html.twig` (the entire file):

```twig
{% if inline %}
  {{ svg_data|raw }}
{% else %}
  <img{{ attributes }} src={{ file_url(uri) }} />
{% endif %}
```

Override it in your theme as `svg-formatter.html.twig`. `svg_data` is printed with `|raw`, which
is why sanitizing matters. Note the core template does **not** quote the `src` attribute.

## What `viewElements()` builds

Per field item:

1. Skip the item unless `$item->entity->getMimeType() === 'image/svg+xml'`.
2. Build `$attributes`: `width`/`height` (stringified) when `apply_dimensions`; `alt` and `title`
   when their toggles are on — from the token string if set and non-empty after replacement,
   otherwise from `generateAltAttribute($filename)` (strip `.svg`, `-`/`_` → space, `ucfirst`).
3. Non-inline: `#uri` = the file URI, `#svg_data` = NULL → the `<img>` branch.
4. Inline: read the file with `file_get_contents()`, sanitize (when the library exists and
   `sanitize` is on), then `DOMDocument::loadXML()` and:
   - set `height` / `width` on `documentElement` when `apply_dimensions`,
   - when `enable_title` and a title exists, create a `<title>` node with a unique id
     (`Html::getUniqueId('<field_name>-title-<delta>')`), insert it as the first child of the root
     and set `aria-labelledby` to that id,
   - `#svg_data = $dom->saveXML($dom->documentElement)`, `#uri = NULL`.

`libxml_use_internal_errors(TRUE)` is set before parsing, so a malformed SVG yields whatever
`DOMDocument` salvaged rather than a warning.

## Accessibility

- Non-inline: `alt` and `title` are plain `<img>` attributes.
- Inline: `alt` is meaningless on `<svg>`, so only the title path applies — you get
  `<svg aria-labelledby="…"><title id="…">…</title>…`. Turning `enable_title` off leaves the inline
  SVG with no accessible name.

## Gotchas

- Inline mode reads the file **from disk on every render** (no image style, no static cache beyond
  the render cache). Large SVGs inline into the page HTML.
- `file_exists($uri)` is checked, so a missing file just renders nothing for that delta.
- Private-scheme files work (the URI is read directly), but the non-inline `<img>` branch relies
  on `file_url()` and therefore on the file being downloadable by the visitor.
- Nothing is added to cache metadata beyond the normal field render caching.
