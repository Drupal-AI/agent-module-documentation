Configure the CSV delimiter and quoting character that DKAN's datastore importer uses when parsing uploaded CSV resources.

---

DKAN imports dataset resources into a datastore, but the core datastore importer hard-codes the CSV parsing options, so datasets that use semicolons, whitespace separators, or single-quote quoting fail to import cleanly. DKAN Datastore Import Tweak adds an administrative settings form at `/admin/dkan/parser-settings` (gated by the `administer site configuration` permission) that stores a `delimiter` and a `quote` value in the `dkan_datastore_import_tweak.parser_settings` config object. An event subscriber listens for DKAN's `ImportService::EVENT_CONFIGURE_PARSER` event and rewrites the parser configuration with those two values before each import runs, so every datastore CSV import site-wide uses the chosen delimiter and quote. The optional `dkan_datastore_mysql_import_tweak` submodule decorates DKAN's `dkan.datastore.service.factory.import` factory so the same delimiter setting is also applied to the faster MySQL `LOAD DATA` importer (`dkan_datastore_mysql_import`). The module ships no permissions, entities, or Drush commands of its own; it only provides the settings form, the config object, and the event subscriber.

---

- Import DKAN datastore CSV resources that use a semicolon (`;`) delimiter instead of a comma.
- Import whitespace-delimited datastore resources by selecting the whitespace delimiter option.
- Switch DKAN's datastore CSV parsing to use single-quote (`'`) quoting instead of double-quote.
- Fix DKAN datastore imports that misparse columns because the source CSV is not comma-separated.
- Set a site-wide CSV delimiter policy for all DKAN open-data dataset imports from one admin form.
- Apply the delimiter/quote choice automatically to every future datastore import without per-dataset configuration.
- Provide open-data publishers a way to onboard European-style semicolon CSV exports into DKAN.
- Keep the DKAN metastore/datastore workflow unchanged while adjusting only the low-level CSV parsing.
- Extend the delimiter setting to DKAN's MySQL `LOAD DATA` importer by enabling the `dkan_datastore_mysql_import_tweak` submodule.
- Speed up large datastore imports with `dkan_datastore_mysql_import` while still respecting the configured delimiter.
- Preserve tab-separated resource handling: TSV resources keep their tab delimiter even when a different delimiter is configured (MySQL importer path).
- Review or change the active parser settings from the DKAN admin menu (Parser settings link under Administration > DKAN).
- Standardize datastore imports across a multi-site open-data portal using shared configuration export.
- Ship the delimiter/quote settings between environments via Drupal configuration management (config object `dkan_datastore_import_tweak.parser_settings`).
- Troubleshoot "columns run together" datastore import problems by setting the correct delimiter.
- Support datasets exported from spreadsheets that quote fields with apostrophes.
- Roll the tweak out to only the datastore, without the MySQL importer, by leaving the submodule disabled.
- Integrate with an existing DKAN 4.x open-data installation as a lightweight add-on module.
- Audit which delimiter/quote is in effect by inspecting the exported configuration in version control.
- Restrict who can change datastore parsing options to site administrators holding `administer site configuration`.
- Serve as a reference example of subscribing to DKAN's `EVENT_CONFIGURE_PARSER` to customize import parsing.
