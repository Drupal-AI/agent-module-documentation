<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Alt-Text Validation

## Settings form
Route `alt_text_validation.setting` at `/admin/config/content/alt-text-validation`
(permission `administer alt text validation`). Config object `alt_text_validation.settings`:

| Key | Default | Meaning |
|---|---|---|
| `alt_text_validation_enabled` | `'1'` | Master switch for on-save validation. When `0`, rules are NOT enforced on save (report still works). |
| `cron_enabled` | `'1'` | Rebuild the audit report on cron. |
| `cron_delay` | `'7'` | Days between automatic cron rebuilds. |

## Rules (`alt_text_rule` config entity)
Managed at `/admin/config/content/alt-text-validation/rules`
(`entity.alt_text_rule.collection`, permission `administer alt text validation`). Each rule
(`AltTextRule`, `config_prefix: alt_text_rule`) exports:

- `id`, `label`
- `rule_type` — one of the types below.
- `content_char_limit` — integer, used by `length_limit`.
- `text_to_compare` — the comparison string / regex, used by the string/regex types.
- `violation_action` — `prevent` (block save), `warn` (message only), or `off` (disabled;
  excluded from loading — see `ValidationTools::getRules()` which filters `violation_action <> off`).
- `violation_message` — text shown to the editor and used as the report's rule label.

### Rule types (`AltTextRule::isViolation($filename, $alt, $title)`)
| `rule_type` | Violation when |
|---|---|
| `alt_is_filename` | `$alt === $filename` |
| `alt_is_title` | `$alt === $title` |
| `not_empty` | `$alt` is empty |
| `length_limit` | `strlen($alt) > content_char_limit` |
| `not_begin_with` | `$alt` starts with `text_to_compare` (case-insensitive) |
| `not_equal` | `$alt` equals `text_to_compare` (case-insensitive) |
| `not_contain` | `$alt` contains `text_to_compare` (case-insensitive) |
| `not_end_with` | `$alt` ends with `text_to_compare` (case-insensitive) |
| `regex_match` | `preg_match(text_to_compare, $alt)` matches — supply a full PCRE incl. delimiters |

### Shipped default rules (`config/install`, all `prevent`)
`no_empty_alt` (not_empty), `no_filenames` (alt_is_filename), `no_title_match` (alt_is_title),
`no_copyright` (not_contain "copyright"), `no_image_of` (not_begin_with "image of"),
`no_photo_of` (not_begin_with "photo of"). Adjust their action to `warn`/`off` as needed.

## The audit report
- View `alt_text_report` at **Reports » Alt Text Report** (`/admin/reports/alt-text-report`),
  permission `view alt text validation reports`. It reads the custom
  `alt_text_validation_audit` table, not entities, so it must be populated first.
- Populate it one of three ways:
  1. Cron — enable `cron_enabled`; rebuild runs on the schedule (`cron_delay` days).
  2. Batch — the report header has a "Rebuild the report" button →
     `/admin/reports/alt-text-report/rebuild` (`AltTextValidationAudit::batchProcess`,
     permission `view alt text validation reports`).
  3. Drush — `drush alt-text-validation:queue-audit` then run cron (see drush doc).
- The audit uses the Queue API (`atv_entity_types` → `atv_entity_instances`); large sites may
  need several cron runs. Progress + start/finish times show in the report header
  (`AtvSummary` area plugin, backed by State keys).
- CSV download comes from the `views_data_export` dependency (icon at the bottom of the View).
- Custom Views plugins: filters `AtvRuleFilter` (by rule) and `AtvColumnFieldFilter`
  (by column/field), header area `alt_text_validation_report_summary`.
