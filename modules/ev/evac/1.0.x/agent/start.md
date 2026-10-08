# Email Validator Customizer (evac) — agent index

Exposes each `egulias/email-validator` validation as a Drupal service and can replace core's
`email.validator` service so stricter email rules apply site-wide. Config route `evac.settings`
(`/admin/config/evac`), permission `administer evac configuration` (`restrict access: TRUE`).
No plugins, no Drush, no entities — just services + one config form.

- **Settings keys, the service list, how the core swap works, and calling a validator from code** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Core `email.validator` is rewritten to `Drupal\evac\Utility\ReplacementSwitcher` by
  `EvacServiceProvider::alter()` — but only if core still owns the service (class ===
  `Drupal\Component\Utility\EmailValidator`), so a prior override wins.
- Runtime choice comes from config `evac.settings`: `replace` (bool), `replacement` (one of
  `dns_check|spoof_check|message_id|no_rfc_warnings|multiple_with_and`), `multiple_with_and`
  (map of enabled sub-validations), `log_errors`, `log_warnings`.
- Validator services: `email.validator.dns_check`, `.message_id`, `.multiple_with_and`,
  `.no_rfc_warnings`, `.spoof_check`. All implement `EmailValidatorInterface`.
- Fallback is safe: if replacement is disabled or the class is missing, `ReplacementSwitcher`
  uses core's `EmailValidator` (fails to core behavior, not fail-open-accept-all).
- `isValid($email, $emailValidation)` throws `BadMethodCallException` if the 2nd arg is passed.
- `spoof_check` requires PHP `ext-intl`.
