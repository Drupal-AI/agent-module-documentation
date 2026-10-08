# Enable & how it wires up

The base module has **no settings form and no config object** (`configure: null`). Enabling it
alone does almost nothing visible — it only writes validation attributes onto form elements.
To get live in-browser validation you also enable the engine submodule.

## Turn it on

```
drush en clientside_validation clientside_validation_jquery -y
```

`clientside_validation_jquery` provides the actual jQuery Validate engine and its own settings
form at `/admin/config/user-interface/clientside-validation-jquery-settings`
(route `clientside_validation_jquery.settings_form`). See
[../../../modules/clientside_validation_jquery/4.1.x/agent/configure/clientside_validation_jquery.md](../../../modules/clientside_validation_jquery/4.1.x/agent/configure/clientside_validation_jquery.md).

## What the base module does per form (no config needed)

- `hook_form_alter()` registers `clientside_validation_form_after_build` on **every** form.
- After build it recurses the entire render array; for each element it calls
  `plugin.manager.clientside_validation.validators`→`getValidators($element, $form_state)`.
- A validator matches an element when the element's `#type` is in the validator's `supports.types`
  (e.g. `email`, `url`) **or** a supported attribute is present (`required`, `pattern`, `min`,
  `max`, `maxlength`, `step`, `states`, `equal_to`).
- Each matching plugin writes `data-rule-<name>` and `data-msg-<name>` attributes (messages are
  Drupal-translated) and `#attach`es the JS library it needs.
- Submit buttons with an empty `#limit_validation_errors` get the `cancel` class so jQuery Validate
  skips validation for them (Cancel/Preview buttons).

## Core validators shipped by the base module

`required` (attrs `required`, `states`), `email` (type), `url` (type), `url_internal_external`,
`min`, `max`, `maxlength`, `step`. The jQuery submodule adds `pattern` and `equal_to`.

## Per-element overrides

Set these render-array keys to customise messages: `#required_error`, `#pattern_error`,
and the element `#title` is used to build default messages. To stop an element being validated
at all, implement `hook_clientside_validation_should_validate()` (see the hooks doc).
