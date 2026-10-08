<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Signature Field provides a signature form element and field type: a canvas where a user draws a signature with mouse or touch, stored as field data or a generated PNG file.

---

Capturing a signature — an agreement, a consent, a delivery confirmation — is a common need, and doing it well means a drawing surface that works on touch devices and a way to persist the result. This module supplies both: a `Signature` form element backed by a signature-pad library, field types (including a file-backed variant), widgets and a formatter, plus a `PngConverter` that turns the drawn strokes into a PNG.

Unlike some signature modules, it is built entirely as **field-type/element machinery with no routes or controllers** — there are no AJAX endpoints that accept and save signatures out of band. That matters: the signature is captured and stored through the normal entity form and field save path, so it inherits standard field and entity **access control**. There is no unauthenticated write surface of the kind that has undermined other signature/drawing modules — a signature is written only when a user who can edit the entity saves it.

The thing to be clear-eyed about is what a captured signature *means*. A drawn-on-a-canvas signature is evidence of intent at best, not a cryptographic signature — it does not authenticate the signer or bind the document, and the stored PNG is as trustworthy as the access controls on the entity that holds it. Treat it as a UX artifact for consent/agreement flows, protect the entities that carry signatures with appropriate permissions, and do not rely on it as a legal or cryptographic guarantee.

---

- Capture a drawn signature.
- Add a signature field to a form.
- Sign on a touch device.
- Store a signature as a PNG.
- Collect consent with a signature.
- Confirm a delivery with a signature.
- Add a signature pad element.
- Save a signature to a field.
- Render a stored signature.
- Use the file-backed signature type.
- Capture agreement on a form.
- Sign with mouse or touch.
- Rely on standard field access control.
- Protect entities holding signatures.
- Avoid unauthenticated signature endpoints.
- Add a signature to a webform-like flow.
- Treat signatures as UX, not crypto.
- Store signatures with the entity.
- Generate a PNG from strokes.
- Collect a sign-off.