<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TMGMT Export / Import JSON is a TMGMT file-format translator: it exports a translation job's source data to a JSON file for offline/external translation, then imports the translated JSON back into the job. It extends tmgmt_file's file-translator mechanism.

---

The plugin (built on tmgmt_file's format plugin base) serialises TMGMT job data to JSON on export and, on import, reads the uploaded file with file_get_contents and json_decode to map translated strings back onto the job's data items. JSON parsing is used (no XML/XXE surface). Import is performed by an authorised TMGMT user through the standard job UI, and the uploaded file path comes from Drupal's managed file handling.

Use it when translations are produced outside Drupal by a tool or vendor that works with JSON, giving a clean round-trip: export JSON, translate externally, import JSON. It adds a format option to the TMGMT File translator rather than a separate provider or any remote API.

---

- Export TMGMT job source data to JSON.
- Import translated JSON back into a job.
- Enable offline/external translation round-trips.
- Add a JSON format to the TMGMT File translator.
- Serialise job data items to JSON.
- Map translated strings onto data items on import.
- Work with vendors that consume JSON.
- Avoid any remote API dependency.
- Parse imported files with json_decode.
- Reuse tmgmt_file's file-translator flow.
- Support tool-based external translation.
- Keep translation data in a portable format.
- Drive export/import from the TMGMT job UI.
- Restrict import to authorised TMGMT users.
- Handle managed uploaded files safely.
- Provide a clean JSON translation interchange.
- Fit CI/localization pipelines.
- Skip human LSP integration entirely.
