# Theming the exposed form

BEF adds extra wrapper markup and its own Twig templates so exposed filters are easy to
style. Templates live in `templates/` and are registered in
`includes/better_exposed_filters.theme.inc` (`hook_theme`).

## Templates / theme hooks
- `bef-checkboxes.html.twig` (`bef_checkboxes`)
- `bef-radios.html.twig` (`bef_radios`)
- `bef-links.html.twig` (`bef_links`)
- `bef-number.html.twig` (`bef_number`)
- `bef-hidden.html.twig` (`bef_hidden`)
- `bef-nested-elements.html.twig` (`bef_nested_elements`)

Override any of them by copying into your theme and clearing caches. Each has a matching
`template_preprocess_bef_*()` in the theme.inc file (e.g. `template_preprocess_bef_links`
builds the link `#items`).

## Suggestions & preprocessing
- `better_exposed_filters_theme_suggestions_alter()` adds theme-hook suggestions so you
  can target a specific view/display/filter (e.g. `bef-links--<view-id>.html.twig`).
- `better_exposed_filters_preprocess_views_exposed_form()` augments the standard
  `views-exposed-form` variables (adds BEF classes, groups secondary options).

## CSS / JS libraries
Defined in `better_exposed_filters.libraries.yml`: `general`, `auto_submit`,
`select_all_none`, `sliders` (depends on `better_exposed_filters/nouislider`),
`datepickers`, `soft_limit`, `scrollable`, `links_use_ajax`, `reset_ajax`. Attach or
override these to change behavior/styling.
