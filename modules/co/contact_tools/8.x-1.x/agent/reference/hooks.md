<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter hooks

Defined/documented in `contact_tools.api.php`. Two families.

## `hook_contact_tools_modal_link_options_alter(array &$link_options, array $context)`

Invoked (via `module_handler->alter`) on the `data-dialog-options` array before it is JSON-encoded
onto a modal link. Fires from three places, distinguished by `$context['type']`:

- `modal_link` — from `ContactTools::createModalLink()`
- `modal_link_ajax` — from `ContactTools::createModalLinkAjax()`
- `filter_link` — from the `contact_tools_modal_link` text filter

For the service calls `$context` also carries `contact_form` and `link_title`. Use it to set default
jQuery UI dialog options (width, dialogClass, …) for a set of forms.

## AJAX response hooks

Fired from `contact_tools_ajax_submit_handler()` after the response is built:

- `hook_contact_tools_ajax_response_alter(AjaxResponse &$ajax_response, array $form, FormStateInterface $form_state)`
  — runs for every AJAX contact submission.
- `hook_contact_tools_<CONTACT_NAME>_ajax_response_alter(...)` — same signature, but scoped to one
  form; `<CONTACT_NAME>` is the `contact_message` bundle (form machine name), e.g. `feedback`.

Both receive the full `AjaxResponse` and may add, remove, or replace commands — typically checking
`$form_state->isExecuted()` to add a thank-you `ReplaceCommand` or a `RedirectCommand` on successful
submit. (Note the api.php examples name the hooks with the `_alter` suffix; the module invokes the
alter with base names `contact_tools_ajax_response` and `contact_tools_<bundle>_ajax_response`.)
