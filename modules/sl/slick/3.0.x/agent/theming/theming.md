# Theming — templates & theme hooks

`slick_theme()` registers six theme hooks, all rendered from `templates/slick.theme.inc` with a
single `element` render element. Override any by copying the Twig file into your theme.

| Theme hook | Template | Role |
|---|---|---|
| `slick` | `slick.html.twig` | The carousel container / top-level wrapper |
| `slick_slide` | `slick-slide.html.twig` | A single slide |
| `slick_grid` | `slick-grid.html.twig` | Grid-of-slides layout (multiple items per slide) |
| `slick_thumbnail` | `slick-thumbnail.html.twig` | Thumbnail navigation slide (asNavFor) |
| `slick_vanilla` | `slick-vanilla.html.twig` | Unprocessed/vanilla slide passthrough |
| `slick_wrapper` | `slick-wrapper.html.twig` | Wraps main + thumbnail carousels together |

## Overriding
Copy e.g. `slick-slide.html.twig` to `themes/mytheme/templates/`, clear cache (`drush cr`).
Suggestions follow the usual Drupal pattern; each template receives the prepared `element`
(items, settings, attributes) built by `SlickManager`.

## Libraries / CSS
Assets are declared in `slick.libraries.yml`. Notable Drupal-side libraries you can attach or
depend on: `slick/base`, `slick/slick.load`, `slick/slick.theme`,
`slick/slick.thumbnail.hover`, `slick/slick.thumbnail.grid`, `slick/slick.arrow.down`,
`slick/slick.colorbox`, `slick/vanilla`. Skins (see
[../plugins/skins.md](../plugins/skins.md)) add their own CSS on top. The external Slick JS
library itself is expected under `/libraries/slick` (or `/libraries/accessible-slick`).
