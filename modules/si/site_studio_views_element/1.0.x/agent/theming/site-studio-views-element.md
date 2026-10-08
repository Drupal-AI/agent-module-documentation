<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — site_studio_views_element

The module declares one theme hook in `site_studio_views_element_theme()`
(`site_studio_views_element.module`):

- Hook: `site_studio_views_element`
- Template: `site-studio-views-element.html.twig`
- `render element`: `children`
- Variables (all default `NULL`):
  - `elementSettings` — the raw element settings array (contains `view_id`). Not printed by the
    default template.
  - `elementMarkup` — the Views render array returned by `ViewsElement::render()`. This is the actual
    listing output.
  - `elementContext` — the Site Studio context array. Not printed by the default template.
  - `elementClass` — the CSS class string Site Studio assigns to the element.

## Default template

`templates/site-studio-views-element.html.twig` is three lines:

```twig
<div class="{{ elementClass }}" data-element="site-studio-views-element">
  {{ elementMarkup }}
</div>
```

`elementMarkup` is a render array, so Twig renders it through the normal render pipeline (the View's
own `views-view.html.twig` etc. apply). `elementClass` is printed as an attribute value with Twig
auto-escaping on. Nothing here disables escaping (no `|raw`), and the two unprinted variables
(`elementSettings`, `elementContext`) are not exposed as markup.

## Override it

Copy `site-studio-views-element.html.twig` into your theme's `templates/` directory to change the
wrapper — for example to add classes, a heading, or an extra wrapper element around the embedded View.
The variables above are what you have to work with. The embedded listing's own markup is controlled by
the View and its display, not by this template, so restyle the listing through Views/theme overrides
for that View rather than here.

There is no settings form and no config schema in this module; the template (and the View's own theme
layer) is the only customization surface.
