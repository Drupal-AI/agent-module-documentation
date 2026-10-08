# Theme: the `webicon()` Twig function

`Drupal\webicons\WebiconsTwigExtension` (service `webicons.twig_extension`, tagged `twig.extension`)
registers one function, `webicon`, so a theme/template can emit an icon without a field.

## Signature

```
webicon(libraryId, keyValues, classes = [])
```

- `libraryId` — one of `boxicons`, `fortawesome`, `materialicons` (a key of `IconServiceInterface::ICONS`,
  or any `webicons.<id>` factory service you add, see [api/services.md](../api/services.md)).
- `keyValues` — map of the icon's stored values: `icon_class` and/or `icon_code`.
- `classes` — extra CSS classes appended to the icon element.

Internally: `iconService->getIconFactory($libraryId)->getIconRenderArray($keyValues, $classes)` — the same
render array the field formatter uses, so field output and Twig output are identical.

## Examples (from the project page)

```twig
{# Material Icons — glyph via ligature (icon_code), tag <span> #}
{{ webicon('materialicons', {'icon_code': 'lock'}, ['material-icons-outlined']) }}

{# Boxicons — glyph via class (icon_class), tag <i> #}
{{ webicon('boxicons', {'icon_class': 'bx bxs-beer'}) }}

{# Font Awesome Free — glyph via class (icon_class), tag <i> #}
{{ webicon('fortawesome', {'icon_class': 'fa-solid fa-heart'}) }}
```

The call attaches the library's CSS (`webicons/<libraryId>`) automatically.

## Rendered markup and templates

`hook_theme()` (in `webicons.module`) defines two theme hooks:

| Hook | Template | Variables |
|---|---|---|
| `webicon_field__value` | `templates/webicon-field--value.html.twig` | `item` (`{icon_class, icon_code}`), `library`, `classes`, `tag` |
| `icon_selector` | (via controller; `templates/icon-selector.html.twig`) | `icons`, `library`, `renderer` |

`webicon-field--value.html.twig` composes `['webicon', item.icon_class]` merged with `classes`, then:

```twig
{% if tag == 'i' %}
  <i class="{{ all_classes|join(' ') }}"></i>
{% else %}
  <span class="{{ all_classes|join(' ') }}">{{ item.icon_code }}</span>
{% endif %}
```

`#tag` defaults to `i` (`IconFactory::getIconRenderArray()`); `MaterialiconsIconFactory` overrides it to
`span` and emits `icon_code` (the ligature) as the element's text. Both `item.icon_class` and
`item.icon_code` pass through Twig's default HTML autoescaping.

To override the markup, provide your own `webicon-field--value.html.twig` in your theme.
