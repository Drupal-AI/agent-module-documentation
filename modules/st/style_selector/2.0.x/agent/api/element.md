<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `style_selector` render element & services

## Form element
`'#type' => 'style_selector'` (class `Drupal\style_selector\Element\StyleSelector`, `@FormElement`)
renders the swatch picker in any Form API form — handy for Layout Builder / custom settings forms.

Custom properties:
- `#options` (array) — `value => label` pairs (required; empty options → element renders nothing).
- `#style_type` — `css_class` (default) or `css_color`. Colors are validated via
  `style_selector.css_color::getFormSafeColorValue()`; invalid colors are dropped.
- `#multiple` (bool, default FALSE) — checkboxes vs radios.
- `#ui_variant` (array) — e.g. `['compact' => ['type' => 'round', 'size' => 'large']]` or `['tile' => [...]]`;
  built-in variants `compact`/`tile` auto-attach `style_selector/widget_<variant>`.
- `#ui_settings` (array) — booleans `alpha_grid`, `check_icon`, `empty_icon`, `text_icon`.
- `#extra_classes` (string) — space-separated; each gets an `ssui--` prefix.
- `#empty_option` (string) — label for the None option (single, non-required only).
- `#color_prop` — CSS property used to preview color options.

Internally it builds a `radios`/`checkboxes` sub-element keyed `style_selector`; `valueCallback`
delegates to `Radios`/`Checkboxes`. Configured `admin_libraries` + `shared_libraries` are auto-attached.

## Services
- `style_selector.util` (`Services\Utility`) — helpers: `getDefaults()`/`getDefault()`,
  `getClasses()`, `getClassList()`, `sanitizeClasses()`, `getStyleSelectorFields()`,
  `getFieldValues()`. Used by the formatters and element to discover fields and sanitize class lists.
- `style_selector.css_color` (`Services\CssColor`) — color handling:
  `validateCssColor()`, `validateHex()`, `getFormSafeColorValue()`, `hexToRgbCss()`, `hexToRgb()`,
  `normalizeHex()`. Accepts hex, rgb/rgba, hsl/hsla, named/system colors and keywords; hex is
  converted to RGB/A.
