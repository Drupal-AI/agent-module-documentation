<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bible reference (bibleref) — agent index

Provides two **field types** for storing/displaying Bible verse citations, backed by a
preinstalled **`bibleref_books` taxonomy vocabulary**. Depends only on core **`taxonomy`**.
Core requirement `^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Version 3.0.1. No routes,
no permissions, no Drush, **no external service calls**.

- **Field types, widgets, formatters, the book vocabulary, install data, and the format hooks** →
  [fields/reference.md](fields/reference.md)

## What it actually is

- Two field-type plugins (`src/Plugin/Field/FieldType/`):
  - **`bible_reference`** — `BibleReference` (label *"Bible verse reference - Simple"*): properties
    `book` (int → taxonomy_term ID), `chapter`, `verse_from`, `verse_to` (ints), `verse_additional`
    (varchar 50). Default widget `bible_reference_widget_default`, default formatter
    `bible_reference_formatter_default`.
  - **`bible_reference_complex`** — `BibleReferenceComplex` extends the above and adds
    `chapter_to` (label *"...- Complex"*). Widget `bible_reference_complex_widget`, formatter
    `bible_reference_complex_formatter_default`.
- Two widgets (`src/Plugin/Field/FieldWidget/`): `BibleReferenceDefaultWidget` (extends core
  `OptionsWidgetBase`) and `BibleReferenceComplexWidget`. Book = `<select>` of `bibleref_books`
  terms; chapter/verse = `number` inputs (min 1/0, max 999); additional = optional textfield.
- Two formatters (`src/Plugin/Field/FieldFormatter/`): `BibleReferenceDefaultFormatter` and
  `BibleReferenceComplexFormatter`, both emit `#markup => $item->toString()`.
- One service **`bibleref.formater`** → `Drupal\bibleref\Formatter\BibleRefFormatter`
  (aliased to `BibleRefFormatterInterface`), which builds the citation string.
- Interfaces expose the property-name constants: `BibleReferenceInterface` (`PROPERTY_BOOK`,
  `PROPERTY_CHAPTER`, `PROPERTY_VERSE_FROM`, `PROPERTY_VERSE_TO`, `PROPERTY_VERSE_ADDITIONAL`) and
  `BibleReferenceComplexInterface` (`PROPERTY_CHAPTER_TO`).

## Install-time data (`bibleref.install`)

- `hook_install()` reads `data/books.json` (66 books, each with an `abbr`, `book` name, and a
  `chapters` array of `{chapter, verses}`) and creates a `bibleref_books` term per book, storing
  chapter count in `field_chapters` and the full chapter/verse JSON in `field_verses`. It loads
  `data/books.<langcode>.json` (ships `books.hu.json`) for term translations and, when
  `content_translation` is enabled, turns on translation for the vocabulary.
- Update hooks: `bibleref_update_8901` (rewrites field column schema), `bibleref_update_10101`
  (adds the `field_verses` string_long field to the vocabulary).

## Rendering mechanism (from source)

- `BibleRefFormatter::format()` builds args (`:book`, `:chapter`, `:verse`, and for complex
  `:chapter_to`/`:verse_to`), picks a template via `getFormat()` (e.g. `:book :chapter.:verse`,
  `:book :chapter,:verse-:verse_to`, `:book :chapter,:verse-:chapter_to,:verse_to`), fires the
  `bibleref_format_data` alter, and returns a `TranslatableMarkup`. `formatVerse()` similarly
  handles the verse range/additional part and fires `bibleref_format_verse`.
- `getBookLabel()` returns the (optionally translated) taxonomy term label. All placeholders use
  the `:` form, so values are escaped by core's placeholder handling.

## Config schema

- `config/schema/bibleref.schema.yml` defines `field.widget.settings.bible_reference_widget_default`
  (`required_granularity` int, `additional` bool). Install config creates the vocabulary, the
  `field_chapters`/`field_verses` field storage + instances, and the term form/view displays.

## Hooks it defines (`bibleref.api.php`)

- `hook_bibleref_format_data(&$args, &$context)` — alter the whole reference before formatting.
- `hook_bibleref_format_verse(&$args, &$context)` — alter just the verse portion.
