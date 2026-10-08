<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extend Confirm Leave to other forms

Out of the box the module only attaches its library to node add/edit forms. Because the JavaScript is
generic, you get the same unsaved-changes protection on any other form simply by attaching the same
library to it.

## The mechanism (all of it)

`confirm_leave.module`:

```php
function confirm_leave_form_node_form_alter(&$form, FormStateInterface $form_state) {
  $form['#attached']['library'][] = 'confirm_leave/confirm-leave';
}
function confirm_leave_form_node_edit_form_alter(&$form, FormStateInterface $form_state) {
  $form['#attached']['library'][] = 'confirm_leave/confirm-leave';
}
```

`js/confirm-leave.js` (`Drupal.behaviors.confirmLeave`):

- Binds to the `formUpdated` event on `.form-item` elements (a core event fired when a field value
  changes).
- On the first change it adds the class `form-updated` to `<form>` and sets
  `window.onbeforeunload = () => Drupal.t('Are you sure?')`.
- On `submit` it resets `window.onbeforeunload = null`, so saving never prompts.

The behaviour targets every `form` on the page once any `.form-item` is updated — the reason it is
scoped to node forms at all is purely that the library is only *attached* on node form pages.

## Apply it to any form

Attach `confirm_leave/confirm-leave` in your own `hook_form_alter()` (or a more specific
`hook_form_FORM_ID_alter()`):

```php
// your_module.module
function your_module_form_alter(&$form, \Drupal\Core\Form\FormStateInterface $form_state, $form_id) {
  // Example: protect a specific webform, config form, or custom entity form.
  if (in_array($form_id, ['webform_submission_contact_add_form', 'system_site_information_settings'], TRUE)) {
    $form['#attached']['library'][] = 'confirm_leave/confirm-leave';
  }
}
```

Any form that renders standard `.form-item` wrappers and fires core's `formUpdated` event will then
prompt on unsaved changes.

## Hook into the dirty state yourself

- **CSS/JS marker:** once a field changes, the `<form>` gains the class `form-updated`. Target it in
  a theme (e.g. show a "unsaved changes" badge) without touching PHP.
- **Event:** you can add your own listener for the same `formUpdated` event to run custom logic when
  the user first edits a field.

## Limits you cannot work around here

- **The prompt text is fixed by the browser.** Changing `Drupal.t('Are you sure?')` has no effect —
  modern browsers show their own generic string and ignore the returned value.
- **It only fires after real interaction.** Browsers suppress `beforeunload` prompts until the user
  has engaged with the page, so a form that is opened and left untouched will not warn.
- If a page already provides an unsaved-changes warning (some editorial UIs, or a second copy of this
  library), you can get two prompts — attach the library in one place only.
