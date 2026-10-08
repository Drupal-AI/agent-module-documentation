Migration Tools is a developer toolkit that layers helper classes, migrate process plugins, a DOM data parser and event subscribers on top of Migrate/Migrate Plus to make hard content migrations (especially scraping legacy HTML) more reliable.

---

The module "does nothing by itself" — it ships reusable building blocks you call from your own migration configs and custom code. It adds five `@MigrateProcessPlugin`s (`convert_boolean`, `create_default_paragraph_revision`, `gate_comparator`, `skip_on_not_empty`, `skip_on_substr`), a migrate_plus data parser plugin (`dom`) that walks HTML with QueryPath, and a `url_list` source plugin that reads a newline-delimited list of URLs. Its "Obtainer" framework (`ObtainTitle`, `ObtainDate`, `ObtainBody`, `ObtainImage`, `ObtainLink`, `ObtainTable`, and many more) extracts specific fields from inconsistent HTML, driven by a `Job` queue and run from `SourceParser\HtmlBase`. Two event subscribers hook Migrate Plus's `PREPARE_ROW` and `POST_ROW_SAVE` events to run DOM/source modifiers and to create redirects (via the required `redirect` module) as content is imported. A `Message` service emits progress/log output and dispatches a `migration_tools_message` event so you can capture migration logging. Static utility classes (`CheckFor`, `StringTools`, `Url`, `Media`, `Redirects`, `Operations`) cover common row checks, string cleanup, URL/redirect handling and unmanaged-file copying. An admin form at `/admin/content/migrate/migration_tools` (permission `administer site configuration`) toggles debug/Drush logging verbosity stored in `migration_tools.settings`. A bundled `migration_tools_example` submodule ships runnable example migrations. Obtainers require the QueryPath library (via the QueryPath module or a standalone install).

---

- Convert arbitrary source values (`yes`/`no`, `Y`/`N`, `1`/`0`) to booleans in a migration with the `convert_boolean` process plugin.
- Skip a migration row or a process step when a value is not empty using `skip_on_not_empty`.
- Skip a row or process based on a (case-sensitive) substring being present or absent with `skip_on_substr`.
- Pick between a source value and a backup value with the `gate_comparator` process plugin.
- Create default paragraph entity-reference revisions during import with `create_default_paragraph_revision`.
- Parse messy legacy HTML pages field-by-field using the `dom` migrate_plus data parser plugin.
- Migrate from a plain newline-delimited list of source URLs with the `url_list` source plugin.
- Extract a page title from inconsistent markup with `ObtainTitle` / `ObtainTitleNoCaseChange`.
- Pull a publication date (including Spanish-language dates) out of scraped HTML via `ObtainDate` / `ObtainDateSpanish`.
- Obtain body/subtitle/ID/city/state/country/location values from HTML with the matching `Obtain*` classes.
- Extract images, image files, links and link files from source pages with `ObtainImage`, `ObtainImageFile`, `ObtainLink`, `ObtainLinkFile`.
- Extract tabular data from HTML tables with `ObtainTable`.
- Write your own field extractor by subclassing `ObtainHtml` (see `Obtainer.api.php`).
- Queue several obtainers per field and run them in priority order with the `Job` / `SourceParser\HtmlBase` framework.
- Clean and normalise scraped strings (whitespace, encoding, casing) with `StringTools`.
- Run reusable row checks in `prepareRow` (empty fields, substrings, etc.) with `CheckFor`.
- Automatically create URL redirects for migrated content via the `PostRowSave` / `PrepareRow` subscribers and `Redirects`.
- Rewrite or strip markup in the source HTML before parsing with `DomModifier` / `SourceModifierHtml`.
- Capture structured migration logging by subscribing to the `migration_tools_message` event.
- Emit consistent terminal/watchdog messages during a migration run with the `Message` class.
- Copy unmanaged image/binary files from a source directory into `public://` during migration with `Media` / `Operations`.
- Tune migration debug verbosity and Drush debug/stop-on-error behaviour from the admin settings form.
- Learn the toolkit by enabling `migration_tools_example` and copying its example migration classes.
- Resolve, normalise and compare source/destination URLs with the `Url` helper.
