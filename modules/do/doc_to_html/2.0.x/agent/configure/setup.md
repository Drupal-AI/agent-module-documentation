<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# doc_to_html — setup & conversion

## Admin forms (`administer doc to html settings`, restricted)
- `/admin/config/content/doc_to_html/basic-settings` — `BasicSettings` (output folder, widget options).
- `/admin/config/content/doc_to_html/libreoffice-settings` — `LibreOfficeSettings` (`base_path_application`, `command`, `timeout_seconds`).
- `/admin/config/content/doc_to_html/test-wizard` — `TestWizard` to smoke-test conversion.

## Field widget
Add **DOC to HTML** widget (`Plugin/Field/FieldWidget/DocToHtmlWidget`) to a text (long/CKEditor 5) field. Editors need `use doc to html widget`. Uploads pass `DocToHtmlMimeValidator`.

## Conversion pipeline
`ConversionManager` → `CmdService::convertFile()` builds:
```
escapeshellcmd(<soffice>) --headless --convert-to html
  escapeshellarg(<source>) --outdir escapeshellarg(<dest>) 2>&1
```
Executed via `executeWithTimeout()` (`proc_open`, killed at `timeout_seconds`; `SIGTERM` then `SIGKILL`), falling back to `shell_exec` only when `proc_open` is missing. `MarkupService::parseConvertedHtml()` extracts/cleans the body (optional override regex + match index). `FileCleaner` removes temp artefacts.

## Events
`PreConvertEvent` / `PostConvertEvent` (`DocToHtmlEvents`) let subscribers adjust input/output around each conversion.

## Requirements
LibreOffice (`soffice`) must be installed on the server; a `hook_requirements` check and the Test Wizard verify availability.
