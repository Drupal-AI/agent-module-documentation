# Theming (geofield_map_extras)

`geofield_map_extras.module` registers two theme hooks via `hook_theme()`, each with a
Twig template you can override in your theme.

## `geofield_static_google_map`

Template: `templates/geofield-static-google-map.html.twig`.
Variables: `width`, `height`, `scale`, `locations`, `zoom`, `langcode`, `static_map_type`,
`apikey`, `marker_color`, `marker_size`.

## `geofield_embed_google_map`

Template: `templates/geofield-embed-google-map.html.twig`.
Variables: `width`, `height`, `q`, `apikey`, `options_string`, `title`.

Both are output by the submodule's field formatters (see configure/formatters.md). Override
the template in your theme to change the generated markup / query string.
