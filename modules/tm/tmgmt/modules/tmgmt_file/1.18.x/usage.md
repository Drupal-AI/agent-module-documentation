Export / Import File (tmgmt_file) is the TMGMT provider that translates content **offline via files**: it exports a job's source text to an XLIFF or HTML file for an external translator or agency, then imports the translated file back into the job for review.

---

tmgmt_file registers a `file` translator plugin (`Plugin\tmgmt\Translator\FileTranslator`) that, on submitting a job, serializes the job's translatable data into a downloadable file and moves the job to *active*, waiting for the translated file to be uploaded back. The file format is itself a pluggable type: `plugin.manager.tmgmt_file.format` (namespace `Plugin/tmgmt_file/Format`) ships **`xlf`** (XLIFF, the localization-industry standard) and **`html`** implementations of `FormatInterface`, and you can add your own format plugin. Provider settings (`tmgmt.translator.settings.file`) include `export_format` (default `xlf`), `allow_override` (let the requester pick the format per job), `scheme` (stream wrapper, default `public`), and XLIFF options `xliff_processing` (convert inline HTML to XLIFF tags) and `xliff_cdata`. When a translated file is imported, TMGMT validates it belongs to the job and loads the translations back for the normal review/accept flow. The submodule also provides Drush commands (`tmgmt_file.commands`) to script export/import. It depends on `tmgmt` and core `file`, and is configured on the Providers page.

---

- Send content to an external translation agency as an XLIFF file.
- Export a job to XLIFF, translate offline in a CAT tool, and import it back.
- Export/import translations as HTML when an agency prefers HTML.
- Let the requester choose the export format per job (`allow_override`).
- Store exported files under a specific stream wrapper/scheme (e.g. `private://`).
- Convert inline HTML markup into XLIFF inline tags on export (`xliff_processing`).
- Wrap segment text in CDATA in the XLIFF (`xliff_cdata`).
- Provide a translation workflow with no live API integration required.
- Import a returned file and route it into the standard TMGMT review UI.
- Validate that an uploaded translation file actually matches the target job.
- Script bulk export/import from the command line via the module's Drush commands.
- Add a custom file format (e.g. CSV, PO) by implementing a `FormatPlugin`.
- Use XLIFF interchange with third-party translation management systems.
- Batch many content items into one job and export them as a single file.
- Combine with tmgmt_content to export node/entity content to agencies.
- Keep an auditable file artifact of every translation exchange.
- Support providers that cannot integrate with Drupal directly.
- Round-trip translations for languages your team outsources.
- Serve as a reference implementation of a file-based TMGMT translator with a sub-plugin format type.
