<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout template overrides & theme hooks

The module ships its own layout templates so the injected section title, `id`, and classes
actually render. If your theme overrides the same layout templates, you must port these changes
in or the extra output is lost.

## `hook_theme()` registrations

`layout_builder_sections_config_theme()` registers (and
`hook_module_implements_alter()` forces the module's `theme` hook to run **after** core so its
paths win):

| Theme hook | Template | Path |
|---|---|---|
| `layout` | `templates/layout.html.twig` | module root (generic base) |
| `layout__onecol` | `layouts/onecol/layout--onecol.html.twig` | `layouts/onecol` |
| `layout__twocol_section` | `layouts/twocol_section/layout--twocol-section.html.twig` | `layouts/twocol_section` |
| `layout__threecol_section` | `layouts/threecol_section/layout--threecol-section.html.twig` | `layouts/threecol_section` |
| `layout__fourcol_section` | `layouts/fourcol_section/layout--fourcol-section.html.twig` | `layouts/fourcol_section` |

Each `layouts/<name>/` folder also ships a matching CSS file (`onecol.css`,
`twocol_section.css`, …) for the title position/colour classes.

## What the template adds

The templates print the title block the preprocess hook builds:

```twig
{% if content.title %}
  <div class="{{ content.title.attributes.class|join(' ') }}">
    {% if content.title.wrapper %}<{{ content.title.wrapper }}>{% endif %}
    {{- content.title.label -}}
    {% if content.title.wrapper %}</{{ content.title.wrapper }}>{% endif %}
  </div>
{% endif %}
```

plus the section `attributes` already carry the `id` and merged `section_classes` set in
`hook_preprocess_layout()`.

## Porting into your theme

If your theme (or another module) provides `layout--twocol-section.html.twig` etc., copy the
`content.title` block above into your version and keep using `attributes` (which already include
the id/classes). Otherwise the section-config title will not appear even though the data is
saved. The module's `layouts/*.css` is a reference for styling the
`section-left-title` / `section-black-title`-style classes.
