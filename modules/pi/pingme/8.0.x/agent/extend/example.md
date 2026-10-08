<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# pingme as reference code

This module is a tutorial. Useful patterns to lift (with fixes):

- **Schema:** `pingme.install` defines the `pingme` table.
- **AJAX modal:** `ModalFormExampleController::openModalForm()` returns an `AjaxResponse` with `OpenModalDialogCommand`; buttons use `use-ajax` + `data-dialog-type: modal`.
- **Autocomplete controller:** `LoadUsersController::LoadUsers()` returns `JsonResponse` of `{value, label}` from `users_field_data`, filtering input with `Xss::filter` and `escapeLike`.
- **CRUD:** `ChatForm::submitForm()` inserts/updates via `\Drupal::database()`; `DeleteMessagesForm` is a `ConfirmFormBase` delete.

## Do not copy the access model
The create/edit/delete routes use `_access: 'TRUE'` and the list/view routes use `_permission: 'access content'`. In real code, gate mutations behind a specific permission and load/validate `{id}` ownership. As shipped, anonymous users can write to and delete from the table and read recipient email addresses.
