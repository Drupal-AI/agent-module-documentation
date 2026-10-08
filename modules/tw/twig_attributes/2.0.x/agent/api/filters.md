# API — the `add_attr` / `with_attr` Twig filter

Registered by `src/TwigExtension.php`. `with_attr` is an exact alias of `add_attr`.

## Signature

```twig
{{ build|add_attr(key, attributes, add_to_children = true, override = false) }}
```

| Arg | Type | Default | Meaning |
|---|---|---|---|
| (piped) `build` | render array | — | The renderable being filtered (e.g. `content.field_x`). |
| `key` | string | — | Render-array property to receive the attributes. A leading `#` is added if missing (so `'image_attributes'` → `#image_attributes`). |
| `attributes` | map/string | — | Attribute name → value; value may be a string or array. |
| `add_to_children` | bool | `true` | If true, apply to each child element (`Element::children`) rather than the top-level array. |
| `override` | bool | `false` | If false, array values are deep-merged (`NestedArray::mergeDeepArray`) with any existing value; if true, replace it. |

Returns the altered render array. There is special handling for `#type => link` elements: a
`#link_attributes` key is merged into `#options.attributes`.

## Examples

```twig
{# class on an image field's <img> #}
{{ content.field_img|add_attr('image_attributes', {class: ['my-class']}) }}

{# id on a link field's <a> #}
{{ content.field_link|add_attr('link_attributes', {id: 'custom-id'}) }}

{# chain to set attributes on several elements #}
{{ content.field_image
   |add_attr('image_attributes', {class: ['custom-image-class']})
   |add_attr('link_attributes', {class: ['custom-link-class']}) }}
```

## Which `key` to use with core field templates

The filter only sets a render-array property; the template must actually render it. This
module adds that support to core formatters via `hook_theme_registry_alter` + preprocess in
`twig_attributes.module`:

| Template | Keys available |
|---|---|
| `image_formatter` | `image_attributes` (on `<img>`), `link_attributes` (on link) |
| `responsive_image_formatter` | `image_attributes` (on `<img>`), `link_attributes` (an `Attribute` object; render e.g. `<a{{ link_attributes|without('href') }} href="{{ url }}">`) |
| `file_link` | `link_attributes` (on the file `<a>`) |

For other elements, use the property name that element's template reads (commonly
`attributes`), e.g. `|add_attr('attributes', {class: ['x']})`.
