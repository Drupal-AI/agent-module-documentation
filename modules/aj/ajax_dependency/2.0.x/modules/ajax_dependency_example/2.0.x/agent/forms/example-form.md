<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The example dependency form

Enable: `drush en ajax_dependency_example` (pulls in `ajax_dependency`). Visit `/ajax-dependency-example-form`.

## Route (`ajax_dependency_example.routing.yml`)

```yaml
ajax_dependency_example:
  path: '/ajax-dependency-example-form'
  defaults:
    _form: '\Drupal\ajax_dependency_example\AjaxDependencyExampleForm'
    _title: 'Ajax Dependency example form'
  requirements:
    _access: 'TRUE'
```

The route is intentionally open — it renders a self-contained demo form that only toggles which of its own
widgets display and does nothing on submit but rebuild. It carries no data mutation, no stored state, and no
sensitive output.

## Form (`src/AjaxDependencyExampleForm.php`, `AjaxDependencyExampleForm extends FormBase`)

- `getFormId()` → `ajax_dependency_example_form`.
- `buildForm()` builds:
  - `selector` — `checkboxes`, options `one`/`two`, required.
  - `variant_one` — `textfield`, required.
  - `variant_two` — `checkbox`, required.
  - `submit` — submit button "Save".
- Dependency wiring (the point of the demo):
  ```php
  $selectorInput = $form_state->getUserInput()['selector'] ?? NULL;
  AjaxDependency::contentIf($selectorInput['one'] ?? NULL, $form['selector'], $form['variant_one'], $form_state);
  AjaxDependency::contentIf($selectorInput['two'] ?? NULL, $form['selector'], $form['variant_two'], $form_state);
  ```
  `variant_one` shows only while "One" is checked, `variant_two` only while "Two" is checked; when a box is
  unchecked, `contentIf` blanks that variant's `#value` and hides it. The element re-renders server-side over AJAX.
- `submitForm()` calls `$form_state->setRebuild()` — the demo just re-renders; it never persists anything.

## Why raw input, not `getValue()`

During an AJAX rebuild the form is typically not validated, so `FormStateInterface::getValue()` is empty. The
form reads `$form_state->getUserInput()['selector']` to know the current checkbox state. The module's inline
comment documents that this raw input is client-controllable and unvalidated, which is acceptable here because
it only decides which widgets to display — the submitted values themselves still go through normal Form API
validation/handling. Two commented-out `getValue()` lines in the source show the approach that does not work
during rebuild.

## Also in the submodule

`ajax_dependency.example.php` (project-root and submodule copies) contains non-executed sample functions
(`ajax_dependency_example_form`, and a `hook_form_BASE_FORM_ID_alter` node-form example) that illustrate the
same API in a `form_alter` context; they are documentation snippets, not wired into any route.
