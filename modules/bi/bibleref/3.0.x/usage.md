Bible reference provides Drupal field types for storing and displaying Bible verse citations, backed by a preinstalled taxonomy of Bible books.

---

The module ships two field types — `bible_reference` (simple: book, chapter, verse-from, verse-to, plus free-text "additional") and `bible_reference_complex` (adds a "chapter to" so a citation can span chapters). On install it creates a `bibleref_books` taxonomy vocabulary and populates it from `data/books.json` (66 books with per-chapter verse counts, plus a Hungarian translation set and content-translation support when `content_translation` is enabled). The editing widget is a cascading select-plus-number-inputs form: a book dropdown, then chapter / verse-from / verse-to / additional inputs whose enabled/required states are driven both by `#states` and by a JS behaviour (`bibleref-widget.js`) using a book→chapter→max-verse tree passed in `drupalSettings`. A configurable "required granularity" controls how deep a value must be filled (book, chapter, verse-from, verse-to). Display is handled by a formatter service (`BibleRefFormatter`) that assembles a localized reference string such as "Genesis 1.1", "Genesis 1,1-5", or "Genesis 1,1-2,4"; the exact template is chosen by `getFormat()` and can be altered through `hook_bibleref_format_data` / `hook_bibleref_format_verse`. It stores only integer book-term IDs and integers for chapters/verses (additional is a 50-char string), so references are queryable and index-backed rather than free text.

---

- Add a "verse of the day" or sermon-reference field to an Article or Basic page content type.
- Tag blog posts, devotionals, or news items with the scripture passage they discuss.
- Store a single canonical passage per node using the simple `bible_reference` field type.
- Store a passage that spans multiple chapters (e.g. "John 1,1-3,16") using the `bible_reference_complex` field type.
- Let editors pick a book from a dropdown that is prefilled with all 66 Bible books instead of typing free text.
- Constrain chapter/verse number inputs to a sensible 1–999 range via the widget.
- Enforce how complete a reference must be with the "Required granularity" widget setting (book only, up to book+chapter, up to verse-from, or up to verse-to).
- Capture supplementary verse lists (e.g. "10; 14-16") in the optional free-text "additional" input.
- Display multiple references per field (multi-value) on a single node.
- Render references as clean, human-readable citations on the node display via the default formatter.
- Show multilingual book names by translating the `bibleref_books` terms and relying on the formatter's per-language label lookup.
- Localize Bible book names automatically in Hungarian using the bundled `books.hu.json`.
- Reorder or rename Bible book terms in the vocabulary to match a specific translation or canon.
- Alter the printed citation format site-wide (e.g. suppress the verse) by implementing `hook_bibleref_format_data`.
- Alter just the verse portion of a citation by implementing `hook_bibleref_format_verse`.
- Build Views that filter or sort content by book term ID, chapter, and verse thanks to the indexed integer storage.
- Programmatically read a reference's parts via `getBook()`, `getChapter()`, `getVerseFrom()`, `getVerseTo()`, and `getAdditional()`.
- Get a formatted string in code with `$item->toString()` or the injected `bibleref.formater` service.
- Reference-integrity: because the book is stored as a taxonomy term ID, deleting/merging book terms is managed through normal taxonomy tooling.
- Support scripture indexes or "passages referenced" listings across a content library.
- Provide a scripture-citation field for church, ministry, study-guide, or theological-library sites.
- Restrict which granularity editors must supply per field instance (each field can have its own widget settings).
- Hide the "additional" input entirely by turning off the widget's "Additional field" setting.
