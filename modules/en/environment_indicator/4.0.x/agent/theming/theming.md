# Theming the indicator

Theme hook `environment_indicator` (render element `element`), template
`templates/environment-indicator.html.twig`. There is also a render element
`EnvironmentIndicator` (`src/Element/EnvironmentIndicator.php`).

## Template variables
`template_preprocess_environment_indicator()` prepares:
- `title` — the environment name (`#title`).
- `fg_color`, and an inline `attributes.style` combining `#bg_color`/`#fg_color`.
- `description` — optional (`#description`).
- `switcher` — the switcher dropdown render array (if any).
- `attributes` — includes the element `id` (default `environment-indicator`).

## Override
Copy `environment-indicator.html.twig` into your theme to change the banner markup, or use
`hook_preprocess_environment_indicator()` to add classes/attributes. Colors come from the
active indicator/switcher config, so you normally set them in config (see
[../configure/settings.md](../configure/settings.md)) rather than CSS.

The banner is placed via `hook_page_top()`; the (deprecated, removed in 5.0)
`hook_toolbar()` integration lives here too — prefer the `environment_indicator_toolbar`
submodule for toolbar tinting.
