<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attach autocompletion to a form element

Two ways a configuration reaches a field.

## 1. Front end, by CSS selector

The configuration's `selector` (e.g. `#edit-keys`) is matched on the page and the autocomplete behavior
is bound to that input. This is how the shipped `search_block` / `search_form_*` configs work — you just
set the selector on the config entity, no code.

## 2. In code, via `#autocomplete_configuration`

`search_autocomplete_element_info_alter()` adds a `process_search_autocomplete` process callback to
autocomplete-capable elements. If an element carries the `#autocomplete_configuration` property (a
configuration id), `process_search_autocomplete()` calls `attach_configuration_to_element()` to:
- load the `autocompletion_configuration` (bail if missing or `status` is FALSE),
- resolve the `source` (view path + exposed filters, or direct URI),
- attach the `core/drupal.autocomplete` library and set `data-key` / `data-autocomplete-*` attributes.

```php
$form['keys'] = [
  '#type' => 'textfield',
  '#autocomplete_configuration' => 'my_search',   // an autocompletion_configuration id
];
```

The element must be an autocomplete-enabled element type (one whose `#process` includes
`processAutocomplete`). The heavy lifting (URL building, exposed-filter params, library attach) is done
by `attach_configuration_to_element()` in `search_autocomplete.module`.
