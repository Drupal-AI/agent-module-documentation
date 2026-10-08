<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Font Awesome Iconpicker — plugins, theme & library

All plugins are **core** field plugin types (widget/formatter) — the module defines **no new
plugin type**, no services, and no hooks beyond `hook_help` and `hook_theme`.

## Field widget — `fontawesome_iconpicker`

`src/Plugin/Field/FieldWidget/FontawesomeIconpicker.php`
(`@FieldWidget id = "fontawesome_iconpicker"`, `field_types = {text, string}`,
extends `WidgetBase`).

- `formElement()` builds a `textfield` (class `fontawesomeIconPickerVanillaIconPicker`,
  `data-theme=default`) and JSON-encodes a `data-option` config for the JS: `theme`,
  `iconSource` (FontAwesome Solid/Regular 5, Solid/Regular/Brands 6), `closeOnSelect`, and
  i18n strings. Attaches library `fontawesome_iconpicker/vanilla-icon-picker`.
- When the widget `type` setting is `component`, it switches the option `theme` to `bootstrap`
  and also attaches `fontawesome_iconpicker/vanilla-icon-picker-theme-bootstrap`.
- The stored value is the raw icon class string the picker returns.

## Field formatter — `fontawesome_iconpicker_formatter_type`

`src/Plugin/Field/FieldFormatter/FontawesomeIconpicker.php`
(`@FieldFormatter id = "fontawesome_iconpicker_formatter_type"`, `field_types = {text, string}`,
extends `FormatterBase`).

- `viewElements()` renders each item through `#theme => 'fontawesome_iconpicker_formatter'`
  with `#icon` (HTML-escaped stored value) and `#size` (the `size` setting), attaching the
  `fontawesome_iconpicker/fontawesome` library.

## Theme hook & template

`hook_theme` registers `fontawesome_iconpicker_formatter` with variables `icon` and `size`
(default `1x`). Template `templates/fontawesome-iconpicker-formatter.html.twig`:

```twig
{% set classes = ['fa', icon, size] %}
<i{{ attributes.addClass(classes) }} aria-hidden="true"></i>
```

So a stored icon `fa-house` at size `fa-2x` renders `<i class="fa fa-house fa-2x"
aria-hidden="true"></i>`.

## Libraries (`fontawesome_iconpicker.libraries.yml`)

- `vanilla-icon-picker` — the JS (`/libraries/vanilla-icon-picker/dist/icon-picker.min.js` +
  the module's `js/fontawesome_iconpicker_vanilla.js`), depends on `core/drupal`, `core/once`,
  and the default theme CSS.
- `vanilla-icon-picker-theme-default` / `vanilla-icon-picker-theme-bootstrap` — picker themes.

External dependency: `d34dman/vanilla-icon-picker ^1.3.0` (Composer), plus the contrib
`fontawesome` module for the actual icon CSS/webfont.
