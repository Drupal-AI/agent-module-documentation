<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: templates & theme hooks

`hook_theme()` (`src/Hook/ThemeHooks.php`) registers four theme hooks; templates live in
`templates/`.

| Theme hook | Template | Variables |
|---|---|---|
| `name_item` | `name-item.html.twig` | `item` (component array), `format`, `settings`, `formatted_name` |
| `name_item_list` | `name-item-list.html.twig` | `items`, `settings` |
| `name` | *(FAPI element)* | `element` — the render element |
| `name_format_parameter_help` | `name-format-parameter-help.html.twig` | `tokens` |

The default `name-item.html.twig` simply prints `{{ formatted_name }}` (the string produced
by the format parser), so overriding it is how you add wrapper markup, microdata, or extra
classes around a single rendered name. `name_item_list` wraps the "A, B and C / et al." list.

Override in a theme by copying the template into your theme's `templates/` directory and
running `drush cr`. Component-level CSS classes (when the formatter `markup` setting is
`simple`) come from the parser, styled by `css/name.icon.css` / `css/name.inline.css`.

The FAPI render element itself is `\Drupal\name\Element\Name` (`#type => 'name'`), themed via
the `name` theme hook — reuse it to render a name-component form group outside the field
widget.
