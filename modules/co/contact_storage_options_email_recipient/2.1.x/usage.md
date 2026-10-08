<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contact Storage Options Email Recipient tidies the contact-form edit page for contact_storage's "Options email" field.

---

Contact Storage Options Email Recipient is a small **admin convenience** for the
[Contact Storage](https://www.drupal.org/project/contact_storage) module's **"Options email"** field
type. Contact Storage's field already lets a submitter's chosen option add the email recipient, but
Drupal core still forces an admin to type a fixed recipient on the contact form's edit page — so mail
goes to **both** the typed address and the option-selected one. This module removes that now-redundant
recipient field when a **required** "Options email" field is present, and shows a notice: "The recipient
of this form is determined by the '[field name]' field." When the "Options email" field is optional, it
instead notes the field adds an *additional* recipient and leaves the recipient field in place.

The recipient mapping itself (each option → an address) is defined and handled entirely by Contact
Storage; the submitter picks from the admin-defined option list. This module does not read or change the
recipient at submit time — it only edits the admin-facing contact-form definition. It has no routes,
permissions, services, or configuration of its own.

---

- Depend on the Contact Storage module.
- Refine contact_storage's "Options email" field type.
- Remove the redundant recipient field on the edit page.
- Do this only when a required "Options email" field is present.
- Show a "recipient is determined by …" notice.
- For an optional "Options email" field, show an "additional recipient" notice instead.
- Leave the recipient field when the field is optional.
- Bypass core's required-recipient validation with a dummy value, then clear it.
- Swap the contact_form add/edit form handler class.
- Affect only the admin contact-form edit page.
- Leave the front-end submission flow untouched.
- Add no routes, permissions, services, or config.
- Let Contact Storage handle the option→address mapping.
- Serve forms.
