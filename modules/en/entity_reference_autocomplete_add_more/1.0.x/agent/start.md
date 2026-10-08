<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity reference autocomplete FormElement with add more (entity_reference_autocomplete_add_more) — agent index

Registers ONE Form API render element, `entity_reference_autocomplete_add_more`, for use in any
custom form. Each row is a core `entity_autocomplete` input; the element adds AJAX "Add another
item" and per-row "Remove" buttons so the list of references grows/shrinks without a page reload.
Package `Entity Reference Autocomplete Add More`. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.0. Developer-only: **no admin UI, no config, no routes, no permissions, no dependencies
beyond core**.

- **The element, its `#properties`, add/remove AJAX, form-state handling, submit format** →
  [elements/form-element.md](elements/form-element.md)

## What it actually is

- One plugin: `EntityReferenceAutocompleteAddMore` (`@FormElement("entity_reference_autocomplete_add_more")`),
  in `src/Element/EntityReferenceAutocompleteAddMore.php`, extending core `FormElementBase`.
- No `.routing.yml`, `.permissions.yml`, `.services.yml`, `.install`, `.module`, no `config/`, no
  submodules, no libraries, no `composer.json`. Just the element class + a unit test.
- Consumed only from code: `'#type' => 'entity_reference_autocomplete_add_more'` with `#target_type`
  (required), `#title`, `#selection_settings`, `#default_value`, `#required`.

## Mechanism (from source)

- `getInfo()` sets `#input => TRUE`, `#process => [::processElement]`,
  `#element_validate => [::validateElement]` (a **no-op**), `#theme_wrappers => ['form_element']`.
- `processElement()` wraps the element in a `#prefix`/`#suffix` div (id from `getSelector()`), builds
  an `items` container via `getElementItemsWrapper()` (holds the "Add another item" submit button),
  and one `getElementItem()` per current item. Each item is a core `entity_autocomplete`
  (`target_id`, `#maxlength => 1024`) plus, for index > 0, a "Remove" submit button.
- `addItem()` / `removeItem()` mutate `current_items` in `$form_state` (append `NULL` / mark
  `'removed'`) and call `setRebuild()`; `ajaxCallback()` returns just the element subtree to replace.
  Add/Remove buttons use `#limit_validation_errors => []` and core Form API `#ajax`.
- Submitted value: `$form_state->getValue('<key>')['items'][$i]['target_id']`.

See [elements/form-element.md](elements/form-element.md) for `#properties`, state keys and submit handling.
