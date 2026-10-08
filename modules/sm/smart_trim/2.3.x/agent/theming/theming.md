# Theming

Theme hook `smart_trim` (registered in `src/Hook/SmartTrimHooks.php`), template
`templates/smart-trim.html.twig`. Copy it into your theme to control the trimmed markup.

Available variables:
- `output` — the trimmed, rendered text.
- `is_trimmed` — TRUE if the text was actually cut.
- `wrap_output` / `wrapper_class` — legacy div wrapper (deprecated, removed in 3.0).
- `more` — render array for the "Read more" link (may be null).
- `more_wrapper_class` — class for the more-link wrapper.
- `field`, `entity_type`, `entity_bundle` — context of the rendered field.

Theme suggestions (`hook_theme_suggestions_smart_trim_alter`) are generated for every
combination of entity type / bundle / field, most specific last, e.g.:
`smart-trim--<entity_type>.html.twig`,
`smart-trim--<entity_type>--<bundle>.html.twig`,
`smart-trim--<entity_type>--<bundle>--<field>.html.twig`.
Name your override after the target and it wins over the base template.

There is also a Twig extension (`smart_trim.twig_extension`, wrapping the
`smart_trim.truncate_html` service) if you need HTML-aware truncation directly in Twig.
