<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BLS reference filter & display blocks

## Text filter — `bible_filter` (`src/Plugin/Filter/BibleFilter.php`)
`@Filter(id = "bible_filter", title = "Bible references as popups", type = TYPE_TRANSFORM_REVERSIBLE)`.
Enable it on a text format (Administration → Text formats) to turn inline references into popups.
- `loadBooks()` collects every `bible_book` name/shortname/code (plus `Psalm` for `PS`) from the DB.
- `doProcess()` builds a regex `\b(book1|book2|...)[\s:]*\d+:\d+(-\d+)?\b` (book names `preg_quote`d)
  and replaces matches via `processReference()`.
- `processReference()` parses chapter/verse, loads the matching `bible_book` and the referenced
  `bible_verse` range, and builds the popup. **Verse popup text is escaped with `Html::escape()`.**
  If the current user has `view bible entity`, the reference becomes an `<a>` to the `bible.read`
  route; otherwise a non-linking `<span>`. Attaches library `bible/bible.filter`.

## Golden Verse block — `bible_golden_verse` (`src/Plugin/Block/GoldenVerseBlock.php`)
`@Block(id="bible_golden_verse", category="Bible")`. `blockForm()` lets an admin pin a Bible version
(or use the default). `getRandomVerse()` counts verses (`verse > 0`) for the Bible and loads one at a
random offset via `mt_rand`. `build()` returns theme `bible_golden_verse` with reference, verse text,
and a `bible.read` "See All…" URL anchored to `#vN`. `getCacheMaxAge()` is `0` (new verse each load).
Text is rendered through the Twig template (auto-escaped).

## Search block — `bible_search` (`src/Plugin/Block/BibleSearchBlock.php`)
`@Block(id="bible_search", category="Bible")`. Renders `BibleSearchForm` in compact mode; access =
`view bible entity`. See [../api/search.md](../api/search.md).
