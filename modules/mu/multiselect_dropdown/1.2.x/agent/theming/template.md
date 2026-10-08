<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multiselect Dropdown — theming

## Theme hook & template
- Theme hook `multiselect_dropdown` (render element `element`), default template
  `templates/multiselect-dropdown.html.twig`.
- Preprocess: `template_preprocess_multiselect_dropdown()` builds all the `*_attributes`
  (`Attribute` objects) and `*_label` variables, nests children, and attaches the
  `multiselect_dropdown/element` library.

## Theme suggestions
- `multiselect_dropdown_theme_suggestions_alter()` adds `multiselect_dropdown__<name>`
  (based on `#name`).
- The BEF submodule adds view/display-specific suggestions:
  `multiselect_dropdown__<view_id>`, `__<view_id>__<name>`, `__<view_id>__<display_id>`,
  `__<view_id>__<display_id>__<name>`.

## Required attributes (must remain when overriding the template)
JS keys off `data-*` attributes; keep these or the widget breaks:
- Root: `data-multiselect-dropdown`, plus data-* label attributes
  (`-label-none/-all/-single/-plural`), `data-multiselect-dropdown-breakpoint`,
  `data-drupal-selector`, and (when default-open) `data-multiselect-dropdown-open`.
- Toggle button: `data-multiselect-dropdown-toggle`, `aria-controls`, `aria-expanded`.
- Dialog: `data-multiselect-dropdown-dialog` (and `open` when default-open).
- Wrapper: `data-multiselect-dropdown-wrapper`, `tabindex="0"`.
- Buttons: `data-multiselect-dropdown-dialog-close`, `-select-all`, `-select-none`,
  `-submit`, `-clear`.
- Containers: `data-multiselect-dropdown-scroll`, `-list`.
- Search input: `data-multiselect-dropdown-search`,
  `data-multiselect-dropdown-search-character-threshold`, `data-bef-auto-submit-exclude`.

Available preprocess variables include `toggle_label`, `toggle_attributes`,
`dialog_attributes`, `wrapper_attributes`, `close_label`/`close_attributes`,
`select_all_*`, `select_none_*`, `scroll_attributes`, `list_attributes`, `submit_*`,
`clear_*`, `search` (a `#type => search` render array, only when `#search_title` set), and
`children` (nested checkbox render arrays).

## Libraries (`multiselect_dropdown.libraries.yml`)
- `element` — `css/multiselect-dropdown.css` + `js/dist/multiselect-dropdown(s).js`
  (ES modules); deps `core/drupal`, `core/once`. Attached automatically.
- `field_widget` — extra CSS for Claro; deps `element`.
- `views` — `js/dist/multiselect-dropdown-views.js`; deps `element` (attached by the BEF widget).

For views with custom templates, add `[data-multiselect-dropdown-view-results]` to the
result/no-result containers if the theme lacks the default `view-content` / `view-empty`
classes (so focus management works).
