<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming

`range_theme()` registers exactly two theme hooks. Every formatter renders through one of them,
chosen per item by `RangeFormatterBase::viewElements()`: the **combined** template when
`range_combine` is on *and* the formatted FROM equals the formatted TO, otherwise the
**separate** template.

## `range_formatter_range_separate`

Template: `templates/range-formatter-range-separate.html.twig`

Variables: `item` (the range field item object), `field_prefix`, `from_prefix`, `from`,
`from_suffix`, `range_separator`, `to_prefix`, `to`, `to_suffix`, `field_suffix`.

The stock template is a single whitespace-controlled line:

```twig
{{- field_prefix }}{{ from_prefix }}{{ from }}{{ from_suffix }}{{ range_separator }}{{ to_prefix }}{{ to }}{{ to_suffix }}{{ field_suffix -}}
```

## `range_formatter_range_combined`

Template: `templates/range-formatter-range-combined.html.twig`

Variables: `item`, `field_prefix`, `value_prefix`, `value`, `value_suffix`, `field_suffix`.

```twig
{{- field_prefix }}{{ value_prefix }}{{ value }}{{ value_suffix }}{{ field_suffix -}}
```

Note that a prefix/suffix variable is only populated when the formatter's matching
`*_prefix_suffix` setting is TRUE; otherwise it is simply absent from the render array.
`field_prefix`/`field_suffix` are set as `#field_prefix`/`#field_suffix` on the element, not
inside the theme variables' string flow, so they wrap the whole item.

## Overriding

Copy either template into your theme (`mytheme/templates/range-formatter-range-separate.html.twig`),
clear caches, and edit. Both are `@ingroup themeable`. To vary per field, add a
`hook_theme_suggestions_range_formatter_range_separate_alter()` in your theme — the module ships
no suggestions of its own, but `item` gives you `item.getFieldDefinition().getName()`.

## CSS libraries

| Library | Attached by | Contains |
|---|---|---|
| `range/range.field-widget` | the `range` widget's `formElement()` | `css/range.field-widget.css` — floats the FROM/TO inputs side by side |
| `range/range.range-icon` | `range.field_type_categories.yml` (field-type picker) | `css/range.icon.theme.css`; depends on `field_ui/drupal.field_ui.manage_fields` |
