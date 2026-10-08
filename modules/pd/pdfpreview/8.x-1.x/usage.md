<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PDF Preview generates and shows a snapshot image of the first page of PDF files attached to file fields.

---

PDF Preview adds a "PDF Preview" formatter for core file fields. When a referenced file is a PDF, it uses
the ImageMagick toolkit (via the imagemagick contrib module) to rasterise the document's first page into
a JPG or PNG thumbnail, then renders that thumbnail through the core image formatter — so you get image
styles, an optional link to the content or the file, and an optional description. Previews are created
lazily the first time a PDF is displayed and cached as image files under a configurable path in the
default file scheme; they are regenerated when the underlying file changes and cleaned up when it is
deleted. A site-wide settings page controls the preview size, image quality, output type (JPG/PNG),
storage path, and whether generated filenames are human-readable or hashed. Non-PDF files in the same
field fall back to a normal file link. ImageMagick must be installed on the server and configured to
allow reading PDFs, but it does not need to be Drupal's default image toolkit.

---

- Show a PDF's first page as a thumbnail on a node.
- Replace a generic file icon with a document-cover image.
- Preview attached PDFs in a content listing or teaser.
- Add visual cues to a document library UI.
- Display report or whitepaper covers.
- Link a PDF thumbnail to the file for download.
- Link a PDF thumbnail to the host content.
- Apply an image style to PDF previews.
- Generate JPG previews for smaller file sizes.
- Generate PNG previews for sharper text.
- Store previews under a custom files sub-directory.
- Use human-readable preview filenames for easier debugging.
- Use hashed preview filenames to avoid name collisions.
- Show a file description next to each preview.
- Choose a span or div wrapper for theming previews.
- Preview policy documents, invoices, or manuals.
- Auto-refresh a preview when the PDF is re-uploaded.
- Clean up preview images automatically when a PDF is deleted.
- Improve document discovery in search or grid displays.
- Render previews without making ImageMagick the default toolkit.
- Cap preview dimensions to keep derivatives small.
- Fall back to a plain file link for non-PDF uploads.
- Tune image quality per site via one settings page.
- Generate the preview programmatically through the generator service.
