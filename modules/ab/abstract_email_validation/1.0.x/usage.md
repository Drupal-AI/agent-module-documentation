Validates email-field input against the third-party Abstract email-verification API (with an optional local email/domain blacklist), rejecting addresses that fail the configured deliverability checks.

---

Abstract API Email Validator connects Drupal email fields and forms to Abstract's email verification/validation service. After an administrator enters an Abstract base URL and API key at `/admin/config/system/abstract-email-validation`, validation can be switched on per email field via a third-party-settings checkbox on the field-config form (which attaches an `AbstractEmailValidation` constraint), on the user registration/edit form via a global setting, on webform email elements via a per-element checkbox, and on any custom-form email element by setting `#abstract_email_validation` to TRUE. When a flagged field is submitted, the module first checks the value against a configurable local blacklist of addresses and domains, then (if not blacklisted) calls Abstract with the address and accepts or rejects it. Acceptance is decided either by the default rule (SMTP-valid AND deliverable AND quality_score >= 0.8) or, in "detailed" mode, by whichever combination of SMTP, MX-found, deliverability and a custom quality-score threshold the administrator selects. A customizable error message with a `%email` placeholder is shown when validation fails. All configuration is stored in the `abstract_email_validation.settings` config object.

---

- Verify that email addresses entered on a node form's email field actually exist and are deliverable before the node is saved.
- Enforce real, deliverable email addresses at user registration by enabling validation on the `user_register_form` mail field.
- Also validate the mail field on the user edit form (`user_form`) so profile email changes are checked.
- Add deliverability validation to a Webform email element by ticking "Enable Abstract API Email Validation" in the element's settings.
- Add validation to a custom form's email element by setting `'#abstract_email_validation' => TRUE` on the `#type => email` element.
- Require that an address's mailbox passes an SMTP check (`is_smtp_valid`) before accepting it.
- Require that the address's domain has MX records (`is_mx_found`) before accepting it.
- Require a minimum Abstract quality score (0.1–1.0, default/recommended 0.8) for an address to be accepted.
- Require a DELIVERABLE deliverability status from Abstract before accepting an address.
- Combine several Abstract checks (SMTP + MX + deliverability + quality score) by enabling detailed settings and selecting which conditions must all hold.
- Fall back to the default validation rule (SMTP-valid AND deliverable AND quality_score >= 0.8) without configuring detailed settings.
- Block a fixed list of specific email addresses (comma-separated) from being used anywhere validation is enabled.
- Block whole domains (comma-separated) so any address at those domains is rejected before the API is even called.
- Reduce fake sign-ups and spam by rejecting disposable or low-quality mailboxes flagged by Abstract.
- Improve email deliverability / reduce bounce rates by keeping invalid addresses out of node, user and webform submissions.
- Show site visitors a branded, customizable rejection message (`Your email address %email is invalid.` by default) when an address is refused.
- Present blacklisted addresses/domains with a distinct "banned for the site — contact site admin" message.
- Apply email validation to paragraph, taxonomy, menu and media email fields, not just nodes and users.
- Keep the Abstract API key out of exported configuration by overriding it in `settings.php` (`$config['abstract_email_validation.settings']['api_key'] = '...';`).
- Turn validation on or off for an individual field at any time by toggling its field-config checkbox (adds/removes the constraint).
- Centralize third-party email verification so multiple content types and forms share one Abstract account and one set of rules.
- Render the module's README as on-site help (Administration help page) when the optional Markdown module is installed.
