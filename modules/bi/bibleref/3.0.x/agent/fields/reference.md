<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bible reference field types, widgets, and formatter

## Install & enable

```bash
composer require drupal/bibleref
drush en bibleref -y
```

Only dependency is core **`taxonomy`**. `hook_install()` creates the **`bibleref_books`**
vocabulary and fills it with 66 book terms from `data/books.json`; if `content_translation` is
enabled it also turns on term translation and imports translations from `data/books.<lang>.json`
(ships `books.hu.json`). No permissions, no routes, no Drush commands, no configuration form.

## The two field types

Defined with the `#[FieldType]` attribute in `src/Plugin/Field/FieldType/`:

| Field type id | Class | Properties (columns) | Default widget | Default formatter |
|---|---|---|---|---|
| `bible_reference` | `BibleReference` | `book` (int, term ID, required), `chapter` (int), `verse_from` (int), `verse_to` (int), `verse_additional` (varchar 50) | `bible_reference_widget_default` | `bible_reference_formatter_default` |
| `bible_reference_complex` | `BibleReferenceComplex` (extends `BibleReference`) | above **+ `chapter_to`** (int) | `bible_reference_complex_widget` | `bible_reference_complex_formatter_default` |

- Property-name constants live on `BibleReferenceInterface` (`PROPERTY_BOOK` = `book`,
  `PROPERTY_CHAPTER` = `chapter`, `PROPERTY_VERSE_FROM` = `verse_from`, `PROPERTY_VERSE_TO` =
  `verse_to`, `PROPERTY_VERSE_ADDITIONAL` = `verse_additional`) and `BibleReferenceComplexInterface`
  (`PROPERTY_CHAPTER_TO` = `chapter_to`).
- `book` is defined both as an integer property and as a **computed `entity` reference** to a
  `taxonomy_term` (constraint `EntityType: taxonomy_term`); `setValue()` loads the term from the
  book ID, `getBook()` returns the term. `getSetting('target_type')` is hard-forced to
  `taxonomy_term`.
- `schema()` indexes `book` (`book_id`) and the full tuple (`ref`) so references are queryable.
- `toString()` → `bibleref.formater`->`format($this)`; `getVerse()` → `formatVerse($this)`.

Add a field via the UI: *Structure → (bundle) → Manage fields → Add field* → choose **"Bible
verse reference - Simple"** or **"- Complex"** (category *reference*). It is multi-value capable.

## Widget (`BibleReferenceDefaultWidget`, extends core `OptionsWidgetBase`)

`formElement()` builds:

- **Book** — `#type => select`, options from `termStorage()->loadTree('bibleref_books', 0, 1, TRUE)`
  (term labels, translated to the current language when a translation exists). A `data-bibleref-property="book"`
  attribute is added.
- **Chapter / Verse from / Verse to** — `#type => number`, min 1 (verses min 0), **max 999**.
- **Additional** — `#type => textfield`, `#maxlength => 50`, only shown when the widget setting
  `additional` is on.
- Each sub-element gets `#states` (from `getStates()`) so downstream inputs are disabled until the
  prerequisite is filled, and `required` states kick in per the `required_granularity` setting.
- Attaches library **`bibleref/bibleref-widget`** and passes `drupalSettings.biblerefTree` — a
  `term_id → { chapter → maxVerses }` tree built from each book term's `field_chapters` count and
  decoded `field_verses` JSON. `js/bibleref-widget.js` uses it to bound chapter/verse inputs client-side.

`massageFormValues()` skips items with no book, then `castValue()` casts book/chapter/verse-* to
`int` (empty → `NULL`) and keeps `verse_additional` as a string.

`BibleReferenceComplexWidget` extends it, inserts the **Chapter to** number input (weight 3) and
reworks `getStates()`/`massageFormValues()`/`castValue()` to include `chapter_to`.

### Widget settings (`defaultSettings()` + `settingsForm()`)

| Setting | Default | Meaning |
|---|---|---|
| `required_granularity` | `4` (verse-from) | How deep a value must be filled to count as required: `1` book, `2` book+chapter, `4` +verse-from, `8` +verse-to (the `GRANULARITY_*` constants). |
| `additional` | `TRUE` | Show the free-text "additional" verse input. |

Schema for these is `field.widget.settings.bible_reference_widget_default` in
`config/schema/bibleref.schema.yml` (`required_granularity` int, `additional` bool).
`settingsSummary()` prints the chosen granularity and whether additional references are on.

## Formatters

`BibleReferenceDefaultFormatter` and its subclass `BibleReferenceComplexFormatter` both do:

```php
$elements[$delta] = ['#markup' => $item->toString(), '#cache' => ['contexts' => ['languages']]];
```

so display is language-cached and delegated entirely to the formatter **service**.

## Formatter service (`BibleRefFormatter`, service id `bibleref.formater`)

Constructor autowires `module_handler`, `theme_manager`, `language_manager` (aliased to
`BibleRefFormatterInterface`).

- **`format(BibleReferenceInterface $item)`** — assembles args `:book` (translated term label via
  `getBookLabel()`), `:chapter`, `:verse` (from `formatVerse()`), and for complex items
  `:chapter_to` / `:verse_to`. `getFormat()` selects the template:
  - `:book :chapter,:verse-:verse_to` (same chapter range),
  - `:book :chapter,:verse-:chapter_to` (chapter span, no verse-to),
  - `:book :chapter,:verse-:chapter_to,:verse_to` (full chapter+verse span),
  - `:book :verse`, `:book :chapter :verse`, `:book :chapter`, or default `:book :chapter.:verse`.
  Fires `hook_bibleref_format_data` (module + theme alter), returns a `TranslatableMarkup`.
- **`formatVerse()`** — builds `:verse_from`, `:verse_to`, `:verse_additional`; picks
  `:verse_from`, `:verse_from - :verse_to`, and/or appends `; :verse_additional`; fires
  `hook_bibleref_format_verse`; returns a `TranslatableMarkup`. Empty when no verse data.

All substitutions use the `:` placeholder form, so values pass through core's placeholder
escaping.

## Altering the output (`bibleref.api.php`)

```php
function mymodule_bibleref_format_data(array &$args, array &$context) {
  // $args['format'] is the template string, $args['args'] the replacements,
  // $context['item'] the field item. E.g. drop the verse:
  if ($args['format'] === ':book :chapter.:verse') {
    $args['format'] = ':book :chapter';
  }
}

function mymodule_bibleref_format_verse(array &$args, array &$context) {
  // $args['format'] / $args['values'] for the verse part only.
  $args['format'] = ':verse_from';
}
```

## The book vocabulary & data

- **`bibleref_books`** vocabulary (`config/install/taxonomy.vocabulary.bibleref_books.yml`, name
  *"Bible book"*). Each term carries two locked core fields on install:
  `field_chapters` (integer, chapter count) and `field_verses` (string_long, JSON array of
  `{chapter, verses}` — the per-chapter verse ceilings used to build the widget tree).
- Source of truth is `data/books.json` (`abbr`, `book`, `chapters[]`); translations in
  `data/books.<lang>.json`. Reorder/rename terms through normal taxonomy admin to fit a canon or
  translation.

## Programmatic use

```php
$item = $node->get('field_passage')->first();
$book_term = $item->getBook();        // TermInterface
$chapter   = $item->getChapter();     // ?int
$from      = $item->getVerseFrom();   // ?int
$to        = $item->getVerseTo();     // ?int
$extra     = $item->getAdditional();  // ?string
$label     = (string) $item->toString();                 // "Genesis 1.1"
$svc       = \Drupal::service('bibleref.formater');
$label2    = (string) $svc->format($item);
```
