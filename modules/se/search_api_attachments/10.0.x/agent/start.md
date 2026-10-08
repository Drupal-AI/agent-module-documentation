# search_api_attachments — agent start

Extracts text from file/media attachments and indexes it in Search API. A Search API
processor (`file_attachments`) adds a per-file-field `saa_<field_name>` string property to an
index; at index time it runs one configured **TextExtractor** plugin (Tika App/Server, Solr,
pdftotext, python pdf2txt, docconv) over the referenced files and caches the result.
Depends on `search_api` (+ core File/Media). Config UI:
**Admin → Config → Search → Search API Attachments** (`/admin/config/search/search_api_attachments`,
route `search_api_attachments.admin_form`).

- Pick an extractor, set extraction/cache options, enable the processor & index the field → [configure/configure.md](configure/configure.md)
- Add a new extraction backend (TextExtractor plugin type) → [plugins/plugins.md](plugins/plugins.md)
- Hooks to control indexability / react to extraction → [api/api.md](api/api.md)
