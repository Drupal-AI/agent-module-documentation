<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Render element, route & internals

The module defines **no plugin manager / plugin type** you extend. What it ships is one
field widget plus one custom form (render) element and an autocomplete controller.

## `autocomplete_deluxe` render element

`src/Element/AutocompleteDeluxeElement.php` (`@FormElement("autocomplete_deluxe")`) is the
element the widget builds. You can also use it directly in a custom form:

```php
$form['tags'] = [
  '#type' => 'autocomplete_deluxe',
  '#title' => $this->t('Tags'),
  '#target_type' => 'taxonomy_term',
  '#selection_handler' => 'default',
  '#selection_settings' => [
    'target_bundles' => ['tags' => 'tags'],
    'match_operator' => 'CONTAINS',
    'match_limit' => 10,
  ],
  '#autocomplete_route_name' => 'autocomplete_deluxe.autocomplete',
];
```

Key properties: `#target_type`, `#selection_handler`, `#selection_settings`,
`#autocomplete_route_name`, `#multiple` (the widget sets it from field cardinality),
`#not_found_message` / `#not_found_message_allow`, `#new_terms`, `#no_empty_message`,
`#delimiter`, `#size`, `#min_length`.

## Autocomplete route

`autocomplete_deluxe.autocomplete` →
`/autocomplete_deluxe/{target_type}/{selection_handler}/{selection_settings_key}`, handled by
`AutocompleteDeluxeController::handleAutocomplete`, gated by permission **`access content`**.
The `selection_settings_key` is a hashed key the widget stores in the `keyvalue` store
(collection so core's selection plugins can rebuild the query) — this mirrors core's
entity-reference autocomplete design, so matching honors the field's target bundles, sort,
and auto-create settings.

## JS / CSS libraries

Attached automatically by the element (no external jQuery UI download required): base
`autocomplete_deluxe/assets`, plus a theme-specific stylesheet chosen at runtime —
`assets.claro`, `assets.gin`, or `assets.seven`. Base library depends on core's
`drupal.autocomplete`, `jquery`, `once`, `drupal.dialog`, and `sortable`.

## What it does NOT provide

No hooks/`*.api.php`, no services you decorate, no Drush commands, no permissions of its own,
no config entity type. Integration points are: (1) selecting the widget on a field's form
display, and (2) reusing the `autocomplete_deluxe` render element in custom forms.
