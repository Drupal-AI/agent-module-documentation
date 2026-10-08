<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import pipeline

Route `bible.import` → form `BibleImportForm` at `/admin/content/bible/import`, permission
**`administer bible imports`**. Two paths: local file upload and GitHub download.

## Bible Context (.bc) format — `BibleParser` (`src/Service/BibleParser.php`, service `bible.parser`)
Line-oriented, pipe-delimited. `processLine()` tracks a status set by section markers:
- `*Bible` / `*Chapter` / `*Context` set parse mode B / C / V (`^Context` also switches to V).
- Mode B data line `shortname|name|langcode|version` → the Bible record.
- Mode C data line `code|name|shortname|chapters` → a book (auto-numbered in file order).
- Mode V data line `book_code|chapter|verse|linemark|text` → a verse; a verse referencing an
  unknown book raises a per-line `BibleParseException` (collected in `stats['errors']`, parsing
  continues). Lines starting `#` are comments.
`parseFile()` detects encoding once (`detectFileEncoding()` samples first 8 KB; UTF-8 else
Windows-1252), strips a BOM, and requires bible+books+verses or throws. `validateFile()` scans the
first 100 lines for the three `*` markers. `getSupportedExtensions()` → `['bc', 'txt']`.

## Upload path — `BibleImportForm::submitForm()`
`validateForm()` checks the uploaded file's client extension against
`getSupportedExtensions()` + `sn`. `submitForm()` calls `file_save_upload('upload', ['file_validate_extensions' => ...])`,
marks the file permanent, then `startBatchImport($uri)`.

## GitHub path — `BibleImportForm::buildForm()` + `submitDownload()`
`buildForm()` reads config `bible.settings` → `importer.github_repository`, calls the GitHub
contents API (`https://api.github.com/repos/{repo}/contents`) via the injected `http_client_factory`,
and lists `*.bc.txt` files with an **Install** button per row. Bible display names come from
`BibleImportController::fetchName` (route `bible.import.fetch_name`, `administer bible imports`),
which fetches the first meaningful line of the raw file (`fetchAndParseFirstLine()`), caches it a
week, and only accepts URLs beginning `https://raw.githubusercontent.com/`. `submitDownload()`
starts the batch from the selected file's server-provided `download_url`.

## Batch — `BibleImportForm::startBatchImport()` + `BibleBatchOperations` (`src/Service/BibleBatchOperations.php`)
`prepareBatchOperations($parsed, 1000)` builds operations: create Bible, create books, then verse
chunks of 1000. Static callbacks:
- `createBible()` — reuses an existing Bible matching `shortname`+`langcode`, else creates one; stores
  its id in the batch context.
- `createBooks()` — transactional **bulk `INSERT`** into `bible_book` (generating uuids), skipping
  books that already exist; maps code → id in context.
- `createVerses()` — transactional bulk insert into `bible_verse` (`text__value`, `text__format = NULL`,
  and normalized `search_text`). On a `Duplicate entry` error it **rolls back and re-inserts row by
  row**, skipping duplicates (relying on the `(bible,book,chapter,verse)` unique key).
- `finished()` — reports created counts and any collected errors via Messenger.

After a successful import the form redirects to `entity.bible.collection`.
