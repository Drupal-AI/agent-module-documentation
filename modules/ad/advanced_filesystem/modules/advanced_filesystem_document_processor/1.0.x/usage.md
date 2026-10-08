Advanced Filesystem: Document Processor extracts text and metadata from DOCX files in pure PHP and, with LibreOffice and Ghostscript, converts, signs, merges and thumbnails them from a per-file admin UI.

---

This submodule of Advanced FileSystem turns uploaded Word documents into a managed, searchable, transformable asset. Reading (text, core/app properties, embedded images, hyperlinks, headings) is done entirely in PHP with ZipArchive, so basic extraction and PII scanning work with no external binaries. Heavier operations shell out to LibreOffice (`soffice`) for PDF/HTML/ODT conversion and to Ghostscript (`gs`) for PDF signing, merging, page-range extraction, page removal and per-page thumbnails. Files can be processed automatically on upload (via a queue), in a batch, or one at a time from the file's "Document Info" / "Editar Documento" operations. Results are persisted in `adfs_document_jobs`, `adfs_document_derivatives` and `adfs_document_page_thumbs`, surfaced through a dashboard with coverage stats and a cleanup action. Every route, download and operation is restricted to holders of the `administer advanced_filesystem_document_processor` permission.

---

- Extract plain text from a `.docx` for indexing or search without installing any external tool.
- Read DOCX core properties (title, author, subject, created/modified) and app properties (page/word/character counts).
- Flag documents containing PII (CPF, CNPJ, e-mail, credit-card patterns) after text extraction.
- Auto-queue every uploaded Word document for processing by enabling "Auto-process on file upload".
- Batch-process a large backlog of existing DOCX files from the Batch Processing screen.
- Convert a Word document to PDF via LibreOffice for archival or distribution.
- Convert a Word document to HTML for web display.
- Convert a Word document to ODT for an open-format archive.
- Strip hidden metadata (author, revision history) from a DOCX before sharing it externally.
- Fill a DOCX template by replacing `{{VARIABLE}}` placeholders with supplied values.
- Bulk find-and-replace text across a document body and save a new derivative.
- Accept all tracked changes (drop deletions, unwrap insertions) to produce a clean final DOCX.
- Extract all embedded images (word/media/*) from a document into a private directory.
- Generate a table of contents from Heading/Title styles.
- Validate hyperlinks embedded in a document by issuing HEAD requests and reporting broken links.
- Produce a side-by-side HTML word-level diff between two document versions.
- Edit DOCX core metadata (title, author, subject, description) and save a corrected copy.
- Sign a PDF derivative with a signer name, reason, timestamp and SHA-256 hash (metadata-based).
- Merge several documents into a single combined PDF.
- Extract a contiguous page range from a document's PDF rendering.
- Keep or remove specific pages from a document's PDF rendering.
- Password-protect and set permissions (print/copy) on a generated PDF.
- Generate per-page JPEG thumbnails for a document preview gallery.
- Review processing coverage, PII counts and PDF-conversion counts on the dashboard.
- Clean up derivative files older than a retention threshold from the dashboard.
- Reprocess previously failed jobs in one action.
- Enforce a maximum file size (MB) so oversized documents are skipped rather than processed.
