<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Modal create flow (the "Add new" button)

## Route & controller

`entity_reference_modal.entity_form` → `/entity-reference-modal/form/{entity_type}/{bundle}`
→ `EntityReferenceModalController::build()`.

`build()`:
- Triggers the page-cache kill switch.
- Creates an empty target entity of `{entity_type}` with `{bundle}` set on the bundle key.
- Reads the desired form mode from the `?mode=` query. If the entity type has no form handler for that mode,
  it registers the **default** form handler for that mode on the fly
  (`$handler_type->setFormClass($mode, $form_handlers['default'])`) — a workaround for core issue 2511720.
- Builds and returns the entity form with `#cache max-age = 0`.

## Access check — `EntityReferenceModalController::access()`

- Returns `AccessResult::forbidden()` unless the request is a modal/AJAX request
  (`?_wrapper_format=drupal_modal` **or** POST `_drupal_ajax=1`). This is a UX guard, not the real gate.
- The real gate: `AccessResult::allowedIf( accessControlHandler->createAccess($bundle) )` — i.e. the current
  user must have **create** access for the target type/bundle. Verify this matches your expectations for
  low-privileged editors.

## AJAX submit (in `entity_reference_modal.module`)

`hook_form_alter()` fires only on the `entity_reference_modal.entity_form` route and:
- Adds a top-weighted `status_messages` element.
- Turns the submit button into `#type => button` with `#ajax callback => entity_reference_modal_submit`.
- Attaches the `entity_reference_modal` library.

`entity_reference_modal_submit()` (returns an `AjaxResponse`):
- On validation errors → `ReplaceCommand('.form_wrapper', $form)` (re-render with messages).
- Otherwise (form object is an `EntityFormInterface`):
  - Re-extracts field values via `EntityFormDisplay::collectRenderDisplay(...)->extractFormValues()` and, for
    configurable fields, re-runs value callbacks + element validators through
    `entity_reference_modal_children_element()` (a recursive helper).
  - Calls the form object's `submitForm()` to populate the entity.
  - **Dedup:** if `?duplicate` is set → `$entity->save()`. Otherwise runs an **access-checked** `entityQuery`
    (`accessCheck(TRUE)`) filtered by bundle key + label; if a match exists it loads that existing entity
    instead of saving a new one, else it saves.
  - Returns `InvokeCommand(NULL, 'injectEntity', [json])` where json is the request query plus
    `entity => "label (id)"`. The `injectEntity` jQuery plugin (`js/entity-reference-modal.js`) closes the
    dialog and writes that string into the field input identified by `data.selector`.

## Behaviour to verify

- **Orphaned targets:** the target entity is saved as soon as the modal is submitted, independently of whether
  the parent form is later saved or abandoned. With `duplicate=FALSE` the label-dedup mitigates repeats, but an
  abandoned parent still leaves a saved target.
- **Dedup by label only:** matching is on the label field (+ bundle) via `entityQuery`, so two genuinely
  different entities sharing a label collapse to the first match unless `duplicate` is enabled.
