<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `entity_reference_autocomplete_add_more` form element

Class `Drupal\entity_reference_autocomplete_add_more\Element\EntityReferenceAutocompleteAddMore`
(`src/Element/EntityReferenceAutocompleteAddMore.php`), annotated
`@FormElement("entity_reference_autocomplete_add_more")`, extends core `FormElementBase`.

## Install / enable

`composer require drupal/entity_reference_autocomplete_add_more` then
`drush en entity_reference_autocomplete_add_more`. Enabling makes the `#type` available; it does
nothing visible until you use it in a form. No config, no permissions.

## Use in a form

```php
$form['field_name'] = [
  '#type' => 'entity_reference_autocomplete_add_more',
  '#target_type' => 'node',
  '#title' => $this->t('Field label'),
  '#selection_settings' => ['target_bundles' => ['article'], 'match_limit' => 15],
  '#default_value' => [0 => ['target_id' => 123], 1 => ['target_id' => 234]],
  '#required' => FALSE,
];
```

## Properties (`getInfo()`)

- `#input => TRUE`, `#title => 'Entity Reference Autocomplete Add More'` (default label),
  `#target_type => ''` (set it — the entity type each row references),
  `#selection_settings => []` (passed straight to each row's core `entity_autocomplete`;
  e.g. `target_bundles`, `match_limit`, `sort`), `#default_value => []`.
- `#process => [::processElement]`, `#element_validate => [::validateElement]`,
  `#theme_wrappers => ['form_element']`.
- `#required` is read per-row (`getElementItem()` applies it to each `target_id`).

## Build: `processElement(&$element, $form_state)`

- Records `$element['#parents']` and `#default_value` into `$form_state` under keys
  `[<element_type>, <last_parent>]`, `[<#name>, 'default_values']`, `[<#name>, 'element_parent']`.
- Seeds `[<#name>, 'current_items']` with `[NULL]` when empty.
- Wraps element in `#prefix`/`#suffix` `<div id="<getSelector>">` for AJAX replacement.
- `getElementItemsWrapper()` → a `container` (id from `getContainerName()`) holding the
  **"Add another item"** submit button (`#submit => [::addItem]`, `#ajax` → `ajaxCallback`,
  `#limit_validation_errors => []`, very high `#weight`).
- For each entry in `getCurrentItems()` not equal to the string `'removed'`, `getElementItem()`
  builds a `container` with:
  - `target_id`: core `entity_autocomplete` (`#target_type`, `#selection_settings`,
    `#default_value`, `#required`, `#maxlength => 1024`).
  - `remove` (only for index > 0): submit button `#submit => [::removeItem]`, `#ajax` →
    `ajaxCallback`, carrying `data-index` and `data-element-name` attributes,
    `#limit_validation_errors => []`.

## Add / remove / AJAX

- `addItem()`: reads `data-element-name` from the triggering element, appends `NULL` to
  `current_items` in `$form_state`, calls `setRebuild()`.
- `removeItem()`: reads `data-index` + `data-element-name`, sets `current_items[$index] = 'removed'`,
  calls `setRebuild()`.
- `ajaxCallback()`: walks `#parents` of the trigger down to the stored `element_parent` and returns
  that subtree so only the element's wrapper re-renders. All submits are standard Form API `#ajax`
  (core adds the form token).
- `validateElement()` is a **no-op**; per-row validation (existence + selection-handler access) is
  handled by core's `entity_autocomplete` element itself.

## Helpers

- `getSelector($name)` / `getContainerName($name)`: `preg_replace("/[^A-Za-z0-9 ]/", "-", $name)`
  + `-wrapper` / `-container`, optionally prefixed `#` for a CSS selector.
- `getRemoveFieldName($index, $name)` → `remove_<name>_<index>`.
- `getItemCount()`, `getCurrentItems()`, `getElementType()` (returns the element id string).

## Reading submitted values

Values arrive under the element key: iterate
`$form_state->getValue('field_name')['items']` and read each `['target_id']` (an entity id).

```php
foreach ($form_state->getValue('field_name')['items'] as $item) {
  if (!empty($item['target_id'])) {
    $id = $item['target_id'];
  }
}
```
