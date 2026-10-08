Webform Deter adds client-side (JavaScript) checks to Webform submissions: admin-configured regular expressions are tested against text/textarea fields on submit, and if any match the user gets a confirm dialog warning them not to submit sensitive information (SSNs, credit cards, dates of birth, etc.).

---

The module is a thin JS-driven "deterrent" layered on top of the Webform module. `hook_webform_submission_form_alter()` attaches the `webform_deter/webform_deter` library and passes two `drupalSettings` values to the browser: `warning_message` and `patterns`. The behavior in `js/webform_deter.js` binds a submit listener to Webform forms; on submit it compiles each configured pattern into a case-insensitive `RegExp` and tests every `input[type=text]` and `textarea` value. If any field matches, it shows `window.confirm(warning_message)`; clicking Cancel prevents that one submission (and then removes the listener so a corrected resubmit goes through) — this is a soft deterrent, not server-side validation or blocking. Settings live in config object `webform_deter.settings` (`warning_message` string, `patterns` sequence of regex strings) edited at `/admin/config/system/webform_deter/settings` via `WebformDeterSettingsForm`, gated by the `administer webform_deter` permission (which is `restrict access: true`). Patterns are entered one-per-line in a textarea and stored as a trimmed, non-empty list. The module ships a helpful default warning message and an empty pattern list (so nothing triggers until you add patterns).

---

- Warn users before they submit an apparent Social Security Number in a webform.
- Warn users about apparent credit card numbers in text fields.
- Detect date-of-birth-looking values and caution against submitting them.
- Detect driver's license patterns (e.g. 9 consecutive digits).
- Match keyword hints like "ssn", "credit card", or "date of birth" and warn.
- Show a custom, reassuring warning message explaining what to do.
- Reduce accidental collection of PII in general-purpose contact forms.
- Add lightweight client-side guardrails without changing the webform's fields.
- Let users proceed after acknowledging the warning (soft deterrent, not a hard block).
- Allow a corrected resubmission to go through without repeated nagging.
- Apply the same set of patterns across all webforms on the site at once.
- Configure any number of custom regular expressions for site-specific sensitive data.
- Use case-insensitive matching so "SSN" and "ssn" both trigger.
- Keep the warning text and patterns in exportable config for deployment.
- Restrict who can edit deter patterns via the `administer webform_deter` permission.
- Nudge users toward removing sensitive data rather than silently accepting it.
- Pair with server-side/webform validation for defense in depth (this module is client-side only).
