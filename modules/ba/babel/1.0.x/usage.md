Babel is a hub module that gathers every translatable Drupal UI string — code strings, configuration, and simple content entities — into one unified translation interface, without storing any translations itself.

---

Babel (installed 1.0.0-alpha11, an alpha release) extends core's Locale module so translators get a single page at `/admin/config/regional/babel/{language}` where they translate strings regardless of origin. Each translatable backend is handled by a pluggable "translation type" plugin: the built-in `locale` plugin bridges to the Locale module tables and the `config` plugin bridges to configuration storage; the `babel_content_entity`, `babel_menu_link_content`, and `babel_tmgmt` submodules add more. Babel reads source strings and writes translations straight back to those native backends — nothing is stored in Babel except a lightweight index (`babel_source`, `babel_source_instance`) plus per-string activation status and per-language manual-translation locks (`babel_source_lock`). Translators can curate which strings are "active" (exposed for translation/export), import/export translations as spreadsheets (xlsx/xls/ods/csv via a `data_transfer` plugin), and lock strings so manual work is never overwritten by imports or automated translators. The `babel_tmgmt` submodule feeds the curated, active, unlocked strings to TMGMT continuous jobs for machine/vendor translation.

---

- Give non-technical translators one page to translate all UI strings instead of hunting through Locale, config translation, and per-entity forms.
- Translate configuration strings that the core Locale UI does not expose (e.g. custom config, View labels, field labels).
- Translate code strings (`t()` output) collected by the Locale module through the same interface.
- Filter the translation list by language, translated/untranslated status, and a free-text "contains" search.
- Translate languages with more than two plural forms (Polish, Romanian, Arabic, etc.) with per-variant textareas.
- Curate a subset of strings for translation by activating/deactivating each source string, so admin-only strings never reach translators or exports.
- Lock a translation after manually editing it so file imports and automated translators cannot overwrite it; unlock to re-expose it.
- Export a language's active strings to a spreadsheet (`.xlsx`, `.xls`, `.ods`, `.csv`) for offline translation, with protected columns guarding the identifier/context.
- Import a translated spreadsheet back in, validated by a per-row 64-char source hash so edited/mismatched rows are rejected with warnings.
- Copy a source string into the translation field with one click to speed up near-identical translations.
- Translate custom menu link titles and descriptions (`babel_menu_link_content` submodule), limited to chosen menus.
- Translate simple content entities such as taxonomy terms or shortcuts (`babel_content_entity` submodule), limited to selected entity types and bundles.
- Send curated strings to TMGMT translation providers via the `babel` TMGMT source plugin (`babel_tmgmt` submodule), including continuous jobs processed on cron.
- Automatically create TMGMT continuous job items for every untranslated, active, unlocked string, and auto-remove them when a string is disabled or locked.
- Choose an export destination stream wrapper (default `public://babel`; set `private://` for restricted files) and an optional sanitized filename prefix.
- Extend Babel with custom translation-type plugins (`Plugin\Babel\TranslationType`) to translate any other string source.
- Extend export/import to new file formats with custom data-transfer plugins (`Plugin\Babel\DataTransfer`) implementing the exporter/importer interfaces.
- Alter discovered plugin definitions via `hook_babel_translation_type_info()` and `hook_babel_data_transfer_info()`.
- Reach the translation interface quickly from the admin toolbar's "Translate" tab (opens as a modal on the current page's language).
- Preserve translation placeholders (`@name`, `%value`, `!raw`) when sending strings to TMGMT, which escapes them for translators.
- Keep the Babel index in sync automatically as configuration and locale source strings are added, changed, or removed (event subscribers react to config CRUD and locale updates).
