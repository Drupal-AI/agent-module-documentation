<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform QR Code Element adds a computed "QR Code" webform element that encodes token-based content into a QR image shown after submission, and can attach that QR code as a PNG and/or a positioned PDF (e.g. a ticket) to the form's notification emails.
---
The element extends Webform's computed-token element, so its content is a token template (`[webform_submission:token]`, sid/created, or arbitrary text such as an EPC/SEPA payment string) evaluated per submission; the QR image is rendered only after submission, not while filling the form. Form authors can enable a PNG attachment and/or a PDF attachment, optionally supplying a PDF template file to stamp the QR onto, choosing the QR size and X/Y position in millimetres, and adding extra token/Twig text fields placed on the page via FPDI/FPDF. A "Show test PDF" button generates a preview using the latest (or a randomly generated) submission. Email attachment delivery relies on the contributed `email_attachment` module, which the element checks for and prompts to enable.

The security surface is admin/author-scoped. The only route, `/admin/structure/webform/manage/{webform}/element/{key}/download-test-pdf/{filename}`, is gated by `WebformUiAccess::checkWebformEditAccess` (webform edit access) and its `{filename}` route argument is constrained by the regex `[-+_a-zA-Z0-9.]+`; the same regex is re-validated on the configured attachment filenames. The download controller reads a fixed `public://webform_qr_code_element.pdf` preview path (not a user-supplied path) and only reflects the validated filename into the `Content-Disposition` header. PDF templates are parsed with FPDI and only kept if parseable; template handling is limited to files an authorised webform editor uploads. Setup: add a QR Code element to a webform, set its token template, and configure PNG/PDF attachment options.
---
- Add a QR Code computed element to a webform.
- Encode a submission token (`[webform_submission:token]`) into the QR code.
- Encode the submission id + created timestamp for entry tickets.
- Encode an EPC/SEPA credit-transfer payload for payment QR codes.
- Show the encoded text as a label below the QR image.
- Display the QR code only after submission (not during completion).
- Attach the QR code as a PNG to notification emails.
- Attach the QR code as a PDF document to notification emails.
- Upload a PDF template to stamp the QR code onto (e.g. a branded ticket).
- Set the QR code size in millimetres for the PDF.
- Position the QR code by X/Y millimetre offsets on the PDF page.
- Add extra token/Twig text fields at chosen positions on the PDF.
- Style PDF text as bold, italic or underlined.
- Preview the generated PDF via the "Show test PDF" button.
- Generate a preview from the latest or a random sample submission.
- Validate a configured attachment filename against the allowed character set.
- Validate that an uploaded PDF template can be parsed before saving it.
- Prompt to enable the `email_attachment` helper module when attachments are used.
- Use QR codes for participant lookup/verification by external scanners.