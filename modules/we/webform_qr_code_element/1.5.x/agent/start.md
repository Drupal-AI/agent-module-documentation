<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform QR Code Element (webform_qr_code_element) — agent index
**A computed Webform element that renders a token-driven QR code after submission and can attach it as PNG and/or positioned PDF to notification emails.**

- **Version:** 1.5.x (release 1.5.0)
- **Core:** ^10.2 || ^11 || ^12
- **Dependencies:** webform, token. Optional runtime: `email_attachment` (required for attaching).
- **Element:** `qr_code` (`src/Plugin/WebformElement/QrCode.php`, extends `WebformComputedToken`); render element `QrCodeElement`, `TextPosition`.
- **Service/controller:** `AttachmentService` (`webform_qr_code_element.attachment` / `create()`): builds PNG/PDF via Endroid QrCode + FPDI/FPDF, hooks `hook_mail_alter` to attach.
- **Route:** `webform_qr_code_element.download_test_pdf` → `/admin/structure/webform/manage/{webform}/element/{key}/download-test-pdf/{filename}`, `_custom_access: WebformUiAccess::checkWebformEditAccess`, `{filename}` regex `[-+_a-zA-Z0-9.]+`.
- **Security:** the only route requires webform edit access; the `{filename}` param is regex-restricted and the same regex re-validates configured filenames; the controller serves a fixed `public://webform_qr_code_element.pdf` path (no user-supplied path/traversal) and only reflects the validated filename into `Content-Disposition`. Uploaded PDF templates are FPDI-parsed and kept only if valid; all template/config handling is limited to authorised webform editors. No anonymous or mutating public endpoint.

See [configure/element.md](configure/element.md)
