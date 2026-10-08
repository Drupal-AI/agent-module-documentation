<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EVA - Email Validator checks the deliverability of email addresses against the external e-va.io service and rejects addresses whose state is not in your allow-list on the forms you target.

---

EVA - Email Validator (module `email_validator`) validates email addresses by calling the external **e-va.io** API over HTTPS and interpreting the returned state (Safe / Unknown / Invalid / Risky). It **replaces Drupal core's `email.validator` service** with its own `EVA` class (a subclass of core's `EmailValidator`), so validation can run wherever core validates an address, and it also hooks `hook_form_alter` to add a validator to the specific forms you list. You configure it at `/admin/config/system/email-validator`: paste the **Access Key** from e-va.io, list the forms/fields to validate (one `form_id:field` per line, e.g. `user_register_form:mail`), pick which email **states are allowed**, and choose logging plus a fail-open/fail-closed policy for when the API is down or out of credits. Results are cached for one hour per address to cut API calls. Security/data handling: it **sends submitted email addresses to a third-party service** (a data-egress/privacy consideration — confirm this is acceptable and disclosed), authenticates with an **API key** sent in an `api-key` header, and the outbound call uses HTTPS with default TLS certificate verification. The API key is stored in module config as plain text (a `textfield`), so treat exported config as sensitive. Its own permission `administer eva api settings` gates the config form; it has no other access-control role. Requires `guzzlehttp/guzzle`.

---

- Validate email addresses for deliverability via e-va.io.
- Reject Invalid or Risky addresses at form submission.
- Reduce fake or undeliverable signups (anti-abuse).
- Validate the user registration form's `mail` field.
- Validate email fields on Webform submissions.
- Validate the email on a Commerce checkout flow.
- Target arbitrary forms with `form_id:field` lines.
- Choose which email states (Safe/Unknown/Invalid/Risky) are allowed.
- Temporarily disable validation site-wide via the "Disable EVA" checkbox.
- Fail open (bypass) or fail closed (reject) when the API is unreachable.
- Log rejected email addresses to the Drupal log.
- Cache validation results per address for one hour to limit API calls.
- Override core's `email.validator` service with EVA.
- Authenticate to the validation service with an Access Key.
- Store the API key as a secret and confirm the third-party egress is disclosed.
- Call the module's `email_validator.eva` service programmatically to check an address.
- Restrict who can configure the integration via the `administer eva api settings` permission.
- Gate registration behind deliverability checks.
- Enforce email quality on customer-facing forms.
