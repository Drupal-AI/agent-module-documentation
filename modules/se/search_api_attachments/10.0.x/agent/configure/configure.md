# Configure extraction & index attachment content

Two places to configure: the module's **extractor settings** (config object
`search_api_attachments.admin_config`) and the **processor settings** (stored on the Search
API index that enables the `file_attachments` processor).

## 1. Pick & configure a text extractor

Settings form: `/admin/config/search/search_api_attachments` (route
`search_api_attachments.admin_form`, permission `administer search_api_attachments`). Writes
to `search_api_attachments.admin_config`. One extractor is active at a time via
`extraction_method` (empty = none; nothing is extracted until set).

Config object keys (defaults from `config/install/search_api_attachments.admin_config.yml`):

| Key | Default | Meaning |
|---|---|---|
| `extraction_method` | `''` | Active extractor plugin id (see table below) |
| `cache_backend` | `search_api_attachments.cache_keyvalue` | Extraction cache service (`..._keyvalue` or `..._cache_files`) |
| `cache_file_scheme` | `private` | Stream scheme when using the files cache backend |
| `preserve_cache` | `true` | Keep cached extractions across cache clears |
| `read_text_files_directly` | `false` | For `text/*` files, use `file_get_contents` instead of the extractor |

Per-extractor config lives under `<plugin_id>_configuration`:

| Extractor plugin id | Key config |
|---|---|
| `tika_extractor` | `java_path` (default `java`), `tika_path` (JAR), `tika_config_path`, `debug_mode` |
| `tika_server_extractor` | `scheme` `http`, `host` `localhost`, `port` `9998`, `timeout` `5` |
| `solr_extractor` | `solr_server` (a Search API Solr server id; requires `search_api_solr`) |
| `pdftotext_extractor` | `pdftotext_path` (default `pdftotext`) |
| `python_pdf2txt_extractor` | `python_path` (`python`), `python_pdf2txt_script` (`/usr/bin/pdf2txt.py`) |
| `docconv_extractor` | `docconv_path` (`/usr/bin/docd`) |

Example (drush): `drush cset search_api_attachments.admin_config extraction_method tika_extractor`
then `drush cset search_api_attachments.admin_config tika_extractor_configuration.tika_path /opt/tika/tika-app.jar`.

## 2. Enable the processor & add the field to your index

On the Search API index → **Processors** tab, enable **File attachments**
(processor id `file_attachments`, stage `add_properties`). It exposes one string property per
file field: `saa_<field_name>` (prefix `saa_`), plus `saa_file_entity` for an `entity:file`
datasource. Add that property as a **Fields** entry to make it searchable, then reindex.

Processor settings (schema
`plugin.plugin_configuration.search_api_processor.file_attachments`):

| Key | Default | Meaning |
|---|---|---|
| `excluded_extensions` | `aif art avi bmp gif ico mov oga ogv png psd ra ram rgb flv` | Space-separated extensions skipped (mapped internally to MIME types) |
| `number_indexed` | `0` | Max files indexed per file field (0 = all) |
| `number_first_bytes` | `1 MB` | Byte cap on extracted text before indexing (0 = no limit) |
| `max_filesize` | `0` | Skip files larger than this (0 = no limit; e.g. `10 MB`) |
| `excluded_private` | `1` | Exclude private-scheme files |
| `excluded_mimes` | (derived) | MIME list computed from `excluded_extensions` on submit |

A file is indexed only if it exists on disk, is permanent, has an allowed MIME type, is under
`max_filesize`, passes the private-file policy, and no `hook_search_api_attachments_indexable`
returns FALSE. Extraction failures are logged and queued to the `search_api_attachments`
fallback queue for later retry (run cron / queue worker).
