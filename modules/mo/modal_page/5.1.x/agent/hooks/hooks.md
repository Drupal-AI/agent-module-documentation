# modal_page hooks

Invited hooks (from `modal_page.api.php`). Implement them in a custom module's `.module`.

## `hook_modal_alter(&$modal, $modal_id)`

Alter any modal before it is displayed. `$modal` is the `Modal` entity (use its setters).

```php
function mymodule_modal_alter(&$modal, $modal_id) {
  $modal->setLabel('New Title');
  $modal->setBody('New Body');
}
```

## `hook_modal_ID_alter(&$modal, $modal_id)`

Same, but targeted at a specific modal by id — replace `ID` with the modal's machine id
(e.g. `hook_modal_welcome_alter`). Only fires for that modal.

## `hook_modal_submit($modal, $modal_state, $modal_id)`

Server-side handler run when a modal's form is submitted (via the
`/modal/ajax/hook-modal-submit` AJAX endpoint). Put custom logic here.

```php
function mymodule_modal_submit($modal, $modal_state, $modal_id) {
  \Drupal::logger('mymodule')->notice('Modal @id submitted', ['@id' => $modal_id]);
  // ... your AJAX-triggered logic ...
}
```

These are invoked through the standard module handler, so the function name is
`<your_module>_modal_alter` / `_modal_<id>_alter` / `_modal_submit`. The `Modal` entity's
setter/getter API (`setLabel`, `setBody`, `setPages`, `setRoles`, `setType`, `setAutoOpen`,
…) is defined in `src/Entity/ModalInterface.php`.
