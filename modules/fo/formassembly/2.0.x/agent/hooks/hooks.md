# Hooks

## Hook the module invokes (for integrators)

### `hook_formassembly_form_params_alter(array &$params)`
Invoked by `ApiMarkup::getFormMarkup()` (via `moduleHandler->alter('formassembly_form_params', $params)`)
just before the form-markup request. `$params` is the associative array of FormAssembly pre-fill query
parameters (keys are `tfa` field identifiers). Values are token-replaced *after* this alter, so you can
add raw token strings or literal values.

```php
function mymodule_formassembly_form_params_alter(array &$params) {
  $params['tfa_1'] = \Drupal::currentUser()->getEmail();
}
```

## Hooks the module implements

| Hook | Purpose |
|---|---|
| `hook_help()` | Help text on `help.page.formassembly`. |
| `hook_theme()` | Registers `fa_form__fa_form` (form markup template) and helper elements `fa_form__external_js`, `fa_form__inline_js`, `fa_form__external_css` used to attach the form's head assets. |
| `hook_entity_field_access()` | For `edit` on an `entityreference` field whose target type is `fa_form`, grants access to users with `reference formassembly`. |

Batch callbacks (procedural, in `formassembly.module`): `formassembly_batch_get_forms()`,
`formassembly_batch_finished()` — used by the settings-form sync batch.
