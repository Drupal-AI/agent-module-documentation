# Paragraphs Trimmed (paragraphs_trimmed) — agent index

A single **field formatter** for **Paragraphs** fields. It renders the referenced paragraphs
to HTML in a chosen view mode, then runs that HTML through core's Trimmed (`text_trimmed`)
formatter to cut it to a length — a summary/teaser of paragraphs output.

- **Type:** display formatter module. `package: Paragraphs`, `core_version_requirement: ^8 || ^9 || ^10 || ^11`.
- **Depends on:** `paragraphs`, `text`, `filter` (declared in `.info.yml`).
- **Provides:** one FieldFormatter plugin (`paragraphs_trimmed`), plus a reusable abstract base
  class. No routes, permissions, services, config schema, `.install`, or Drush commands.
- **Submodule:** `paragraphs_smart_trim` (nested), which uses the contrib Smart Trim formatter
  as the trimmer instead of core's.

## What it ships

| Thing | Id / name | File |
|---|---|---|
| Field formatter plugin | `paragraphs_trimmed` (label "Paragraphs Trimmed"), `field_types = {entity_reference_revisions}` | `src/Plugin/Field/FieldFormatter/ParagraphsTrimmedFormatter.php` |
| Abstract base formatter | extends `EntityReferenceRevisionsEntityFormatter`; subclasses only implement `getTrimFormatterType()` | `src/Plugin/Field/FieldFormatter/ParagraphsTrimmedFormatterBase.php` |
| Interface | `ParagraphsTrimmedFormatterInterface::getTrimFormatterType()` | `src/Plugin/ParagraphsTrimmedFormatterInterface.php` |

## How it works (one line each)

1. `getTrimFormatterType()` returns `text_trimmed`; the base creates that formatter in
   `create()` to borrow its default settings and its `settingsForm`/`viewElements`.
2. `viewElements()` renders the paragraphs via `parent::viewElements()`
   (EntityReferenceRevisionsEntityFormatter, the chosen view mode), then renders that to an HTML string.
3. The HTML is wrapped in a `field_item:text` typed-data list with the configured `format`, and
   handed to the `text_trimmed` formatter's `viewElements()` to produce the trimmed output.
4. If the optional `summary_field` setting names a field that has a value, that field is rendered
   instead and the trim path is skipped.

## Solution docs

- [Formatter: settings & selecting it on a display](configure/formatter.md) — the `paragraphs_trimmed`
  formatter, its settings (view mode, text format, trim length, summary field), and how to apply it.
