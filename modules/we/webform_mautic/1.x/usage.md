<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Mautic sends Webform submissions to Mautic as contacts, via Mautic's form integration.

---

Mautic is an open-source marketing-automation platform, and a common need is for a Drupal Webform submission — a signup, a contact request, a download form — to create or update a contact in Mautic so the marketing workflows there pick it up. Webform Mautic is that bridge: it maps a Webform submission to a Mautic form/contact and sends it across.

It depends on Webform and a Mautic instance to talk to. The data-handling note is that submissions — which are personal data — are forwarded to an external marketing system, so the privacy posture that applies to the Webform (consent, disclosure, what is collected) extends to Mautic: a form that feeds marketing automation should say so and collect consent where required, and the Mautic connection credentials should be kept out of plain configuration.

For a site running Mautic alongside Drupal, it closes the loop between form submissions and marketing automation without custom integration code. Confirm the field mapping and that consent is captured before submissions become marketing contacts.

---

- Send a Webform submission to Mautic.
- Create a Mautic contact from a form.
- Feed marketing automation from Webform.
- Map form fields to a Mautic contact.
- Integrate Webform with Mautic.
- Capture signups into Mautic.
- Sync a contact request to Mautic.
- Disclose marketing use on the form.
- Capture consent before sending.
- Keep Mautic credentials secure.
- Update a contact from a submission.
- Bridge Drupal and Mautic.
- Automate lead capture.
- Map submission to a Mautic form.
- Handle submission data as PII.
- Confirm the field mapping.
- Run Mautic with Drupal forms.
- Forward form data to marketing.
- Close the form-to-marketing loop.
- Send downloads-gate submissions to Mautic.