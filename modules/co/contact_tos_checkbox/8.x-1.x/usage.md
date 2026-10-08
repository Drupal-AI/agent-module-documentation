<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contact TOS Checkbox attaches a required consent checkbox (e.g. "I have read and accept the privacy policy") to Drupal's default contact feedback form.
---
The module addresses the common legal/GDPR requirement to capture explicit consent before a visitor submits the contact form. It alters `contact_message_feedback_form` (via a `#[Hook]` implementation class with a `#[LegacyHook]` bridge in the `.module`) and, when enabled in config, injects a `#required` checkbox whose label and description are administrator-defined. Because the field is `#required`, the form cannot be submitted until the visitor ticks it.

Configuration lives at `/admin/config/user-interface/contact-tos-checkbox` behind the `administer contact tos checkbox` permission. The settings form (a `ConfigFormBase`) stores three values in `contact_tos_checkbox.settings`: `feedback.enabled`, `feedback.label`, and `feedback.description`. The shipped default label/description are in German and link to a `/datenschutz` page, so most sites will edit them. The description is stored as config and rendered as markup, so treat editing it as an administrative (trusted) action.

Typical setup: enable the module (requires core Contact), open the settings page, turn on the checkbox, and set the label and description text/link that matches your legal copy.
---
- Require visitors to accept terms before sending the contact form.
- Add a GDPR/privacy consent checkbox to the default feedback form.
- Customize the consent checkbox label.
- Customize the consent checkbox description (supports an HTML link to a policy page).
- Toggle the checkbox on or off site-wide from config.
- Link to a privacy/terms page from the checkbox description.
- Localize the consent text (default ships in German).
- Enforce consent via an unskippable `#required` field.
- Restrict who can edit the consent settings via a dedicated permission.
- Provide an auditable, config-exportable consent label/description.
- Satisfy a legal review that requires explicit contact-form consent.
- Deploy consistent consent wording across environments through config.
- Place the checkbox near the bottom of the contact form (weighted).
- Use with core Contact's site-wide feedback form.
- Keep consent copy in version control with the rest of site config.
