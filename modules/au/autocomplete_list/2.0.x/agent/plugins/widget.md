<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Autocomplete (List style) widget

**Plugin:** `Drupal\autocomplete_list\Plugin\Field\FieldWidget\EntityReferenceAutocompleteList`
**Widget id:** `entity_reference_autocomplete_list`  · **field type:** `entity_reference`
**Label:** *Autocomplete (List style)*

## What it does
A multi-value entity-reference widget that combines a single autocomplete text field with a running list of already-selected references. Instead of N separate autocomplete rows (core's default) the user types into one box; each match is added to a list and can be removed, using Drupal AJAX (`AjaxResponse`, `InvokeCommand`).

## Settings (`defaultSettings()`)
- `match_operator` — `CONTAINS` or `STARTS_WITH` (autocomplete match method).
- `size` — width of the textfield (default 60).
- `placeholder` — placeholder text.

## Usage
1. Manage form display for a bundle with an entity-reference field that allows multiple values.
2. Set its widget to **Autocomplete (List style)**.
3. Configure the match operator, size and placeholder.

Values are validated against the field's constraints (`ConstraintViolationListInterface`); markup is filtered via `FieldFilteredMarkup` / `Html`.
