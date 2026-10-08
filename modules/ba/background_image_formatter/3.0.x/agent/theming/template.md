<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: the inline background template

Only the **inline** output type uses a template; the **css** output type just injects a
`<style>` tag and has no theme hook.

## Theme hook

`background_image_formatter_inline` (declared via the `#[Hook('theme')]` attribute in
`src/Hook/BackgroundImageFormatterHooks.php`). Variables:

- `background_image_selector` — the CSS class (already suffixed with `_<entity id>`).
- `image_uri` — absolute URL to the (styled) image.
- `url` — optional URL to wrap the div in an `<a>`.
- `entity_type`, `entity_bundle`, `entity`, `field_name`, `delta` — context for suggestions.

Default template `templates/background-image-formatter-inline.html.twig`:

```twig
{% if url %}<a href="{{ url }}">{% endif %}
<div class="{{ background_image_selector }}" style="background-image: url('{{ image_uri }}');">
  &nbsp;
</div>
{% if url %}</a>{% endif %}
```

## Theme suggestions

`hook_theme_suggestions_background_image_formatter_inline()` provides, in increasing
specificity:

```
background_image_formatter_inline__<entity_type>
background_image_formatter_inline__<entity_type>__<bundle>
background_image_formatter_inline__<entity_type>__<bundle>__<field_name>
background_image_formatter_inline__<entity_type>__entityid_<id>
```

So to override the markup for, say, Article hero fields, add a template
`background-image-formatter-inline--node--article--field-hero-image.html.twig` to your theme.
