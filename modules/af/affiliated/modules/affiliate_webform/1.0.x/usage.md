<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Creates affiliate conversions when submissions are made to selected webforms by a cookied visitor.

---

Affiliate Webform attributes Webform submissions to affiliates. It implements
`hook_webform_submission_insert()` and, for every affiliate conversion type that has been enabled for
the submitted webform, creates an `affiliate_conversion` crediting the visitor's cookied affiliate,
with the webform submission as the conversion's parent entity. Each affiliate conversion type gains
an "Affiliate Webform" fieldset on its form where you choose which webforms trigger it and set a
per-submission value. This lets you turn lead forms, contact forms, sign-ups and surveys into
affiliate conversion events. Requires the `webform` and `affiliated` modules.

---

- Reward affiliates for leads generated through specific webforms (contact, quote, sign-up, survey).
- Attribute a webform submission to the affiliate whose link cookied the submitter.
- Attach the webform submission to the conversion as its parent entity for traceability.
- Enable attribution per webform, so only the forms you choose create conversions.
- Map several webforms to a single conversion type, or use different types per form.
- Set a per-submission commission value on each conversion type.
- Require manual approval of webform conversions before they count toward payouts.
- Auto-generate conversion labels from the submission via the conversion type's label pattern.
- Run lead-generation affiliate programs alongside Commerce and registration attribution.
- Report referred submissions using the Affiliated conversions Views.
- Disqualify ineligible submissions with the framework's pre-create conversion event.
- Track submissions even when click-entity storage is disabled (cookie-only tracking).
