<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Masked Input adds "masks" to text fields — placeholder patterns like `(___) ___-____` for a phone number or `__/__/____` for a date — that guide the user as they type and communicate the expected format at a glance.

---

A bare text field for a phone number, a postal code or a reference number tells the user nothing about the format expected, so they type it every way imaginable and validation (or a downstream system) rejects half of them. An input mask fixes this at the point of entry: the field shows the shape of the value, and characters fall into place as the user types, so the format is communicated and enforced in the browser.

This module brings that pattern to Drupal form fields, with a settings page to configure the masks and the definitions to apply. It is a genuine usability improvement for structured-but-freeform inputs, and it reduces malformed submissions.

The essential thing to understand is that **a mask is a client-side convenience, not validation**. It runs in JavaScript in the browser; it shapes what a cooperating user types and does nothing to a client that ignores it — a script, a curl request, or a browser with JS disabled submits whatever it likes. So the mask must always be backed by server-side validation on anything that matters: never rely on the mask to guarantee a value's format, and never treat a masked field as sanitised. Used as what it is — a formatting hint that improves the human experience — it is a small, useful addition; mistaken for a validation control, it is a false assurance.

---

- Show the expected format of a field.
- Mask a phone number input.
- Mask a date input.
- Mask a postal code field.
- Guide users as they type.
- Reduce malformed submissions.
- Communicate a reference-number format.
- Improve form usability.
- Configure masks on a settings page.
- Apply a mask to a text field.
- Format structured inputs at entry.
- Back the mask with server-side validation.
- Never treat a masked field as validated.
- Account for JS-disabled clients.
- Account for non-browser submissions.
- Add a formatting hint to a form.
- Standardise how a value is entered.
- Lower data-cleaning effort.
- Mask a credit-card-style field visually.
- Treat the mask as UX, not security.