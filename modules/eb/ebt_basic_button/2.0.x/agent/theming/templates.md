<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming

Two block template overrides render the button:
- `templates/block--block-content--ebt-basic-button.html.twig` — reusable/library blocks.
- `templates/block--inline-block--ebt-basic-button.html.twig` — inline Layout Builder blocks.

The template reads `field_ebt_settings` via
`content.field_ebt_settings['#object'].field_ebt_settings.0.ebt_settings.*` and builds a class list:
- alignment → `ebt-align-left|center|right`
- shape → `ebt-shape-square|round|circle`
- size → `ebt-size-small|medium|large`
- `stretched` (and legacy `stetched`) → `ebt-stretched`
- base classes always include `ebt-block`, `ebt-basic-button`, `ebt-block-<plugin_id>`.

The link is output as `<a href=… class="ebt-basic-button {{ custom_class_name }}" …>` with `nofollow`
and `target="_blank"` toggled from settings. The generated per-block CSS is printed at the end as
`{{ button_styles|raw }}` (see [../configure/block.md](../configure/block.md) for how it is built).

Front-end CSS library `ebt_basic_button/ebt_basic_button_view` (`css/ebt_basic_button_view.css`) is
attached via `attach_library` in the template. To customize markup, override either twig file in your
theme; to restyle, override that CSS library or add classes through the block's *Custom class name*
setting.
