<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DOC to HTML lets editors upload a DOC/DOCX file and have LibreOffice convert it to HTML that is injected into a CKEditor 5 text field.

---

A field widget (`DocToHtmlWidget`) adds an upload control to text fields; on conversion the `ConversionManager`/`CmdService` shells out to a configured LibreOffice binary (`soffice --headless --convert-to html`) and `MarkupService` extracts and cleans the body HTML before it is placed into the editor. Commands are built with `escapeshellcmd()` on the executable and `escapeshellarg()` on the file paths, and `CmdService` runs LibreOffice through `proc_open` with an enforced timeout (falling back to `shell_exec` only when `proc_open` is unavailable). Uploaded files are validated by a MIME validator and cleaned up by `FileCleaner`. `PreConvertEvent`/`PostConvertEvent` allow custom processing around each conversion.

Three admin forms live under `/admin/config/content/doc_to_html/` — basic settings, LibreOffice settings (binary path, command, timeout) and a Test Wizard — all requiring the `administer doc to html settings` permission (marked `restrict access: true`); editors need `use doc to html widget` to use the field widget. Setup: install LibreOffice on the server, point the LibreOffice settings at the `soffice` binary, then add the DOC to HTML widget to a text field.

---

- Add the DOC to HTML widget to a long-text/CKEditor field.
- Upload a DOCX file and convert it to HTML in the edit form.
- Convert legacy DOC files to HTML.
- Configure the LibreOffice binary path and command.
- Set a conversion timeout (seconds) for LibreOffice.
- Run the Test Wizard to verify LibreOffice is reachable.
- Restrict conversion settings to administrators.
- Let editors use the widget with `use doc to html widget`.
- Validate uploaded file MIME types before conversion.
- Clean up temporary conversion files automatically.
- Override the body-extraction regex per conversion.
- React before conversion via `PreConvertEvent`.
- React after conversion via `PostConvertEvent`.
- Inject cleaned HTML directly into CKEditor 5.
- Detect the installed LibreOffice version.
- Enforce a hard kill on runaway LibreOffice processes.
- Limit the uploaded document file size.
- Trigger conversions from a Drush command.
- Store converted output under a configurable folder.
- Preview the converted markup before saving.
