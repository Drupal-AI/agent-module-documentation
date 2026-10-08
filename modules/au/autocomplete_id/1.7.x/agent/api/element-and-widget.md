<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form element & widget for custom code

## The `entity_id_autocomplete` render element

`Element\EntityIdAutocomplete` extends core `\Drupal\Core\Entity\Element\EntityAutocomplete`
(`@FormElement("entity_id_autocomplete")`). Use it in any form exactly like core's
`entity_autocomplete`, but users can also type a bare entity ID.

```php
$form['ref'] = [
  '#type' => 'entity_id_autocomplete',
  '#target_type' => 'node',
  '#selection_handler' => 'default',
  '#selection_settings' => ['target_bundles' => ['article']],
  '#tags' => FALSE,            // TRUE for multi-value "tags" input
  '#default_value' => $node,   // entity object or array of entities
];
```

What it changes vs core:
- `processEntityAutocomplete()` sets `#autocomplete_route_name` to
  `autocomplete_id.entity_id_autocomplete` (the module's controller) instead of the core route.
- Adds `#element_validate` → `validateEntityIdAutocomplete()`. This first tries core's
  `extractEntityIdFromAutocompleteInput()` (the `Label (123)` form); if that yields nothing it falls
  back to `matchEntityById()`, which does `loadByProperties([<id key> => $input])` and:
  - 0 matches + required → form error "There are no … matching …";
  - >5 matches → error asking the user to append `(id)`;
  - 2–5 matches → error listing the candidates with their IDs;
  - exactly 1 → returns that entity ID.
- Auto-create, `#validate_reference`, and multi/single (`#tags`) handling mirror core.

## The field widget `entity_reference_autocomplete_id`

`Plugin\Field\FieldWidget\EntityReferenceAutocompleteIdWidget` extends core
`EntityReferenceAutocompleteWidget`. Its only override: `formElement()` calls the parent then sets
`$element['target_id']['#type'] = 'entity_id_autocomplete'`. All widget settings, validation and
storage are inherited from core. Applies to `entity_reference` field type. Selectable on Manage form
display as **Autocomplete match ID**.

## The autocomplete controller (security note)

`Controller\EntityIdAutocompleteController::handleAutocomplete()` mirrors core's entity autocomplete
controller: it re-derives the HMAC of the stored `selection_settings` (`Crypt::hmacBase64(... ,
Settings::getHashSalt())`) and `hash_equals()`-compares it to the `selection_settings_key` in the URL,
throwing `AccessDeniedHttpException` on mismatch or a missing key/value entry. The route's
`_access: TRUE` is therefore gated by the same signed-key mechanism core uses — the per-result view
access + permission gate then lives in the matcher. Not an open data-exposure route.
