<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Entity Reference Actions works (handler internals)

All logic lives in `EntityReferenceActionsHandler` (a `ContainerInjectionInterface` /
`TrustedCallbackInterface` service resolved via `\Drupal::classResolver`) plus a few hooks in
`entity_reference_actions.module`. No routes are defined; everything runs inside the host entity's
edit form and its AJAX callbacks.

## Attachment (hooks)

- `hook_field_widget_complete_form_alter` — for any field whose class is an
  `EntityReferenceFieldItemListInterface`, resolves the handler, `init($target_type, $thirdPartySettings)`,
  then `formAlter()` attaches the actions element (only if `enabled`).
- `hook_field_widget_third_party_settings_form` — builds the enable/options form (see configure doc).
- `hook_field_widget_settings_summary_alter` — adds the On/Off summary line.
- `hook_form_alter` — when an AJAX request renders a `ConfirmFormBase`, wires the submit button's AJAX
  callback to `EntityReferenceActionsHandler::dialogAjaxSubmit` and adds `dialog-cancel` to cancel — this
  is what lets a confirm-form action run inside the modal.

## Execution (`submitForm`, AJAX callback)

1. Reads the triggering button to pick the chosen `action` config entity.
2. Collects `#target_ids` from the widget value and loads those entities of `#target_type`.
3. **Access filter:** keeps only entities where `$action->getPlugin()->access($entity, $currentUser)`
   returns TRUE; skipped ones produce a warning `MessageCommand`. This is the authorization boundary —
   the module never runs an action on an entity the current user can't act on.
4. Dispatch:
   - **Confirm-form actions** (plugin definition has `confirm_form_route_name`): calls
     `executeMultiple($entities)`, then builds a sub-request (`HttpKernelInterface::SUB_REQUEST`, query
     flag `era_subrequest=TRUE`) to render the action's confirm form into an `OpenModalDialogCommand`.
   - **Plain actions:** builds a `BatchBuilder` with one `batchCallback` op per entity
     (`executeMultiple([$entity])`) and opens a progress modal; `batchFinish` throws an
     `EnforcedResponseException` carrying the final `AjaxResponse` (the only way to return AJAX from the
     batch-finished flow).

## Supporting services

- `SubRequestAjaxResponseSubscriber` decorates `ajax_response.subscriber` so AJAX commands from the
  sub-request survive.
- `EmptyAttachmentsProcessor` (render) avoids double-processing attachments during the sub-request.
- Form element plugins: `simple_actions` (container for the buttons) and `ajax_dropbutton`.

## Extending

There is nothing to subclass or a plugin type to implement — you extend behavior by defining ordinary
**Action plugins** (`@Action` / `Drupal\Core\Annotation\Action`, or config `action` entities) whose
`type` matches the reference target entity type; they then appear in the widget's action list
automatically. Access should be enforced in the action plugin's `access()` since ERA calls it.
