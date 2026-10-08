# Configuration

There are two places to configure Search API Attachments: the module's
**extractor settings** (which text‑extraction tool to use), and the **processor
settings** on your Search API index (how files are indexed). You need both for
attachment content to become searchable.

## 1. Choose and configure a text extractor

Go to **Configuration → Search → Search API Attachments**
(`/admin/config/search/search_api_attachments`). This form requires the
**Administer search_api_attachments** permission, and its values are stored as
exportable configuration. Nothing is extracted until you pick an extractor here.

- **Extraction method** — the single active extractor. The choices are:
  - **Tika App** — runs Apache Tika from a local JAR. Set the path to `java` and
    the path to the Tika JAR (and optionally a Tika config file and debug mode).
  - **Tika Server** — talks to a running Tika server over HTTP. Set the scheme,
    host, port, and timeout (defaults `http`, `localhost`, `9998`, `5` seconds).
  - **Solr** — reuses a Search API Solr server's built‑in extract handler. Select
    the Solr server (requires the Search API Solr module).
  - **pdftotext** — runs the `pdftotext` command. Set its path.
  - **Python pdf2txt** — runs a Python `pdf2txt` script. Set the path to `python`
    and to the script.
  - **docconv** — runs the `docconv` binary. Set its path.
- **Cache backend** — where extracted text is cached so re‑indexing does not
  re‑run extraction: a key/value store (default) or a files backend.
- **Cache file scheme** — the stream wrapper (default `private`) used when the
  files cache backend is selected.
- **Preserve cache** *(on by default)* — keep cached extractions across cache
  clears.
- **Read text files directly** *(off by default)* — for plain `text/*` files,
  read the content with `file_get_contents` instead of invoking the extractor.

## 2. Enable the processor and index the field

On your Search API index, open the **Processors** tab and enable **File
attachments**. This exposes one "attachment content" property per file field,
named `saa_<field_name>` (plus `saa_file_entity` for a file datasource). Add that
property under the index's **Fields**, then reindex so the extracted text is
included.

The **File attachments** processor has its own settings that limit what gets
indexed:

- **Excluded extensions** — a space‑separated list of file extensions to skip.
  The defaults cover images, audio, and video (`aif art avi bmp gif ico mov oga
  ogv png psd ra ram rgb flv`).
- **Number indexed** — the maximum number of files indexed per file field
  (default 0 = all of them).
- **Number of first bytes** — a cap on how much extracted text is stored and
  indexed per file (default 1 MB; 0 = no limit). Useful to control index growth.
- **Maximum filesize** — skip files larger than this (default 0 = no limit).
- **Exclude private files** *(on by default)* — do not index files stored under
  the private scheme.

A file is only indexed when it exists on disk, is permanent, has an allowed MIME
type, is under the size limit, passes the private‑file policy, and is not vetoed
by another module. Files whose extraction fails are logged and queued to a
fallback queue for a later retry — run cron (or the queue worker) to process
them.

## Permissions

Search API Attachments defines the **Administer search_api_attachments**
permission, which gates the extractor settings form. Grant it only to trusted
roles, since it controls which external commands the site runs for extraction.
