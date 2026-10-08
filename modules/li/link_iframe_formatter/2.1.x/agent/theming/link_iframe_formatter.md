<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme hook & template

The module declares one theme hook in `link_iframe_formatter_theme()`
(`link_iframe_formatter.module:11`):

| Theme hook | Template | Variables (defaults) |
| --- | --- | --- |
| `link_iframe_formatter` | `templates/link-iframe-formatter.html.twig` | `url` (NULL), `width` (NULL), `height` (NULL), `class` (NULL), `original` (NULL), `path` (NULL), `scrolling` (`'yes'`) |

`url` and `path` are the same core `Url` object (the field's link). The shipped template
(`link-iframe-formatter.html.twig`):

```twig
{% apply spaceless %}
  <iframe width="{{ width }}" height="{{ height }}" src="{{ url }}" class="{{ class }}"
          frameborder="0" scrolling="{{ scrolling }}" allowfullscreen></iframe>
  {% if original %}
    <div class="link-iframe-formatter-original">{{ 'You may view the original link at:'|t }}
      <a href="{{ url }}">{{ url }}</a><div>
  {% endif %}
{% endapply %}
```

All variables are printed through normal Twig auto-escaping (no `|raw`), so a value containing `"` or
`<` is escaped and cannot break out of an attribute. The optional "original link" block renders only
when the `original` formatter setting is On; note the block's closing tag is `<div>` rather than
`</div>` in the shipped markup (a harmless cosmetic bug).

## Overriding

Copy the template into your theme (e.g. `themes/custom/mytheme/templates/link-iframe-formatter.html.twig`)
and rebuild caches. Common, recommended additions:

- **`sandbox="…"`** — restrict what the embedded page may do (drop `allow-scripts`/`allow-top-navigation`
  to neutralise most embedding risk). The shipped template sets no `sandbox`.
- **`loading="lazy"`** — defer offscreen frames.
- **`title="{{ ... }}"`** — accessibility label for the frame.
- **`referrerpolicy`** / **`allow`** — control referrer leakage and feature permissions.

```twig
{% apply spaceless %}
  <iframe width="{{ width }}" height="{{ height }}" src="{{ url }}" class="{{ class }}"
          frameborder="0" scrolling="{{ scrolling }}" loading="lazy"
          sandbox="allow-same-origin" title="{{ 'Embedded content'|t }}" allowfullscreen></iframe>
{% endapply %}
```

The theme hook has no preprocess function in the module, so add a
`template_preprocess_link_iframe_formatter()` (or `mytheme_preprocess_link_iframe_formatter()`) in your
theme if you need to compute extra variables.
