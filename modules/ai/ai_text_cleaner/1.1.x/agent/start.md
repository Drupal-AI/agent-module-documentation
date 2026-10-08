<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Text Cleaner (ai_text_cleaner) — agent index

A small, self-contained module that **deterministically** removes LLM/ChatGPT formatting quirks
from content-entity text on save — hidden characters, smart quotes, en/em dashes, ellipses, stray
asterisks, markdown headings. **It performs no AI/LLM call and has no module or composer
dependencies** (the "AI" in the name is descriptive of the input, not the mechanism). Package
`AI Tools`, core `^10 || ^11`, license GPL-2.0-or-later, version 1.1.0.

- **The filter, the presave hook, the settings form, the Drush command, and every cleanup regex** →
  [text-cleaning/cleaner.md](text-cleaning/cleaner.md)

## What it provides (from source)

- **Filter plugin** `ai_text_cleaner_filter` — `src/Plugin/Filter/AITextCleanerFilter.php`
  (`#[Filter(... type: TYPE_TRANSFORM_IRREVERSIBLE ...)]`). Its `process()` is a **no-op** (returns
  text unchanged); the plugin exists mainly to store, per input format, which cleanup options are
  enabled, and to host the static cleaning helpers.
- **`hook_entity_presave`** — `ai_text_cleaner.module`
  (`ai_text_cleaner_entity_presave()`) calls `AITextCleanerFilter::processEntityFields()` on every
  saved `ContentEntityInterface`, rewriting `value`/`summary` field properties in place and (outside
  CLI) showing a per-field status message.
- **Settings form** `AITextCleanerSettingsForm` — route `ai_text_cleaner.settings` at
  `/admin/config/content/ai-text-cleaner`, permission **`administer site configuration`**. Writes
  config object `ai_text_cleaner.settings` (`clean_plain_text_fields` bool + `plain_field_options`
  mapping). Config schema in `config/schema/`.
- **Drush command** `ai:text-clean` (alias `ai-text-clean`) —
  `src/Drush/Commands/AiTextCleanerCommands.php`. Bulk-processes nodes with `--types`, `--languages`,
  `--limit`, `--offset`, `--analysis` (dry-run, default TRUE); returns a `RowsOfFields` table of
  per-option counts.

No permissions of its own, no services.yml, no routes beyond the admin settings form, no
libraries, no submodules.

## Mechanism (from source)

- The real work is `AITextCleanerFilter::clean($text, $langcode, $options, &$stats)`: it merges
  options over `$defaultSettings`, then runs each enabled option's PCRE `preg_replace` pairs from the
  static `$optionsMap`, honoring per-replacement `not_lang` opt-outs (e.g. curly-quote normalization
  is skipped for `de`/`pl`).
- `processEntityFields()` picks the option set per field item: for a formatted item it reads
  `filter.format.<id>` → `filters.ai_text_cleaner_filter.settings`; for a format-less item it uses
  `ai_text_cleaner.settings.plain_field_options` **only if** `clean_plain_text_fields` is on.
- Cleaning happens **on save**, not on render, so stored values change but display output is not
  transformed a second time.

## Notes

- Only string `value`/`summary` properties are touched; other field properties and non-content
  entities are ignored.
- Options `remove_asterisks` and `remove_markdown_headings` default OFF; the rest default ON.
- The Drush command uses `accessCheck(FALSE)` to load all nodes (CLI maintenance context).
