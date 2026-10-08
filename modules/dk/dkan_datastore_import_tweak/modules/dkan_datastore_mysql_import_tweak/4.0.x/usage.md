Extends the configured CSV delimiter to DKAN's fast MySQL LOAD DATA datastore importer.

---

DKAN can import datastore resources with a high-throughput MySQL `LOAD DATA` importer (`dkan_datastore_mysql_import`) rather than row-by-row PHP parsing, but that importer does not honour the delimiter chosen in DKAN Datastore Import Tweak's settings form. This submodule bridges the two: it decorates the `dkan.datastore.service.factory.import` service with a `MysqlImportFactory` that swaps in a custom `MysqlImport` importer class. That importer reads the `delimiter` value from the `dkan_datastore_import_tweak.parser_settings` config object when constructing the `LOAD DATA` statement, defaulting to a comma when unset and always using a literal tab for `text/tab-separated-values` resources. Enable it only when the site uses the MySQL importer; it depends on both `dkan_datastore_import_tweak` and `dkan:dkan_datastore_mysql_import`. It adds no config, permissions, or routes of its own — it reuses the parent module's settings.

---

- Make DKAN's MySQL `LOAD DATA` datastore imports respect a semicolon delimiter.
- Import large semicolon- or whitespace-delimited CSVs quickly via the MySQL importer path.
- Keep tab-separated resources importing correctly (forced tab delimiter) while other files use the configured delimiter.
- Combine the speed of `dkan_datastore_mysql_import` with the configurable parsing of the parent module.
- Apply a single site-wide delimiter policy across both the standard and MySQL datastore importers.
- Onboard European-style CSV exports into DKAN using the fast bulk-load importer.
- Avoid column misparsing on bulk MySQL imports of non-comma CSV files.
- Serve as a reference for decorating DKAN's import factory (`decorates: dkan.datastore.service.factory.import`).
- Override only the importer class while inheriting DKAN's schema generation and post-import cleanup.
- Roll out the delimiter tweak to MySQL imports without changing any DKAN core code.
- Enable/disable independently of the parent form module so the MySQL path is opt-in.
- Standardize bulk open-data ingestion across a multi-site DKAN portal.
- Troubleshoot MySQL datastore imports that split rows incorrectly by setting the right delimiter.
- Reuse the parent's `dkan_datastore_import_tweak.parser_settings` config with no additional setup.
- Support publishers whose spreadsheet exports use non-default delimiters at bulk-import scale.
