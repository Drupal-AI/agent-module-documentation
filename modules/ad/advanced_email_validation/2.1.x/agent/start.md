# Advanced Email Validation — agent index

Validates account (and optionally Webform) email addresses against MX-record and
disposable/free/banned-domain rules, via the bundled `stymiee/email-validator` library. Rules,
messages, and domain lists are all in config and translatable.

- **Settings form, rules, domain lists, error messages, when validation runs** →
  [configure/settings.md](configure/settings.md)
- **The `advanced_email_validation.validator` service + result object (use in code)** →
  [api/validator.md](api/validator.md)
- **Constraints on the User mail field + the Webform handler plugin** →
  [plugins/constraints_webform.md](plugins/constraints_webform.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `advanced_email_validation.settings`; form at
  `/admin/config/people/advanced-email-validation` (route
  `advanced_email_validation.settings`, permission `administer advanced email validation`).
- Rules: `mx_lookup`, `disposable`, `free`, `banned` — each toggled, each with a `domain_lists`
  entry; `local_list_only.disposable` / `.free` use only your list.
- User `mail` field gets constraint `AEVNewEmail` (if `validate_account_on.created`) and/or
  `AEVChangedEmail` (if `validate_account_on.updated`), added in
  `hook_entity_base_field_info_alter()`.
- Requires the `stymiee/email-validator` composer library; `drupal/webform` is optional (adds
  the `advanced_email_webform_validator_handler` handler).
