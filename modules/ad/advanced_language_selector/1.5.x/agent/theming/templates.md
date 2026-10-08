# Theming — templates, variables, flags

## One template per style
Each style has a Twig template in `templates/` named
`block--language-selector--<style-with-dashes>.html.twig`, registered as theme hook
`block__language_selector__<style>` (see the table in configure/block.md). Templates:

- `block--language-selector--bootstrap-dropdown.html.twig`
- `block--language-selector--bootstrap-navigation.html.twig`
- `block--language-selector--bootstrap-modal.html.twig`
- `block--language-selector--bootstrap-offcanvas.html.twig`
- `block--language-selector--bootstrap-list-group.html.twig`
- `block--language-selector--bootstrap-button-group.html.twig`
- `block--language-selector--plain-html-list.html.twig`
- `block--language-selector--select.html.twig` (the `plain_html` style)
- `block--language-selector--bootstrap-item.html.twig` — shared partial `include`d by the
  Bootstrap templates to render a single item (flag + code + name), passed `item` and `selected`.

`hook_theme()` (in the `.module`) registers these dynamically by iterating
`StyleManager::getAvailableStyles()`, so the theme hook name comes from each style YAML's `theme`
key.

## Variables available in every template
Set by `LanguageSelectorBlock::build()`:
- `links` — assoc array keyed by langcode; each item has `title`, `langcode`, `icon` (flag SVG
  path), `uri` (translated path), `current_langcode`, plus core switch-link data.
- `link_active` — the item for the current interface language.
- `configuration` — the saved per-style config subtree (e.g. `configuration.general.css`,
  `configuration.display.selected_item.show.icons`, `configuration.display.items.icon_height`).
  Plain templates read `configuration.display.items` / `configuration.display`.
- `templates_location` — absolute module path to `/templates` (used for `include` of the item
  partial).
- `attributes`, `set_active_class` — standard.

Templates guard everything with `{% if links %}`, compare `langcode != item.current_langcode` to
decide whether to wrap the item in an `<a>`, and honor `text_transformation` via Twig
`upper`/`lower`/`capitalize` filters. Icons render as `<img src="{{ item.icon }}"
height="{{ display.icon_height }}">`, placed before or after the label based on
`display.icon_alignment`. At the end, each template conditionally calls
`{{ attach_library(configuration.general.external_bootstrap_library) }}` when
`load_external_bootstrap` is enabled.

## Overriding markup
Copy the relevant `block--language-selector--<style>.html.twig` into your theme's `templates/`
directory and edit it; clear caches (`drush cr`). Standard Drupal theme override precedence
applies. Keep the `include` of `block--language-selector--bootstrap-item.html.twig` (or copy that
too) if you override a Bootstrap style, since it renders the per-item flag/label.

## Flag SVG assets
Flags live in `assets/flags/` (~269 SVGs, named by ISO country code, e.g. `es.svg`, `de.svg`,
plus special composites like `es-gl.svg`, `es-eu.svg`, and `no-flag.svg`). `src/Langcodes.php`
(`Langcodes::langcodeToCountryCode()`) maps a Drupal langcode to a flag filename via a large
`switch` (mostly `preg_match` on the language prefix). Unmapped langcodes fall back to
`no-flag.svg`. To use custom flag art, replace the SVG files in `assets/flags/` (paths are built
from the module directory in `getFlagIcon()`, so a template override alone will not change which
file is served).
