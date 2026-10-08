# Configuration

## Open the settings form

1. Log in as a user with the restricted **`file_extractor_administer_settings`**
   permission.
2. Go to **Configuration → Media → File Extractor**, or navigate directly to
   `/admin/config/media/file-extractor`.

## Choose an extraction method

At the top of the form, the **extraction method** select lists only the backends
whose requirements are actually met on your server (the tool is installed and, for
the CLI backends, `symfony/process` is present). When you pick one, the form uses
AJAX to show that backend's own configuration fields — typically the path to its
program:

| Method | Key settings you provide |
|--------|--------------------------|
| **pdftotext** | Path to the `pdftotext` binary (default `pdftotext`). PDFs only. |
| **docconv** | Path to `docd` (default `/usr/bin/docd`). |
| **Python pdf2txt** | Path to the Python interpreter (default `python`) and to the `pdf2txt.py` script (default `/usr/bin/pdf2txt.py`). PDFs only. |
| **Apache Tika (CLI)** | Path to `java` (default `java`), path to the Tika JAR, and an optional Tika config file. |
| **Tika server** | Scheme (http/https), host (default `localhost`), port (default `9998`), and a timeout (default 5s). |
| **Search API Solr** | The Solr server to use. |

The program paths come **only** from this form, which is why the permission is
restricted to trusted administrators.

## Extraction settings

Below the method, a shared **extraction settings** section controls what gets
extracted and how much is kept:

- **Excluded extensions** — a space-separated list of file extensions to skip
  entirely (default excludes image/audio/video types such as
  `aif art avi bmp gif ico mov oga ogv png psd ra ram rgb flv`). These are mapped
  to MIME types internally.
- **Maximum file size** — the largest file the module will attempt to extract
  (e.g. `50 MB`). Set to `0` for no limit. Useful to avoid chewing on huge uploads.
- **Exclude private files** — when on (the default), files stored under the
  `private://` scheme are skipped, for privacy.
- **Maximum extracted bytes** (number of first bytes) — a cap on how much text is
  stored and cached per file (default `1 MB`). Set to `0` for unlimited. Handy to
  keep the cache small when you only need the beginning of large documents.

Click **Save configuration** when done.

## Test your configuration

Before you trust the setup, use the **Test** form at
`/admin/config/media/file-extractor/test`. Submitting it runs your chosen method
against a bundled sample PDF (with permissive limits) and prints the extracted
text, or a warning if nothing came back. This is the quickest way to confirm the
program path is right and the backend actually works — including with any
`settings.php` config overrides you have in place.

## Show or index the extracted text

Once a method is working:

- **Display it on a page** — on the file/media field's *Manage display*, choose
  the **File Extractor: extracted text** formatter. The document's text renders
  inline. The formatter also lets you override the global extraction settings for
  that specific display (useful if on-page display should keep less text than
  search indexing).
- **Make it searchable** — add the computed `file_extractor_extracted_file` value
  (available on file entities) to a Search API index so the *contents* of
  attached documents become full-text searchable.

Extraction results are cached permanently (keyed by file and the relevant
settings) and automatically invalidated when the file or these settings change,
so displaying or indexing a document does not re-run the extractor each time.

## Command line

There are no Drush commands, but you can read or set the config directly:

```bash
drush cget file_extractor.settings
drush cset file_extractor.settings extraction_method pdftotext_extractor
```
