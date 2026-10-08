<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `expand_collapse_formatter` FieldFormatter

The module defines **no plugin type of its own** — it provides one core `@FieldFormatter`
plugin. This doc is the reference for that plugin (for configuring it on a field, see
[../configure/expand_collapse_formatter.md](../configure/expand_collapse_formatter.md)).

## Plugin

- **Class:** `Drupal\expand_collapse_formatter\Plugin\Field\FieldFormatter\ExpandCollapseFormatter`
  (extends `Drupal\Core\Field\FormatterBase`).
- **id:** `expand_collapse_formatter`
- **label:** `Expand collapse formatter`
- **field_types:** `text_long`, `string_long`, `text_with_summary`, `text_long_with_summary`

## defaultSettings()

```php
[
  'trim_length'      => 300,
  'default_state'    => 'collapsed',   // 'collapsed' | 'expanded'
  'link_text_open'   => 'Show more',
  'link_text_close'  => 'Show less',
  'link_class_open'  => 'ecf-open',
  'link_class_close' => 'ecf-close',
]
```

## Render / theming

`viewElements()` renders each field item with:

- `#theme` = `expand_collapse_formatter` (theme hook registered in
  `expand_collapse_formatter_theme()`; template `templates/expand-collapse-formatter.html.twig`).
- `#value` = the item's `processed` (filtered) markup, falling back to raw `value`.
- All six settings passed as `#trim_length`, `#default_state`, `#link_text_open`,
  `#link_text_close`, `#link_class_open`, `#link_class_close`.
- `#attached` library `expand_collapse_formatter/expand_collapse_formatter`.

The template emits `<div class="expand-collapse" data-trim-length data-default-state
data-link-text-open data-link-text-close data-link-class-open data-link-class-close>` with a
`.ec-content` inner div holding the value.

## JavaScript behavior

`js/expand_collapse_formatter.js` (`Drupal.behaviors.expandCollapseFormatter`, using
`core/once` on `.expand-collapse`) reads the `data-*` attributes, and **only if the field's
plain-text length exceeds `trim_length`** creates an `<a class="ec-toggle-link …">` toggle
after `.ec-content`. `toggle()` swaps between the full HTML and text trimmed to
`trim_length` (cut at the last space, plus ` ...`), updating the link text/class from the
open/close settings. Library deps: `core/drupal`, `core/once`.

## Extending

To change markup, override the `expand_collapse_formatter` theme hook or the
`expand-collapse-formatter.html.twig` template in your theme. To change behavior, subclass
`ExpandCollapseFormatter` in a custom module's `Plugin/Field/FieldFormatter/` with a new
`@FieldFormatter` id.
