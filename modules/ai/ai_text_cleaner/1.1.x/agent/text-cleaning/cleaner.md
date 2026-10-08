<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cleaning text: filter, presave hook, settings, and Drush

## Install & enable

```bash
composer require drupal/ai_text_cleaner
drush en ai_text_cleaner -y
```

No dependencies (self-contained; uses only core `filter`/`node`). No AI provider or API key is
involved — cleaning is local PCRE.

## Two ways cleaning is applied

1. **Formatted fields** — enable the **AI Text Cleaner** filter on an input format at
   *Configuration → Text formats and editors*, and tick the cleanups you want. The per-format
   settings are stored under `filter.format.<id>` → `filters.ai_text_cleaner_filter.settings`.
2. **Plain (format-less) fields** — at `/admin/config/content/ai-text-cleaner` enable
   *Clean plain text fields* and tick options; stored in `ai_text_cleaner.settings`
   (`clean_plain_text_fields`, `plain_field_options`).

In both cases the actual mutation happens in `hook_entity_presave`
(`ai_text_cleaner_entity_presave()` → `AITextCleanerFilter::processEntityFields()`), which runs on
**every** content-entity save. The filter's `process()` method is a deliberate no-op — the text was
already cleaned when it was saved, so nothing is transformed again at render time. (Consequence: a
value cleaned once is stored cleaned; enabling the filter does not clean already-saved content until
it is re-saved or the Drush command is run.)

## The cleaner (`AITextCleanerFilter::clean`)

`clean(string $text, string $langcode, array $options = [], ?array &$stats = null): string`
merges `$options` over the static `$defaultSettings`, then, for each enabled option in
`$optionsMap`, runs its `preg_replace` pattern/replacement pairs (`@preg_replace(... $count)`),
accumulating replacement counts into `$stats`. A pair with a `not_lang` list is skipped when
`$langcode` is in it.

### Options, defaults, and regexes

| Option key | Default | Effect (PCRE) | Language opt-out |
|---|---|---|---|
| `remove_hidden_characters` | on | strip `U+200B/200C/200D` (zero-width) | — |
| `convert_non_breaking_spaces` | on | `U+00A0`,`U+202F` → space | — |
| `normalize_dashes` | on | `U+2013`,`U+2014` → `-` | — |
| `normalize_quotes` | on | `U+201C/201E` → `"`; `U+201D` → `"`; `U+2018/2019/201A/201B` → `'` | `"` rule: `de`,`pl`; `U+201D` rule: `fi`,`sv` |
| `normalize_guillemets` | on | `U+00AB`,`U+00BB` → `"` | `es`,`fr`,`it`,`ru` |
| `convert_ellipsis` | on | `U+2026` → `...` | — |
| `remove_trailing_whitespace` | on | strip `[ \t]+$` (multiline) and end-of-text | — |
| `remove_asterisks` | **off** | remove all `*` | — |
| `remove_markdown_headings` | **off** | strip leading `#{1,6}\s+` at line start | — |

`getDefaultSettings()` and `getOptionsMap()` are public static accessors so the settings form reuses
the same definitions.

## Per-item option resolution (`processEntityFields`)

For each non-empty field, for each delta item:
- `$format_id = $item->format ?? NULL`.
- If a format is set → load `filter.format.<id>` and use its `ai_text_cleaner_filter.settings` as the
  option set (empty array if the filter isn't configured there).
- Else if `clean_plain_text_fields` is on → use `plain_field_options`.
- Else → no options (nothing cleaned for that item).

Then `value` and `summary` string properties are cleaned; if the item changed, it is written back
with `$item->setValue()` and `$changed = TRUE`. Stats are aggregated flat (`$entity_stats`) and
nested (`$per_field_stats[field][delta][option] = count`). The entity is saved only when
`processEntityFields($entity, $save = TRUE, ...)` is called with `$save = TRUE` (the presave hook
passes FALSE — persistence is core's job during the same save).

`generateFieldStatsMessage()` builds the `field[delta]: option: n, ...` summary used by both the
presave status message and the Drush log.

## Drush: `ai:text-clean`

`AiTextCleanerCommands::clean()` (`src/Drush/Commands/AiTextCleanerCommands.php`):

```bash
# Dry run (default): report what would change for articles
drush ai:text-clean --types=article --analysis=TRUE

# Apply and save up to 50 nodes, all languages
drush ai:text-clean --offset=0 --limit=50 --analysis=FALSE

# Multiple types/languages
drush ai:text-clean --types=article,page --languages=en,de
```

- Options: `--types`, `--languages` (comma lists), `--limit` (0 = no limit), `--offset`,
  `--analysis` (bool via `FILTER_VALIDATE_BOOLEAN`, default TRUE).
- Queries nodes with `accessCheck(FALSE)` (CLI maintenance context), loads them, and processes each
  translation as its own row. `--analysis=TRUE` passes `$save = FALSE` (dry run); FALSE saves.
- Returns a `RowsOfFields` table: `nid`, `title` (truncated), `lang`, `status`
  (`Found`/`Updated`/blank), and a column per option with the replacement count.

## Operating notes

- Cleaning runs on **all** content entities on save; scope it by only enabling the filter on the
  formats you want, and by leaving *Clean plain text fields* off unless you intend site-wide
  plain-field cleaning.
- `remove_asterisks` deletes every `*`, and `remove_markdown_headings` deletes leading `#` markers —
  destructive for content that legitimately uses those characters; both default OFF.
- Because display isn't re-cleaned, run the Drush command (or re-save) to normalize pre-existing
  content after enabling an option.
