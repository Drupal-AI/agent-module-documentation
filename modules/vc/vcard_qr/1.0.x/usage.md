<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
vCard QR exposes a `/form/vcard` form where a user enters name, job, phone, email and company; on submit it builds a vCard (Sabre VObject) and renders it as a QR code (chillerlan/php-qrcode) shown inline as a base64 PNG with a download link.

---

The form route requires a `create vcard qrcode` permission. Note a naming mismatch: `vcard_qr.permissions.yml` actually defines `created vcard qrcode` (a typo), so the permission referenced by the route does not exist and is effectively grantable to no role — only user 1 can reach the form until this is fixed. The generated QR markup is emitted through an `inline_template` with `{{ newqrcode|raw }}`, but the interpolated value is a module-built `data:` URI (the QR image), not user text — the submitted contact fields are encoded into the QR image binary, not reflected into HTML — so this is not an XSS sink. No server-side fetch of user URLs (no SSRF). Third-party libraries are pulled via Composer.

---

- Generate a scannable vCard QR code from a web form.
- Let visitors download their contact card as a PNG.
- Produce QR codes for business-card printing.
- Encode name, phone, email and company into a single QR.
- Offer a self-service contact-exchange page at an event.
- Add a QR contact widget to a staff directory.
- Create shareable vCards without external services.
- Restrict QR generation to a specific permission/role.
- Embed the QR image inline via a data URI (no file storage).
- Provide a download button for the generated card.
- Support optional job title and company fields.
- Require name and mobile while keeping other fields optional.
- Fix the `create` vs `created` permission typo before granting access.
- Use the bundled Composer libraries for vCard and QR rendering.
- Extend the Twig template to restyle the output.
- Keep the form behind authentication for internal directories.
- Combine with a contact page to share reception details.
