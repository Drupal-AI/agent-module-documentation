Advanced Filesystem: Presentation Processor extracts slide text, speaker notes and metadata from PPTX files in pure PHP and, with LibreOffice and Ghostscript, converts them to PDF and a per-slide image gallery from a per-file admin UI.

---

This submodule of Advanced FileSystem turns uploaded PowerPoint presentations into managed, searchable assets. All reading is pure PHP via ZipArchive: it iterates `ppt/slides/slideN.xml` (up to 500 slides) to count slides and extract text, `ppt/notesSlides/notesSlideN.xml` for speaker notes, and `docProps/core.xml` for title, author, subject and created/modified dates — so slide-count, text, notes and metadata work with no external tools. Two optional stages shell out: LibreOffice (`soffice --impress`) converts the presentation to PDF, and Ghostscript renders that PDF into a numbered per-slide image gallery (JPEG or PNG, configurable width). Results are stored in `adfs_presentation_jobs`, processed on upload (queue `adfs_presentation_process`), in a batch, or per file, and surfaced through a Presentation Info view and a coverage dashboard. Every route and private-output download requires the restricted `administer advanced_filesystem_presentation_processor` permission.

---

- Count the slides in an uploaded `.pptx` without any external tool.
- Extract all slide text for indexing or full-text search.
- Extract speaker notes separately from slide text.
- Flag whether a presentation contains speaker notes.
- Read presentation metadata (title, author, subject, created/modified dates).
- Auto-queue every uploaded PowerPoint for processing by enabling auto-process.
- Batch-process a backlog of existing PPTX files.
- Convert a presentation to PDF via LibreOffice for distribution or archival.
- Generate a per-slide image gallery (JPEG or PNG) from the converted PDF.
- Choose the slide-image format (jpg/png) and output width.
- Use the first slide image as a presentation thumbnail.
- Preview extracted slide text (escaped) on the Presentation Info screen.
- Display the presentation thumbnail on the file's info page.
- Store all extracted data as a single job row per file for later querying.
- Skip oversized presentations via a configurable maximum file size (MB).
- Review coverage stats (total/done/failed/with-notes/with-slides) on the dashboard.
- Point the module at custom `soffice`/`gs` binary paths for non-standard hosts.
- Serve generated PDFs and slide images only to authorised administrators (private stream).
- Drive slide/notes extraction from a media Source plugin for a presentation media type.
- Reprocess presentations after changing conversion settings.
