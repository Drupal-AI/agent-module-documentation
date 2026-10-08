Email Validator Customizer (evac) exposes each validation from the `egulias/email-validator` library as a Drupal service and can transparently replace core's `email.validator` service so that stricter rules (e.g. requiring a real domain with MX records) apply everywhere Drupal validates an email.

---

Drupal core validates emails with `egulias`'s `RFCValidation`, which accepts addresses with no domain. evac ships alternative validator services — `email.validator.dns_check` (DNSCheckValidation, the default replacement), `email.validator.message_id`, `email.validator.no_rfc_warnings`, `email.validator.spoof_check`, and `email.validator.multiple_with_and` — each wrapping the corresponding egulias validation behind Drupal's `EmailValidatorInterface`. Its `EvacServiceProvider` rewrites the core `email.validator` service class to `ReplacementSwitcher` (only if core still owns it), which at runtime reads `evac.settings` and delegates to the configured replacement, falling back to core's `EmailValidator` when replacement is disabled or misconfigured. The single settings form (`/admin/config/evac`, permission `administer evac configuration`, which is `restrict access: TRUE`) lets you toggle replacement, choose the replacement validation, and — when `multiple_with_and` is selected — pick which validations must all pass. Optional error/warning logging (to the `evac` logger channel) records why addresses were rejected. Because it swaps a core service, the stricter validation applies site-wide (user registration, contact forms, webforms, custom `email.validator` callers) without touching those forms. Note `isValid()` rejects the deprecated second `$emailValidation` argument by throwing, matching core's direction. `SpoofCheckValidation` needs the PHP `intl` extension.

---

- Reject email addresses that have no domain part (core's default RFC rule accepts them).
- Require that an email domain actually resolves and has MX records (DNSCheckValidation).
- Apply stricter email validation site-wide without editing individual forms.
- Enforce spoof-checking (homograph/confusable detection) on email addresses via `intl`.
- Combine several validations that must all pass using MultipleValidationWithAnd.
- Keep core RFC validation but additionally require DNS + spoof checks.
- Use `NoRFCWarningsValidation` to fail on addresses that merely produce RFC warnings.
- Validate Message-ID style addresses with MessageIDValidation.
- Call a specific validator service (e.g. `email.validator.dns_check`) directly from custom code.
- Leave core validation intact but still expose the extra validator services for your own use.
- Log why user-submitted emails were rejected for debugging registration issues.
- Tighten webform/contact-form email fields globally through the shared service.
- Prevent signups with throwaway or malformed domains that pass RFC-only checks.
- Choose per-site how strict email acceptance should be from one config page.
- Swap the replacement validation without a code deploy (config-only change).
- Audit warning-level issues in submitted emails without hard-failing them.
