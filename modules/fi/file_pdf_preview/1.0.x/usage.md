<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File PDF Preview provides a field widget which generates a preview image from a PDF file.

---

File PDF Preview provides a **field widget that generates a preview image from a PDF** — rendering the
first page of an uploaded PDF as a thumbnail/preview image, so PDF attachments show a visual preview instead of
just a file icon. It depends on core File, in the Field package.

Use it to show PDF previews. It is a media/field feature that **processes uploaded PDFs server-side** (rendering
a page to an image, typically via an imaging library such as Imagick/Ghostscript). Security note: PDF-to-image
tooling has historically had vulnerabilities (e.g. Ghostscript), so keep the underlying **image/PDF library
patched** and treat PDF processing of untrusted uploads with the usual care. It has no access-control role.
Configure the widget on a file/PDF field.

---

- Generate a preview image from a PDF.
- Render the first PDF page.
- Show PDF thumbnails.
- Depend on core File.
- Process uploaded PDFs server-side.
- Use an imaging library (Imagick/Ghostscript).
- Keep the PDF/image library patched.
- Handle untrusted PDFs with care.
- Have no access-control role.
- Configure the widget.
- Handle PDF previews.
- Preview PDFs.
- Generate thumbnails.
- Handle the widget.
- Render PDF pages.
- Configure the field.
- Handle PDF processing.
- Show previews.
- Set the widget.
- Provide PDF previews.
