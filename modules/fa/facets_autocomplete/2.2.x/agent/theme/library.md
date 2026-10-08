<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Front end: library, markup, CSS classes, drupalSettings

The whole autocomplete behaviour is a small asset library plus data the widget passes through
`drupalSettings`. No Twig or preprocessing is involved in practice.

## Library

`facets_autocomplete/drupal.facets_autocomplete.autocomplete-widget`
(`facets_autocomplete.libraries.yml`):

- CSS (base): `css/autocomplete-widget.css`
- JS: `js/autocomplete-widget.js`
- Dependencies: `core/jquery`, `core/drupal`, `core/once`, `core/drupalSettings`

Attached automatically by `AutoCompleteWidget::build()`; you do not attach it yourself.

## Markup produced

- The field is a core `textfield` with `id` = `data-id` = the facet id, class `autocomplete-facet`.
- The JS injects a suggestion container `<div class="autocomplete-items">` (id
  `<facet_id>autocomplete-list`) after the field; the arrow-key–highlighted item gets class
  `autocomplete-active`.
- When `show_reset_link` is on, the reset anchor is the field suffix:
  `<a id="<facet_id>-reset" class="autocomplete-items__reset" href="…">`.

## CSS classes (all styling hooks)

`css/autocomplete-widget.css` styles `.autocomplete` (relative container), `.autocomplete-items`
(the dropdown), `.autocomplete-items div` (each suggestion), and `.autocomplete-active` (keyboard
selection). Override these in your theme to restyle; there are no other selectors. Note the field
itself carries `.autocomplete-facet` and the reset link `.autocomplete-items__reset`.

## drupalSettings shape (per facet)

```
drupalSettings.facets_autocomplete.autocomplete_widget[<facet_id>] = {
  results:       { <rawValue>: "<escaped display value> [ (count)]", … },  // filtered by the JS
  urls:          { "<display value> [ (count)]": "<facet result URL>", … }, // selection target
  default_value: "<label of the active item, or ''>",
  reset_url:     "<url or ''>"
}
```

Display values are passed through `Html::escape()` before entering `results`, and the JS builds the
suggestion DOM from those already-escaped strings.

## Theme hook (mostly vestigial)

`facets_autocomplete.module` registers `hook_theme()` entry `facets_autocomplete` (render element
`children`) with template `templates/facets-autocomplete.html.twig`. That template is an **empty
placeholder** ("Add your custom twig html here") and `build()` renders a plain `textfield` render
element rather than `#theme => 'facets_autocomplete'`, so overriding the Twig has no effect unless
you subclass the widget to use the theme hook. `hook_help()` only prints the one-line description on
the module help page.
