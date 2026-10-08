<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FZ152 — Contact lets the FZ152 consent checkbox be attached to core Contact module forms, choosing per contact-form bundle whether the checkbox appears, its weight, and which checkbox label to use.

---

This glue submodule bridges FZ152 with core Contact. It has no UI of its own beyond a settings form at
`/admin/config/system/fz152/contact` (route `fz152.contact`, permission `administer fz152`) that lists
every `contact_message` bundle with three controls: an enable checkbox, a weight, and a "checkbox title
number" (1–10, selecting one of the parent module's `checkbox_title_N` labels). Choices are stored in a
per-bundle config object `fz152_contact.settings.<bundle>`. `Fz152ContactService::getForms()` turns the
enabled bundles into form ids of the shape `contact_message_<bundle>_form`, which the parent module's
`hook_form_alter` merges into its match list — so the same required consent checkbox and validator are
injected into those contact forms. It also registers a config_translation group so the per-bundle
settings can be translated (defaults saved with `langcode: ru`).

---

- Require a personal-data consent checkbox on a site's contact forms.
- Enable the consent checkbox only on specific contact form bundles.
- Set where the checkbox appears on a contact form via a per-bundle weight.
- Pick which of the FZ152 consent labels a given contact form uses.
- Keep contact-form consent wording consistent with the rest of the site's forms.
- Translate per-bundle contact consent settings via config_translation.
- Add 152-FZ consent to the default site contact form without editing form code.
- Combine with fz152_consent to log consents captured on contact forms.
- Disable consent on a contact bundle by unchecking its enable box.
- Manage all contact-form consent settings from one admin page.
- Apply consent to the site-wide default `contact_message` (personal/feedback) form.
- Apply consent to a custom contact form bundle used for support requests.
- Order the consent checkbox relative to other contact fields via its weight.
- Reference a shorter or longer consent statement per contact form using label numbers 1–10.
- Ensure a required agreement blocks contact submissions until the user opts in.
- Auto-generate the correct `contact_message_<bundle>_form` id without knowing Drupal internals.
