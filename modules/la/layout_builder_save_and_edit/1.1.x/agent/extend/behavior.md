# Behavior — how the "Save and edit layout" button works

The whole module is `layout_builder_save_and_edit_form_alter()` plus two helper callbacks in
`layout_builder_save_and_edit.module`. No services, no config, no overridable API.

## Where the button is added

`hook_form_alter` inspects `$form_state->getFormObject()`:

1. **Layout Builder defaults form** — `Drupal\layout_builder\Form\DefaultsEntityForm`
   (a display's default layout, e.g. content-type layout defaults).
2. **Layout Builder overrides form** — `Drupal\layout_builder\Form\OverridesEntityForm`
   (a single entity's per-item layout override, edited on the Layout Builder canvas).
   For 1 and 2 the redirect target is the **current path** (`Url::fromUserInput()` of
   `path.current`), i.e. it reloads the same Layout Builder page.
3. **Content entity add/edit form** — any `ContentEntityFormInterface`, but only when:
   - the operation is **not** `delete` (delete forms are ignored), and
   - the entity has a truthy `layout_builder__layout` field (an editable layout override), and
   - the current user has permission
     `configure editable {bundle} {entity_type_id} layout overrides`.
   Here no `#redirect_url` is set up front; it is resolved at submit time (see below).

Any other form is left unchanged.

## What the button is

The new action is a **clone of the existing `submit` action**:

```php
$form['actions']['layout_builder_save_and_edit_layout'] = $form['actions']['submit'];
$form['actions']['layout_builder_save_and_edit_layout']['#value'] = t('Save and edit layout');
unset($form['actions']['layout_builder_save_and_edit_layout']['#button_type']);
```

So it reuses the real save handlers; only the label, button styling, and redirect differ. The
original "Save layout" button is untouched, so save-and-exit remains available.

## Validate → submit flow

`hook_form_alter` prepends `layout_builder_save_and_edit_layout_validate_handler` to `$form['#validate']`
(via `array_unshift`). That validate handler checks the triggering element's
`data-drupal-selector == 'edit-layout-builder-save-and-edit-layout'`; only when the custom button
fired does it **append** `layout_builder_save_and_edit_layout_submit_handler` to the submit handler
stack. This makes the redirect logic run last, and only for this button.

`layout_builder_save_and_edit_layout_submit_handler`:
- If no `#redirect_url` was preset (the content-form case), it builds one from the saved entity:
  route `layout_builder.overrides.{entity_type_id}.view` with the entity id as parameter.
- Removes any `destination` query parameter (`\Drupal::request()->query->remove('destination')`)
  so it cannot override the redirect.
- Calls `$form_state->setRedirectUrl(...)` to send the user back to the layout page.

## Access control

The module defines **no permissions of its own**. On content entity forms the button is gated by
the core Layout Builder dynamic permission
`configure editable {bundle} {entity_type_id} layout overrides`
(e.g. `configure editable article node layout overrides`). On the Layout Builder defaults/overrides
forms themselves, access is already governed by core Layout Builder route access, so the button
simply appears whenever the user can reach the form.
