Advanced Filesystem: PDF Processor extracts text, metadata and thumbnails from PDFs and, with Ghostscript, Tesseract and poppler, splits, merges, rotates, watermarks, compresses, OCRs, password-protects and PDF/A-exports them from a per-file admin UI.

---

This submodule of Advanced FileSystem builds a full PDF toolchain around external command-line tools. Its base pipeline uses pdftotext (text), pdfinfo (metadata, page count, PDF/A subtype) and Ghostscript (first-page JPEG thumbnail), classifies each document as scanned or PDF/A, and can auto-export to PDF/A. On top of that it offers a large library of derivative operations — page range, keep/remove pages, split into chunks, merge, rotate, resize, text watermark, compression presets, add/remove password, per-page thumbnails, Tesseract OCR of rasterised pages, embedded-image extraction and PDF/A conversion — each recorded in `adfs_pdf_derivatives`. A regex PII detector flags CPF, CNPJ, e-mail, Brazilian phone and credit-card patterns. Files are processed automatically on upload (queue `adfs_pdf_process`), in a batch, or one at a time; a dashboard reports coverage/scan/PII counts, and a diff viewer rasterises two PDFs and compares them page-by-page. Every route and private-derivative download requires the restricted `administer advanced_filesystem_pdf_processor` permission.

---

- Extract full text from a PDF (via pdftotext `-layout`) for indexing or search.
- Read PDF metadata and page count via pdfinfo.
- Detect whether a PDF is a scanned image (very little extractable text) and flag it.
- Detect PDF/A documents from the pdfinfo subtype.
- Generate a first-page JPEG thumbnail for previews.
- Auto-export processed PDFs to PDF/A for long-term archival.
- Flag PDFs containing PII after text extraction.
- Auto-queue every uploaded PDF for processing by enabling auto-process.
- Batch-process a backlog of existing PDF files.
- OCR a scanned/rasterised PDF page-by-page with Tesseract to recover text.
- Extract a contiguous page range (trim) into a new PDF.
- Keep only specific pages, or remove specific pages, from a PDF.
- Split a PDF into a number of roughly equal chunks.
- Merge several PDFs into one combined document.
- Rotate all or selected pages by 90/180/270 degrees.
- Resize pages to A4, A3, Letter or Legal.
- Add a diagonal text watermark at a chosen position and font size.
- Compress a PDF with screen/ebook/printer/prepress presets and report the size saving.
- Add an open (user) password with print/copy permission flags.
- Remove a known password from an encrypted PDF.
- Generate per-page thumbnails for a preview gallery.
- Extract embedded raster images from a PDF (via pdfimages).
- Convert a PDF to PDF/A-1/2/3 as a tracked derivative.
- Compare two PDFs visually with a page-by-page rasterised diff viewer.
- Review coverage, scanned-count and PII stats on the dashboard and clean up old derivatives.
