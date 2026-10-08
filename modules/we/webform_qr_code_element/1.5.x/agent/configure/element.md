<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform QR Code Element — configuration

Add the **QR Code** element to a webform (Computed Elements category). It extends `WebformComputedToken`.

## Content
`computed.template` (required, textarea): the token template encoded into the QR code. Supports `webform`, `webform_submission`, `webform_handler`, `site`, `date` tokens. Examples: `[webform_submission:sid]-[webform_submission:created]`, `[webform_submission:token]`, or an EPC/SEPA payment string. The QR renders only **after** submission.

## Image settings
- `show_label_below_code` — print the encoded text under the QR image.

## Email attachments (needs the `email_attachment` module)
- `attach_png_to_emails` + `png_attachment_filename`.
- `attach_pdf_to_emails` + `pdf_attachment_filename`.
- `pdf_template` (managed_file, `.pdf`) — optional page to stamp onto; FPDI-parsed on save, kept only if valid.
- `pdf_qr_size` (21–210 mm), `pdf_qr_x` (0–210 mm), `pdf_qr_y` (0–297 mm).
- `textfields` (`text_position` multiple) — extra text/Twig items placed at X/Y with font/size/bold/italic/underline; tokens replaced per submission.

Filenames are validated against `[-+_a-zA-Z0-9.]+`.

## Test button
"Show test PDF" (`ajaxPdfPreview`) saves a preview to `public://webform_qr_code_element.pdf` using the latest submission (or a generated random one) and redirects to the `download_test_pdf` route (webform edit access).

## Delivery
`AttachmentService` implements `hook_mail_alter`: for a submission whose webform has a `qr_code` element, it appends the PNG and/or PDF to `message['params']['attachments']` (PNG via Endroid QrCode, PDF via Endroid `PdfWriter` + FPDI/FPDF template).
