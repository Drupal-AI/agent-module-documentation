<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTML to PDF converts an uploaded HTML file to PDF using the Dompdf library.

---

HTML to PDF **converts HTML files to PDF** — an upload form that renders an uploaded HTML file to a PDF using
the Dompdf PHP library. It works on core 10–11.

Use it to generate PDFs from HTML. It is a content/utility feature that uses **Dompdf** (a PHP library — no shell
execution, so no command injection). Security caveat: it renders **user-uploaded HTML** through Dompdf, so keep
Dompdf's **remote resources disabled** (`isRemoteEnabled = false`, the default) to avoid SSRF via
`<img src>`/`@import`, avoid enabling `phar://` handling, gate the upload form to trusted users, and treat uploaded
HTML as untrusted. It has no access-control role. Configure the conversion.

---

- Convert HTML files to PDF.
- Use the Dompdf library.
- Render uploaded HTML.
- Serve content/utility.
- Provide an upload form.
- Generate PDFs.
- Use Dompdf (a PHP library - no shell execution/injection).
- Keep Dompdf remote resources disabled (avoid SSRF) + avoid phar handling.
- Gate the upload form to trusted users + treat uploaded HTML as untrusted.
- Have no access-control role.
- Configure the conversion.
- Handle HTML-to-PDF.
- Convert HTML.
- Configure the form.
- Render PDFs.
- Handle the upload.
- Produce PDFs.
- Generate documents.
- Restrict uploads.
- Provide HTML-to-PDF conversion.
