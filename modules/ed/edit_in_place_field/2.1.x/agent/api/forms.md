# Edit forms and the AJAX save (API)

Alongside a field's normal display, each formatter renders a Drupal form built with
`FormBuilder::getForm(<FormClass>, $data)`. The forms extend `Form\EditInPlaceFormBase` and provide
the inline input plus **Save** / **Cancel** buttons. **Save** is an `#ajax` button
(`event: click`, `callback: inPlaceAction`), so submission goes through core's `/system/ajax` Form API
endpoint: the form is cached server-side and rebuilt from its `form_build_id` on submit. There is
**no custom route** — the forms exist only inside a rendered formatter.

## Forms and inputs

| Form id | Class | Inline input | Built for formatter |
|---|---|---|---|
| `edit_in_place_string_form` | `EditInPlaceStringForm` | `textfield` per delta | `edit_in_place_field_text` |
| `edit_in_place_long_string_form` | `EditInPlaceLongStringForm` | `textarea` per delta | `edit_in_place_field_long_text` |
| `edit_in_place_field_reference_form` | `EditInPlaceFieldReferenceForm` | `select` (or `select2`) | `edit_in_place_field_entity_reference` |
| `edit_in_place_reference_with_parent_form` | `EditInPlaceReferenceWithParentForm` (extends the reference form) | one `select` per parent id | `edit_in_place_field_reference_with_parent` |

`EditInPlaceFormBase::create()` injects `entity_type.manager` and `theme.manager`.

## The save target comes from build args, not the request

The formatter passes a `$data` array as the third `getForm()` argument; Drupal stores it in the form's
**build info**, and it is the authoritative source of the save target on submit.
`EditInPlaceFormBase::buildForm()` also mirrors some values into `#type => hidden` fields for the
client, but `processRequest()` reads the target from `$form_state->getBuildInfo()['args'][0]` — not
from the submitted hidden fields:

- `entity_type`, `entity_id`, `field_name` — identify the entity + field to write.
- `ajax_replace` — the CSS class `edit-in-place-replace-<field_name>-<entity_id>-<langcode>`; its
  trailing segment is parsed back into the langcode used to load the entity translation.
- `values` / `selected` / `choice_list(s)` / `cardinality` / `label_substitution` / `parent_labels` —
  seed the input widget at build time.

The **submitted value** is read from the raw POST body keyed by field name
(`\Drupal::requestStack()->getCurrentRequest()->request->all()[$field_name]`, or the
`in_place_field<parent_id>` keys for the parent-filtered form). The module's kernel test
`EditInPlaceStringFormTest::testProcessRequestUsesFormTarget()` asserts that POST parameters cannot
change `entity_type` / `entity_id` / `field_name` — those always come from the build args.

## Save flow — `EditInPlaceFormBase::inPlaceAction()`

1. `accessAllowed()` — requires the `edit in place field editing permission` permission; otherwise it
   returns an AJAX status message (`update_not_allowed`) and stops.
2. `processRequest()` — assembles `[field_name, entity_type, entity_id, ajax_replace, field_values,
   entity_langcode, label_substitution]`.
3. `processResponse()` (per subclass) → `loadEntity()`:
   - empty `field_name` / `entity_type` / `entity_id` → `invalid_data`;
   - loads the entity via `entityTypeManager->getStorage(...)->load(...)`, switching to the requested
     translation when it exists;
   - not a `FieldableEntityInterface`, or missing the field → `entity_cannot_be_loaded`;
   - **access check:** `$entity->access('update') && $entity->get($field_name)->access('edit')`,
     otherwise `update_not_allowed`.
4. Writes `$entity->{$field_name} = <values>` and calls `$entity->save()` (string forms first drop
   empty-trimmed values). An `EntityStorageException` → `data_cannot_be_saved`.
5. `reloadAndRebind()` returns an `AjaxResponse` combining a core `InsertCommand` (re-render the field
   HTML into `.<ajax_replace> .edit-in-place-editable`), a `RebindJSCommand`, and a
   `StatusMessageCommand`.

Error/result strings live as `EditInPlaceFormBase` constants (`ERROR_INVALID_DATA`,
`ERROR_DATA_CANNOT_BE_SAVED`, `ERROR_UPDATE_NOT_ALLOWED`, `ERROR_ENTITY_CANNOT_BE_LOADED`); warnings
are logged to the `edit_in_place_field` channel.

## AJAX response commands (custom)

- `Ajax\StatusMessageCommand` — extends core `InsertCommand`; renders `StatusMessages` into the active
  theme's messages region, falling back to `[data-drupal-messages]` when the block module is not
  enabled. JS command name: `insert`.
- `Ajax\RebindJSCommand` — JS command `rebindJS`; `js/edit-in-place-field.js` re-binds the
  click-to-edit and cancel handlers on the replaced markup and re-applies Chosen when present.

## Re-render theme hooks

Registered in `Hook\EditInPlaceFieldHooks::theme()`; every value is printed through Twig autoescaping:

- `edit_in_place_string_values` (`templates/edit-in-place-string-values.html.twig`) — vars `values`,
  `multiple`.
- `edit_in_place_reference_label` (`edit-in-place-reference-label.html.twig`) — var `labels` (plus
  entity context).
- `edit_in_place_reference_with_parent_label` (`edit-in-place-reference-with-parent-label.html.twig`)
  — var `entities` grouped by parent (plus context).

## Notes for integrators

- The langcode is derived from the `ajax_replace` string (`explode('-')`, last segment), matching the
  entity's rendered language.
- Cardinality: the string forms honor the field's stored cardinality (a fixed number of inputs, or an
  extra blank input when unlimited); the reference forms currently distinguish only cardinality `1` vs
  many (the source carries a `todo` for other cases).
- To exercise a save, render the field with one of these formatters for a user who has the permission
  — there is no standalone endpoint to POST to.
