# Adding autosave to custom forms

Standard content/config entity forms are handled automatically by the decorated form
builder — no code needed. For non-entity or bespoke forms, the module exposes reusable
building blocks in `src/Form/`:

- `AutosaveFormInterface` — contract for an autosave-capable form. Constants:
  `AUTOSAVE_ELEMENT_NAME` (`autosave_form_save`), `AUTOSAVE_RESTORE_ELEMENT_NAME`
  (`autosave_form_restore`), `AUTOSAVE_REJECT_ELEMENT_NAME` (`autosave_form_reject`).
  Key methods: `formAlter(&$form, $form_state)`, `isAutosaveSubmitValid($form_state)`,
  `storeState($form_state, $session_id, $timestamp, $uid)`,
  `getLastAutosavedTimestamp($form_state, $uid)`.
- `AutosaveFormAlterTrait` — implements the form alterations (adds the hidden
  save/restore/reject triggers and the JS library).
- `AutosaveButtonClickedTrait` — helpers to detect which autosave button was pressed.
- `AutosaveEntityFormHandler` (`AutosaveEntityFormHandlerInterface`) — the handler used
  for entity forms; a reference implementation to model a custom handler on.

Sketch:
```php
class MyForm extends FormBase implements AutosaveFormInterface {
  use AutosaveFormAlterTrait;
  use AutosaveButtonClickedTrait;
  public function buildForm(array $form, FormStateInterface $form_state): array {
    // ... build fields ...
    $this->formAlter($form, $form_state); // wires autosave triggers + library
    return $form;
  }
}
```
Persist/restore state through `autosave_form.entity_form_storage`
([../api/storage.md](../api/storage.md)).
