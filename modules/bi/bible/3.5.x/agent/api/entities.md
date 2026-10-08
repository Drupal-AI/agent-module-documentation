<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bible entities, fields, storage

Five content entity types, all `ContentEntityBase`, `admin_permission = "administer bible"`,
`base_table` = the entity id. Defined under `src/Entity/`.

## `bible` (`Bible.php`)
Base table `bible`. Entity keys id/label(`name`)/uuid/langcode. Fields: `id`, `name` (req),
`shortname` (req — uppercase abbreviation used in URLs, e.g. `KJV`), `langcode` (req, `language`),
`version`, `created`, `changed`. Links: collection `/admin/content/bible`, add `/bible/add`,
canonical `/bible/{bible}`, edit/delete. Handlers: `BibleListBuilder`, core add/edit form `BibleForm`,
core delete + delete-multiple.
- `getBooks()` — loads referencing `bible_book` entities.
- `preDelete()` — cascade: directly `DELETE`s rows from `bible_note`, `bible_verse`, `bible_book`
  for each deleted Bible (logged), so removing a translation removes all its content.

## `bible_book` (`BibleBook.php`)
Belongs to a Bible. Fields: `bible` (entity ref, req), `code` (3-char id like `GEN`; `PS` allowed),
`name`, `shortname`, `number` (position, drives OT/NT/Apocrypha grouping), `chapters` (count).
Its canonical route is **removed** by the RouteSubscriber (no standalone view).

## `bible_verse` (`BibleVerse.php`)
Base table `bible_verse`. Entity key label = `text`. Fields: `bible` + `book` (entity refs, req),
`chapter`/`verse` (unsigned int), `linemark` (string; `*` marks section headers, excluded from
search), `text` (`text_long`, `text_processing = 0` → **plain**, no filter format), `search_text`
(`string_long`, normalized copy for search), `superscription`, `subscription` (`text_long`).
- `preSave()` recomputes `search_text` from `text` via a `BibleVerseTextNormalizer`.
- Storage handler `BibleVerseStorageSchema` (see below).
- `baseFieldDefinitions()['search_text']` is installed by update hook `bible_update_10003`.

## `bible_concordance` (`BibleConcordance.php`)
Strong's concordance definitions: `name`, `content`, `concordance` (the canonical Strong code key),
`langcode`. Read only by the Strong lookup controller.

## `bible_note` (`BibleNote.php`)
User-authored notes: `user`, `bible`, `verse` refs, `title`, `body`, `public` (bool), `source`.
Surfaced by the `bible_notes` View.

## Storage schema — `BibleVerseStorageSchema.php`
Adds a **unique key** on `(bible, book, chapter, verse)` and a lookup index on `(bible, book, chapter)`
to the `bible_verse` table. The unique key is what lets the importer detect and skip duplicate verses.

## Routing — `src/Routing/RouteSubscriber.php`
`alterRoutes()`:
- Constrains `entity.bible.canonical` to numeric ids (`\d+`) and repoints it at
  `BibleController::canonicalRedirect` (301 → shortname overview), so the numeric entity route does
  not collide with the alpha shortname route `bible.overview` (`/bible/{bible}`). It relaxes the
  canonical route's access to `_access: TRUE` because the redirect target (`bible.overview`) enforces
  `view bible entity` itself; edit/delete form routes keep their admin permissions.
- Removes `entity.bible_book.canonical` entirely.

## Hooks — `src/Hook/BibleHooks.php` (OOP `#[Hook]`, autowired)
- `hook_page_attachments` — attaches library `bible/import` on the import route.
- `hook_theme` — declares templates: `bible`, `bible_book_list`, `bible_chapter_list`, `bible_read`,
  `bible_multiread_form`, `bible_golden_verse`, `bible_search_results`.
