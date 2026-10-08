<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — ept_basic_button

## Template

`templates/paragraph--ept-basic-button--default.html.twig` — the paragraph theme override for the
`ept_basic_button` bundle, default view mode. Structure:

```
<div{{ attributes.addClass(classes) }}>
  <div class="bg-inner"></div>
  <div class="ept-container">
    <h2>{{ content.field_ept_title }}</h2>          {# only if non-empty #}
    {{ content|without('field_ept_settings','field_ept_basic_button_link','field_ept_title') }}
    <span class="ept-basic-button-wrapper">
      <a href="…link.0['#url']" class="ept-basic-button {{ button_custom_classes }}" …>…#title…</a>
    </span>
  </div>
</div>
{{ styles|raw }}
{{ button_styles|raw }}
```

The link's `href`/label come from `field_ept_basic_button_link.0` (`#url` / `#title`). Body text
(`field_ept_text`) prints via the `content|without(...)` catch-all.

## Class mapping (from `field_ept_settings`)

The template builds `classes` from the per-paragraph settings, in addition to the base
`paragraph ept-paragraph ept-basic-button paragraph--type--… ept-paragraph--type--…
paragraph-id-{id}` classes:

- `alignment` → `ept-align-left` / `ept-align-center` / `ept-align-right`
- `shape` → `ept-shape-square` / `ept-shape-round` / `ept-shape-circle`
- `size` → `ept-size-small` / `ept-size-medium` / `ept-size-large`
- `stretched` (or legacy `stetched`) → `ept-stretched`

`open_in_new_tab` sets a `target="_blank"` string and `add_nofollow` sets a `rel="nofollow"`
string, both printed onto the `<a>`. `custom_class_name` is printed as `button_custom_classes` onto
the `<a>`'s class attribute (validated to a strict identifier regex by the widget).

## Generated inline styles

`hook_preprocess_paragraph` (`EptBasicButtonHooks::preprocessParagraph`) runs only for the
`ept_basic_button` bundle. It reads `field_ept_settings` and calls the
`ept_basic_button.generate_custom_css` service (`Services\GenerateCustomCSS`), assigning the result
to the `button_styles` variable. That service emits a scoped `<style>` block targeting
`.paragraph-id-{id} .ept-basic-button` (and a `.ept-basic-button2` selector for a second link
option), setting `color` / `background-color` for normal and `:hover` states from the widget's
color fields. Color values are hex-validated at input and additionally passed through
`Html::escape()` before being written into the CSS. The `styles` variable (also printed `|raw`) is
supplied by `ept_core`'s shared preprocessing for the common design options (box/background/width).

## Libraries / assets

- `ept_basic_button/ept_basic_button_view` — `css/ept_basic_button_view.css`; attached from the
  template via `attach_library` (component CSS for the button).
- `ept_basic_button/ept_basic_button_form` — `js/ept_basic_button_form.js` (jQuery/once/drupal
  settings); attached by the widget for the edit form, alongside `ept_core/colorpicker`.

## Overriding

Copy the template into your theme (Paragraphs' theme suggestions apply) to change markup or classes.
To restyle without a template override, target the `ept-*` classes above or add
`custom_class_name` per instance. There are no custom theme hooks or render elements to register —
this is a standard Paragraphs bundle template plus preprocess-injected style strings.
