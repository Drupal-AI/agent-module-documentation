<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming

Two block template overrides render the button (identical logic, different block context):
- `templates/block--block-content--ebt-bootstrap-button.html.twig` — reusable/library blocks.
- `templates/block--inline-block--ebt-bootstrap-button.html.twig` — inline Layout Builder blocks.

Both read the stored settings via
`content.field_ebt_settings['#object'].field_ebt_settings.0.ebt_settings.*` and build two class lists:

- **Container `classes`**: base `block ebt-block ebt-bootstrap-button ebt-block-<plugin_id>
  block-<provider> block-<plugin_id>` plus `plugin-id-<plugin_id>` (reusable) or
  `block-revision-id-<id>` (inline); alignment → `ebt-align-left|center|right`; `stretched`/legacy
  `stetched` → `ebt-stretched`.
- **`button_classes`**: always `btn`; then `btn-<button_type>` or `btn-outline-<button_type>`;
  `active` if active_button; `disabled` if disable_button; `size-default|btn-sm|btn-lg`; and the
  `custom_class_name` string appended.

The link is emitted as:

```
<a href="{{ content.field_ebt_bootstrap_button_link.0['#url'] }}"
   class="{{ button_classes|join(' ') }}" {{ nofollow|raw }} {{ target|raw }}>{{ content.field_ebt_bootstrap_button_link.0['#title'] }}</a>
```

`#url` (a `Url` object from the `link` formatter) and `#title` are printed through Twig
auto-escaping. `nofollow` (`' rel="nofollow"'`) and `target` (`' target="_blank"'`) are fixed literal
strings set from the boolean settings, printed with `|raw`. The remaining rendered field content is
output via `content|without('field_ebt_settings', 'field_ebt_bootstrap_button_link')`.

The frontend library `ebt_bootstrap_button/ebt_bootstrap_button_view` (`css/ebt_bootstrap_button_view.css`)
is attached via `attach_library` in the template. Actual button colours/shapes come from **Bootstrap's**
`btn`/`btn-*` classes, which your theme must provide — this module ships only alignment/stretch CSS.

The design-layer inline CSS is printed at the very end as `{{ styles|raw }}`. That `styles` variable
is built by **ebt_core** (its `GenerateCSS`/preprocess), not by this module — this module has no
preprocess or CSS-generation hook of its own (its only `hook` is `help`).

To customize markup, override either twig file in your theme; to restyle, override the CSS library or
add classes through the block's *Custom class name* setting.
