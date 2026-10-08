# Constraints & the Webform handler

The module does **not** define a new plugin type. It provides instances of two existing plugin
types: entity validation Constraints and a Webform handler.

## Validation constraints (User `mail` field)

`src/Plugin/Validation/Constraint/`:
- `AEVNewEmail` + `AEVNewEmailValidator` — only validates when the parent entity `isNew()`
  (new account). Skips empty values. Calls
  `advanced_email_validation.validator->validateEmail($email)` and adds the result message as a
  violation (falls back to `$constraint->defaultError`, "Not a valid email address").
- `AEVChangedEmail` + `AEVChangedEmailValidator` — validates when the email value changed on an
  existing account.

They are attached to `user.mail` dynamically in
`advanced_email_validation_entity_base_field_info_alter()` based on `validate_account_on`
(see configure/settings.md). To validate a *different* entity's email field, add the
`AEVNewEmail` / `AEVChangedEmail` constraint to that field yourself.

## Webform handler (optional, needs `drupal/webform`)

`src/Plugin/WebformHandler/AdvancedEmailWebformValidatorHandler.php`, plugin id
`advanced_email_webform_validator_handler`. Add it to a webform (Settings → Emails/Handlers →
Add handler) to apply the rule set to selected `email` / `email_confirm` elements. Its settings
schema (`webform.handler.advanced_email_webform_validator_handler`) mirrors the global settings
plus an `emails` sequence (the element keys to validate) and `override_site_defaults` — when set,
the handler's own `rules` / `error_messages` / `domain_lists` / `local_list_only` are used
instead of `advanced_email_validation.settings`. Summary rendering uses the theme hook
`webform_handler_advanced_email_webform_validator_handler_summary`.
