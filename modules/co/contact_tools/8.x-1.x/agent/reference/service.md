<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service, route and AJAX flow

## Service `contact_tools` (`src/Service/ContactTools.php`)

Injected args: `entity_type.manager`, `entity.form_builder`, `module_handler`. All methods return
render arrays.

- `getForm(string $contact_form_id = 'default_form', array $form_state_additions = []): array`
  Creates a `contact_message` of that bundle, builds its `default` form via the entity form builder,
  sets `#title` to the message label, and adds the `user.permissions` cache context. No AJAX.
- `getFormAjax(string $contact_form_id = 'default_form', array $form_state_additions = []): array`
  Same, but merges `['contact_tools' => ['is_ajax' => TRUE]]` into the form-state additions so the
  form_alter attaches the AJAX submit behaviour.
- `createModalLink(string $link_title, string $contact_form, array $link_options = []): array`
  Renderable `#type => link` pointing at the **non-AJAX** canonical form route
  `entity.contact_form.canonical`, decorated with `use-ajax` + `data-dialog-type=modal` +
  JSON `data-dialog-options`, attaching `core/drupal.dialog.ajax`.
- `createModalLinkAjax(string $link_title, string $contact_form, array $link_options = []): array`
  Same, but the link points at the module's AJAX route `contact_tools.contact_form_ajax.page`.

Default link options (`getLinkOptionsDefault()`): classes `['use-ajax']`, `data-dialog-type=modal`,
`data-dialog-options => {width: 'auto', dialogClass: 'contact-tools-modal'}`, `rel=nofollow`.
User options are merged with a recursive "distinct" merge (existing values replaced, not appended),
and `use-ajax` is re-ensured on the class list.

`modalLinkOptionsAlter()` invokes `hook_contact_tools_modal_link_options_alter()` on the
`data-dialog-options` before they are JSON-encoded onto the link.

## Route + controller

Route `contact_tools.contact_form_ajax.page` (`contact_tools.routing.yml`):

```yaml
path: '/contact-tools/{contact_form}'
defaults:
  _controller: '\Drupal\contact_tools\Controller\ContactToolsPageController::contactPageAjax'
requirements:
  _entity_access: 'contact_form.view'
```

`{contact_form}` is upcast to a `\Drupal\contact\ContactFormInterface`, and `_entity_access:
contact_form.view` enforces the same view access core uses for that form before the controller runs.

`contactPageAjax()`:
- Falls back to the site default form (`contact.settings:default_form`) if none is bound; if no form
  exists it either shows an admin error (users with `administer contact forms`) or throws
  `NotFoundHttpException`.
- Creates a `contact_message` of the form's bundle and builds its `default` form with form state
  `['contact_tools' => ['is_ajax' => TRUE]]`.
- Title is the form label, optionally overridden by the `?modal-title=` query string (only when it
  is a string). The title is set as the render array `#title` and rendered through core's title
  handling.
- Adds `user.permissions` cache context and the `contact.settings` config as a cache dependency.

## AJAX submit flow (`contact_tools.module`)

- `hook_form_contact_message_form_alter()` — when form state flag `contact_tools.is_ajax` is set,
  adds a processed class `Html::getClass("<form_id>-contact-tools-processed")` and an `#ajax`
  callback (`contact_tools_ajax_submit_handler`, click event, throbber) to the submit button.
- `contact_tools_ajax_submit_handler()` — `setRebuild()`, injects a `status_messages` element,
  and returns an `AjaxResponse` with `InvokeCommand(..., 'focus')` then
  `ReplaceCommand` targeting the processed wrapper. It then runs the alter hooks
  `contact_tools_ajax_response` and `contact_tools_<bundle>_ajax_response` so modules can rewrite the
  response (e.g. swap in a thank-you message or a redirect). See
  [hooks.md](hooks.md).
