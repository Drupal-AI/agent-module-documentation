<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FZ152 helps a site comply with Russian federal law 152-FZ ("On Personal Data") by injecting a required "I consent to the processing of my personal data" checkbox into chosen forms and by publishing a ready-made privacy-policy page.

---

The module (Russian-oriented, ships Russian default config) does three things. (1) It adds a **required consent checkbox** (or a plain informational text item) to any form whose form id you list on *Configuration → System → FZ152 → Forms*; matching supports newline-separated ids and `*` wildcards, and each line can pick a checkbox weight and one of ten configurable checkbox labels (`checkbox_title`…`checkbox_title_10`, HTML allowed — they carry a link to the policy). (2) It exposes a **privacy-policy page** at a configurable path (default `/privacy-policy`, permission `access content`) whose body is admin-entered `processed_text` (default is a full Russian policy in `basic_html`); a route subscriber removes the route entirely when the page is disabled. (3) It gates all settings behind the single `administer fz152` permission. The consent-checkbox injection is done in `hook_form_alter` via `Fz152Service::formIdMatches()`; an element validator (`fz152_agreement_element_validate`) blocks submission until the box is ticked. Two optional submodules extend it: **fz152_contact** wires the checkbox into core Contact forms per bundle, and **fz152_consent** additionally *logs* each consent (IP, form id, and selected source field values) as a `fz152_consent` entity viewable in an admin View.

---

- Add a legally-required "I consent to personal-data processing" checkbox to a site's forms.
- Force users to tick a consent box before a form (registration, contact, webform) will submit.
- Show consent text as a non-blocking informational note instead of a required checkbox (toggle `is_checkbox`).
- Target specific forms by exact form id (e.g. `user_register_form`).
- Target many forms at once with a wildcard pattern (e.g. `webform_submission_*`).
- Assign a per-form weight so the checkbox lands in the right place on the form.
- Use different consent wording on different forms via the 10 configurable checkbox labels.
- Embed a link to the privacy policy inside the checkbox label (HTML labels).
- Publish a ready-to-use Russian 152-FZ privacy-policy page without writing one from scratch.
- Serve the privacy policy at a custom URL path instead of `/privacy-policy`.
- Disable the privacy-policy route so no policy page is exposed.
- Translate the consent labels and policy page via config_translation (module ships `ru` defaults).
- Add the consent checkbox to core Contact forms per contact form bundle (fz152_contact).
- Log who consented, from which form, and their submitted contact details (fz152_consent).
- Record the client IP address against each consent for audit purposes (fz152_consent).
- Review collected consents in an admin View at the consents listing (fz152_consent).
- Bulk-delete stored consent records from the admin listing (fz152_consent).
- Restrict all FZ152 configuration to trusted administrators via `administer fz152`.
- Provide GDPR-style consent gating on an international/Russian-facing Drupal site.
- Keep consent wording centrally managed rather than hard-coded into each form.
- Comply with 152-FZ notice-and-consent requirements with minimal custom code.
