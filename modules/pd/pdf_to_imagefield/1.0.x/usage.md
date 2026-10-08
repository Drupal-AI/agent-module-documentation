<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PDF to ImageField takes an uploaded PDF and converts each page into an image, populating an image field with the per-page image files.

---

PDF to ImageField converts an uploaded PDF into per-page images and stores them in an image field.
When a PDF is imported, the module rasterises each page and creates image field items for the pages,
so a document can be shown as a gallery/preview of page images rather than an embedded PDF. It depends
on core File and provides Drush commands for running the conversion.

The conversion relies on a server-side PDF rasteriser (typically Ghostscript/Imagemagick via PHP),
which is worth noting operationally: PDF rasterisation of untrusted files is a known risk area
(ImageMagick/Ghostscript "delegate" vulnerabilities), so keep the underlying tooling patched and
constrain who may upload PDFs. Use it to build page-image previews of documents, catalogues or
brochures. Configure the target image field and run conversions via the UI or the provided Drush
commands.

---

- Convert a PDF into per-page images.
- Populate an image field from PDF pages.
- Show a document as a gallery of page images.
- Import a PDF and split its pages.
- Build page-image previews of brochures.
- Run conversions via provided Drush commands.
- Target a specific image field for output.
- Rasterise each PDF page to an image file.
- Depend on core File for storage.
- Preview a catalogue as page images.
- Constrain who may upload PDFs (untrusted input).
- Keep Ghostscript/ImageMagick patched.
- Avoid embedding a PDF viewer for previews.
- Generate thumbnails of PDF pages.
- Process PDFs in bulk via Drush.
- Store page images as image field items.
- Handle multi-page PDFs page by page.
- Display document pages in a gallery.
- Trigger conversion on PDF import.
- Mind delegate-tool security when rasterising.
