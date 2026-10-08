<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reading & Multi-Read

`BibleController` (`src/Controller/BibleController.php`) serves the public reading UI. All routes in
`bible.routing.yml` require **`view bible entity`**. Bibles are addressed by **shortname**, not
numeric id.

## Routes → methods
- `bible.redirect` `/bible` → `redirectToDefault()` — 302 to the default Bible's overview
  (`getDefaultBible()` uses config `default_bible`, else first Bible, else 404).
- `bible.overview` `/bible/{bible}` → `overview()` — book list grouped into Old Testament /
  New Testament / Apocrypha, split after book codes `MAL` and `REV`. Theme `bible_book_list`.
- `bible.chapters` `/bible/{bible}/{book}` → `chapters()` — chapter picker (1..`chapters`).
  Theme `bible_chapter_list`. `{book}` regex `^(PS|[A-Z0-9]{3})$`.
- `bible.read` `/bible/{bible}/{book}/{chapter}` → `read()` — the chapter reader with prev/next
  navigation that crosses book boundaries and wraps circularly (`computeChapterNav()`).
  Theme `bible_read`. `{chapter}` = `\d+`, validated against the book's chapter count (404 otherwise).

The `{bible}` param regex `^[A-Z][A-Z0-9]{0,9}(_[A-Z][A-Z0-9]{0,9}){0,9}$` accepts either a single
shortname (`KJV`) or an underscore-joined **Multi-Read** key (`KJV_MAB`).

## Multi-Read
`resolveBibleParam()` splits the `{bible}` param on `_`, de-duplicates, and loads each Bible by
shortname; two or more → Multi-Read mode (`isMultiRead()`). `read()` then calls `getMultiVerses()`,
which loads the same chapter from every selected translation and returns per-verse rows with one
line per translation (colour class `bible-context-{0..6}`). A dedicated form
`BibleMultiReadForm` (route `bible.multiread`, theme `bible_multiread_form`) lets users pick which
translations to compare. `getMultiLegend()` builds the colour legend.

## Verse loading
`getVerses()` loads verses for the current book+chapter (entity query, `accessCheck(FALSE)`) and
returns `chapter`/`verse`/`text` arrays. Verse `text` is plain (no filter format) and is rendered
through Twig auto-escaping in the templates; no `|raw`. Book/version helper maps come from
`getBooks()`, `getBookList()`, `getVersions()`.

## Entity-route redirect
`canonicalRedirect()` (wired by the RouteSubscriber onto numeric `entity.bible.canonical`) 301s to
`bible.overview` for the Bible's shortname, keeping numeric entity URLs working without duplicating
content.

## Templates & libraries
`templates/bible-read.html.twig`, `bible-book-list`, `bible-chapter-list`, `bible-multiread-form`.
Libraries under `bible.libraries.yml` (`bible.read`, `bible.book_list`, `bible.chapter_list`,
`bible.multiread`) attached per page; JS/CSS under `js/` and `css/`.
