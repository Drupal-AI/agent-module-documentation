# Color pickr — theme hooks & templates

`hook_theme` (in `color_pickr.module`) registers five hooks, each with one variable `color_pickr`
(the stored value) and a template in `templates/`:

| Theme hook | Template | Default markup |
|---|---|---|
| `color_pickr_default` | `color-pickr-default.html.twig` | `<div class="snippets-description">{{ color_pickr }}</div>` |
| `color_pickr_square` | `color-pickr-square.html.twig` | `<div class="color-pickr-square" style="background-color: {{ color_pickr }};"></div>` |
| `color_pickr_circle` | `color-pickr-circle.html.twig` | `<div class="color-pickr-circle" style="…">` |
| `color_pickr_hexagon` | `color-pickr-hexagon.html.twig` | `<div class="color-pickr-hexagon" style="…">` |
| `color_pickr_line` | `color-pickr-line.html.twig` | `<div class="color-pickr-line" style="…">` |

Each template only renders when `color_pickr` is truthy (`{% if color_pickr %}`). Shape CSS ships in
`css/color_pickr.css` (loaded by the `color_pickr` library) and `css/color-pickr-front.css`
(library `color_pickr_front`).

## Overriding
- Copy a template into your theme (e.g. `color-pickr-circle.html.twig`) and adjust the markup/size.
- Or implement `hook_theme_suggestions_color_pickr_circle_alter()` / `hook_preprocess_HOOK()` to
  add classes or reshape the value.
- The value is emitted into a `style="background-color: …"` attribute; Twig autoescapes it in HTML
  context. If you output the value elsewhere (e.g. a JS/CSS context), sanitize it yourself.
