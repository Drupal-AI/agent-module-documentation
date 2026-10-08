# Twig filters

Defined in `TwigTweakExtension::getFilters()`. Applied to a value with the `|` syntax.

| Filter | Purpose / signature |
|---|---|
| `token_replace(data = {}, options = {})` | Replace all tokens in a markup string; also usable as `{% apply token_replace %}…{% endapply %}`. |
| `preg_replace(pattern, replacement)` | `preg_replace()` wrapper (for simple cases prefer core `replace`/`format`). |
| `image_style(style)` | Turn an image URI into an image-style derivative URL; errors on empty/invalid URI. |
| `transliterate(langcode = 'en', unknown = '?', max_length = null)` | Unicode → US-ASCII transliteration. |
| `check_markup(format, ...)` | Run text through a text format (alias of core `check_markup`). |
| `format_size` | Human-readable byte size (e.g. `12345|format_size`). |
| `truncate(max, wordsafe = false, ...)` | UTF-8-safe truncation. |
| `view(view_mode = 'default', langcode = null, check_access = true)` | Render an entity, field list or field item (`node|view('teaser')`, `node.field_image|view`). |
| `with(key, value)` | Add a property to a render array (key may be a path array for nested set); opposite of core `without`. |
| `data_uri(mime, parameters = {})` | Build an RFC 2397 data URI (e.g. inline SVG). |
| `children(sort = false)` | Return only the renderable children of a render array, optionally weight-sorted. |
| `file_uri` | Extract file URI from a field/media item or entity (delta via `[0]`); OEmbed supported. |
| `file_url(relative = true)` | Extract file URL from a URI, field/media item or entity; `false` → absolute. |
| `entity_url(rel = 'canonical', options = {})` | `EntityInterface::toUrl()` — get a `Url` for an entity. |
| `entity_link(text = null, rel = 'canonical', options = {})` | `EntityInterface::toLink()` — get a `Link` for an entity. |
| `translation(langcode = null)` | Entity translation for the given/current language context. |
| `cache_metadata` | Wrap raw values so their cache metadata bubbles up. |
| `php(code)` | Evaluate PHP — **disabled by default**; enable with `$settings['twig_tweak_enable_php_filter'] = TRUE;`. Discouraged. |

Examples:

```twig
{{ '<h1>[site:name]</h1>'|token_replace }}
{{ 'public://images/ocean.jpg'|image_style('thumbnail') }}
{{ node|view('teaser') }}
{{ content.field_image|with('#title', 'Photo'|t) }}
{{ node.field_media|file_url }}
{{ node|entity_link('Read more'|t) }}
```

Filters can be extended via `hook_twig_tweak_filters_alter` (see hooks doc).
