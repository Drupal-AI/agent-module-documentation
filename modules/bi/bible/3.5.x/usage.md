Import Bible Context (.bc) translation files into Drupal content entities and read, compare, search, and cross-reference scripture natively on the site.

---

The Bible module models scripture as four content entity types — `bible` (a translation), `bible_book`, `bible_verse`, and `bible_concordance` — plus a user `bible_note` entity. Administrators import a translation from an uploaded `.bc`/`.bc.txt` file or straight from a configured GitHub repository; a batch parser (`BibleParser` + `BibleBatchOperations`) bulk-inserts the Bible, its books, and all verses. Visitors then browse translations through clean shortname URLs (`/bible/KJV`, `/bible/KJV/GEN/1`), compare two or more translations side by side in Multi-Read (`/bible/KJV_MAB/...`), run keyword/phrase/exclusion searches scoped by translation, book, chapter, and verse (`/bible/search`, plus a compact search block), and turn inline references like "John 3:16" into hover popups with the BLS text filter. Extra display features include a random "Golden Verse" block and a JSON Strong-number concordance lookup endpoint (`/bible/strong/{code}`). All reading is gated by the `view bible entity` permission; importing and administration have their own permissions.

---

- Import a Bible translation by uploading a `.bc` or `.bc.txt` Bible Context file at `/admin/content/bible/import`.
- Install a translation directly from the configured GitHub repository (default `dieuwedeboer/bible-context`) via the download table on the import form.
- Read scripture on the site: a book overview at `/bible/{shortname}`, chapter picker at `/bible/{shortname}/{book}`, and chapter reader at `/bible/{shortname}/{book}/{chapter}`.
- Redirect visitors from a bare `/bible` link to the configured default translation's overview page.
- Set a site-wide default Bible translation and toggle Multi-Read name display at `/admin/structure/bible/bibles`.
- Compare two or more translations verse-by-verse in Multi-Read mode (`/bible/multiread` or `/bible/KJV_MAB/GEN/1`).
- Search verses by literal keyword across one translation or all translations at `/bible/search`.
- Combine multiple search terms with implicit AND, or match an exact phrase with double quotes ("in the beginning").
- Exclude words or phrases from a search with a leading minus (e.g. `light -darkness`).
- Restrict a search to a book code (`GEN`), a book range (`GEN-EXO`), a chapter or chapter range (`1-5`), and a verse or verse range (`1-10`).
- Place the compact Bible Search block in any region for a site-wide search entry point.
- Display a random verse on any page with the Daily Golden Verse block, optionally pinned to a chosen translation.
- Convert Bible references inside body text into linked hover popups by enabling the "Bible references as popups" filter on a text format.
- Look up a Strong's concordance code and its verse occurrences as JSON at `/bible/strong/H0430` (accepts canonical `H####`/`G####` and legacy `8####`/`9####` codes).
- Build custom listings of Bibles, verses, and notes using the bundled Views (`bible_books`, `bible_verses`, `bible_notes`).
- Let users record private or public notes against verses via the `bible_note` entity.
- Host multiple language translations side by side, each with its own langcode.
- Deep-link to an individual verse using the `#vN` anchor produced by search results and the Golden Verse block.
- Bulk-delete Bibles (with their books, verses, and notes cascaded automatically) from the admin content list.
- Re-import or update a translation safely: existing Bibles/books are reused and duplicate verses are skipped on conflict.
- Expose verse and book data to themers through dedicated Twig templates (`bible-read`, `bible-book-list`, `bible-search-results`, etc.).
