<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Book PDF prints an entire Book to a PDF file.

---

Book PDF **prints an entire Book to a PDF file** — generating a downloadable PDF of a book's page tree (the
book node and its child pages) from core's Book module. It depends on core Book, provides its own permissions,
in the Book package.

The download route `/book-pdf/{book}/send` uses `_permission: 'access content'` and takes the book as a
`type: entity:node` route parameter. `BookPdfController::sendPdf()` calls `BookPdfGenerator::getFileUri($book)`
and returns the PDF as a `BinaryFileResponse`; `getFileUri()` **generates the PDF on demand**
(`getPdfContents()` renders the book tree) if not cached. Configure the PDF settings (admin) and the permission.

---

- Print a Book to a PDF file.
- Render the book page tree.
- Depend on core Book.
- Generate the PDF on demand.
- Serve book export.
- Provide its own permissions.
- Gate the route by 'access content'.
- Render child pages too.
- Handle book PDFs.
- Generate PDFs.
- Configure the settings.
- Export books.
- Handle the export.
- Print books.
- Provide book-to-PDF.
