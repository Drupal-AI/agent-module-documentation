<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FZ152 — Consent records every consent given through an FZ152-tracked form as a stored entity — capturing the client IP, the form id, and selected submitted field values — and lists them in an admin View.

---

This submodule adds an audit trail on top of FZ152. Its own `hook_form_alter` re-uses the parent
`Fz152Service` (plus `fz152_contact` when present) to detect the same set of tracked forms, and appends
a submit handler `_fz152_consent_custom_form_submit` to matching forms. On submit it reads the current
request's client IP, the `form_id`, and the values of the fields named in `fz152_consent.settings:source`
(default `name`, `surname`, `email`, `phone`, `mail`; newline-separated; webform elements supported),
joins those values, and — if non-empty — creates an `fz152_consent` content entity via
`FZ152ConsentService::createConsent()`. The entity (`base_table fz152_consent`) has fields `created`,
`ip`, `form_id`, `source`, an `admin_permission` of `administer fz152_consent` (restrict access), and
delete / delete-multiple routes. An installed View (`fz152_consents`) lists the records for admins.
Configure the tracked source field names at `/admin/config/system/fz152/consent-settings`.

---

- Keep an auditable log of who consented to personal-data processing and when.
- Record the client IP address against each consent for 152-FZ evidence.
- Store which form the consent came from (`form_id`).
- Capture the submitter's name / email / phone alongside the consent record.
- Configure exactly which form fields are saved as the consent "source".
- Track consents from webform submissions as well as standard forms.
- Track consents from contact forms when used with fz152_contact.
- Review all collected consents in the admin `fz152_consents` View.
- Delete an individual consent record via its delete route.
- Bulk-delete consent records from the admin listing.
- Prove consent was obtained before processing a user's data.
- Restrict access to consent records to trusted admins (`administer fz152_consent`).
- Add consent logging without changing any existing form code.
- Retain a lightweight consent history without a full CRM.
- Exclude sensitive fields from the log by leaving them out of the source list.
- Support GDPR-style "record of consent" requirements on a Drupal site.
