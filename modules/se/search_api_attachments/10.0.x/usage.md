Search API Attachments extracts the text content out of files attached to entities (file fields and media references) and feeds it to Search API so documents like PDFs, Office files and plain text become full-text searchable.

---

Search API Attachments adds a Search API processor (`file_attachments`) that, for every file field and file-datasource item on an index, exposes a per-field virtual `saa_<field_name>` property (plus a `saa_file_entity` property for `entity:file` datasources) you add to the index as a string field. At index time the processor loads the referenced files, checks each one against indexability rules (exists on disk, permanent, allowed MIME type, not excluded by extension, under the max filesize, private-file policy, and the `hook_search_api_attachments_indexable` hook), then runs the configured text extractor and stores the returned text on the field. Extraction is delegated to a pluggable `TextExtractor` plugin type: the module ships Tika App (JAR via `java`), Tika Server (HTTP), the Search API Solr backend extractor, `pdftotext`, a Python `pdf2txt` script, and `docconv`. You pick and configure exactly one extractor at **Admin → Configuration → Search → Search API Attachments** (`/admin/config/search/search_api_attachments`), which writes to the `search_api_attachments.admin_config` config object. Extracted text is cached (keyvalue or files backend) so re-indexing does not re-run extraction, and files whose extraction throws are pushed to a fallback queue (`search_api_attachments`) for a later retry via a queue worker. Per-field limits (number of files indexed, byte limit on extracted text, excluded extensions/MIME types, max filesize, exclude-private) are set on the processor's own settings; a `file_extracted_text` field formatter and a Views filter are also provided. It depends on Search API and core File/Media.

---

- Make uploaded PDFs full-text searchable in a Search API index.
- Index the text of Word/Excel/PowerPoint documents attached to nodes.
- Extract and index content of files referenced through Media entities.
- Index files attached to a dedicated `entity:file` datasource via the `saa_file_entity` property.
- Choose Apache Tika (App JAR) as the extraction engine and point it at `tika_path` / `java_path`.
- Use a running Tika Server over HTTP (host/port/scheme/timeout) instead of shelling out to a JAR.
- Reuse a Search API Solr backend's built-in extract handler to pull text from files.
- Extract PDF text with the `pdftotext` command line tool.
- Extract PDF text with a Python `pdf2txt.py` script.
- Extract office/document text with the `docconv` binary.
- Add a searchable "attachment content" string field to an index per file field (`saa_<field_name>`).
- Exclude binary/media file types from indexing via the excluded-extensions list (defaults cover images, audio, video).
- Cap how many files per file field get indexed (e.g. only the first attachment).
- Limit the size of extracted text stored/indexed (e.g. first 1 MB) to control index growth.
- Skip files larger than a configured maximum upload size.
- Exclude private-scheme files from being indexed.
- Read plain-text attachments directly with `file_get_contents` instead of invoking an extractor.
- Cache extracted text so re-indexing does not re-run costly extraction, and preserve the cache across cache clears.
- Store the extraction cache either in a keyvalue store or as files on a chosen scheme.
- Retry failed extractions automatically through the fallback queue and its queue worker.
- Prevent specific files from being indexed with `hook_search_api_attachments_indexable()`.
- React after a file's content is extracted (e.g. mark related entities for reindex) with `hook_search_api_attachments_content_extracted()`.
- Add a brand-new extraction backend by implementing the `TextExtractor` plugin type.
- Display the extracted text of a file field using the `file_extracted_text` field formatter.
- Filter/expose extracted-attachment content in a Views-based search with the provided filter plugin.
- Build a document search across an intranet of mixed file formats using one index.
- Deploy extractor and processor settings as configuration between environments.
- Gate who may configure extraction commands via the `administer search_api_attachments` permission.
