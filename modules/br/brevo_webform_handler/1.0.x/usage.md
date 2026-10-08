<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Brevo Webform Handler adds a Webform handler that, on each submission, creates or updates a contact in a Brevo (formerly Sendinblue) list through the Brevo Contacts API.

---

The module provides a single Webform handler plugin (`brevo_webform_handler`) built on the Webform module's handler API and the official `getbrevo/brevo-php` SDK. You attach the handler to any webform from *Settings → Emails / Handlers*, paste a Brevo API key, click *Update Brevo lists* to pull your lists from the account, pick the target list, then map webform elements to Brevo fields: the required *Email* mapping supplies the contact email, and each Brevo "normal"-category attribute (merge field) on the account is offered as an optional select mapped to a webform element. On submission the handler builds a `CreateContact` with `updateEnabled = TRUE` (so existing contacts are updated, not rejected), sets `listIds` to the chosen list, fills `attributes` from the mapped elements, and calls `ContactsApi::createContact()`. It is a lightweight, config-only integration — no entities, no permissions, no routes, no Drush — that turns signup, newsletter, contact, and lead webforms into Brevo list subscriptions. Because it forwards submitter personal data to an external marketing service and needs an account API key, treat consent, disclosure, and credential handling as part of setup.

---

- Send Webform submissions to a Brevo contact list.
- Create a Brevo contact from a newsletter signup form.
- Update an existing Brevo contact when the same email submits again (`updateEnabled = TRUE`).
- Add subscribers to a specific Brevo list chosen per handler.
- Map a webform email element to the Brevo contact email address.
- Map webform elements to Brevo contact attributes (merge fields such as FIRSTNAME, LASTNAME).
- Capture leads from a contact form into Brevo for follow-up campaigns.
- Feed a marketing/CRM list from a Drupal site without custom code.
- Run several handlers on one webform to push to different Brevo lists.
- Attach the same integration to multiple webforms independently.
- Pull the account's lists into the handler settings with the *Update Brevo lists* button.
- Populate the field-mapping selects from the account's Brevo attributes automatically.
- Grow a mailing list from event registration submissions.
- Sync a "request a demo" form into a sales pipeline list.
- Collect double-opt-in-style newsletter signups (with consent handled by the form).
- Integrate Webform with Brevo transactional/marketing contacts.
- Keep submission-to-Brevo delivery inline (handled during `submitForm`).
- Use with any Brevo account that exposes a v3 API key.
- Replace bespoke Guzzle-to-Brevo glue code with a configurable handler.
- Segment incoming contacts by routing different forms to different lists.
