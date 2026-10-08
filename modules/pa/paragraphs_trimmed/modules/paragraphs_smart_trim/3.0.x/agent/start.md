# Paragraphs Smart Trim (paragraphs_smart_trim) — agent index

Submodule of **Paragraphs Trimmed**. One **field formatter** for **Paragraphs** fields that
trims rendered paragraphs output using the contrib **Smart Trim** formatter as the trimmer
(word-based trimming, "more" link, suffix) instead of core's Trimmed formatter.

- **Type:** display formatter submodule. `package: Paragraphs`, `core_version_requirement: ^8 || ^9 || ^10 || ^11`.
- **Depends on:** `paragraphs`, `paragraphs_trimmed` (the parent base class), `smart_trim`.
- **Provides:** one FieldFormatter plugin (`paragraphs_smart_trim`) and a `hook_help`. No routes,
  permissions, services, config schema, `.install`, or Drush commands.

## What it ships

| Thing | Id / name | File |
|---|---|---|
| Field formatter plugin | `paragraphs_smart_trim` (label "Paragraphs Smart Trim"), `field_types = {entity_reference_revisions}` | `src/Plugin/Field/FieldFormatter/ParagraphsSmartTrimFormatter.php` |
| Help text | `help.page.paragraphs_smart_trim` | `paragraphs_smart_trim.module` |

## How it works (one line each)

1. Extends the parent's `ParagraphsTrimmedFormatterBase`; `getTrimFormatterType()` returns
   `smart_trim`, so the base borrows Smart Trim's default settings and settings form.
2. `viewElements()` renders the paragraphs via `parent::viewElements()` (chosen view mode),
   then runs the markup through a `#type => processed_text` render with the configured `format`.
3. That processed HTML is wrapped in a `field_item:text` list and handed to the `smart_trim`
   formatter's `viewElements()` to produce the trimmed output.
4. `defaultSettings()` adds `summary_handler => 'ignore'`; `settingsForm()` fixes that field to a
   hidden `value` element. The parent's `summary_field` override still applies.

## Solution docs

- [Formatter: settings & selecting it on a display](configure/formatter.md) — the
  `paragraphs_smart_trim` formatter, its settings (inherited parent + Smart Trim options), and
  how to apply it on Manage Display.
