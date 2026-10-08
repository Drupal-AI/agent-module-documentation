# File Extractor — manual setup guide

**File Extractor** (`file_extractor`) pulls the text content out of uploaded
files — PDFs, Word and Office documents, and more — so that text can be shown on
a page or fed into a search index. It does this through a set of pluggable
*extractor backends*: the `pdftotext` binary, Apache Tika (as a local JAR or a
running Tika server), docconv, a Python `pdf2txt` script, or a Search API Solr
server's extract handler. You pick one backend, point it at the right tool, and
File Extractor takes care of the rest.

Once configured, the module adds a computed "extracted text" value to every file
entity and a field formatter called **File Extractor: extracted text**. Add that
formatter to a file/media field's display and the document's text appears inline
alongside the download link. Or wire the computed field into
[Search API](https://www.drupal.org/project/search_api) to make the *contents* of
attached documents searchable, not just their filenames. Extraction results are
cached so re-rendering a document doesn't re-run the extractor every time.

The catch is that most backends rely on an **external program** being installed
on your server — `pdftotext`, a Java runtime plus the Tika JAR, docconv's `docd`,
or Python with pdfminer. File Extractor only appears to offer a backend when its
requirements are actually available, and the CLI backends run those programs
safely (arguments are passed as a list, never through a shell). A built-in
**Test** form lets you check your chosen method against a bundled sample PDF
before you rely on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, install the
   external extraction tools, and enable the module.
2. [Configuration](configuration/index.md) — choose an extraction method, set its
   tool paths and limits, and run the Test form.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → File Extractor**
(`/admin/config/media/file-extractor`), with a companion **Test** form at
`/admin/config/media/file-extractor/test`. Both are gated by the single,
restricted **`file_extractor_administer_settings`** permission — grant it only to
trusted administrators, because these settings control which local binaries the
site executes.
