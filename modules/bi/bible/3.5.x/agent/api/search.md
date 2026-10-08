<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Verse search

Public search page `bible.search` `/bible/search` (`view bible entity`) →
`BibleSearchController::search()` renders the `BibleSearchForm` and attaches library `bible/bible.search`.
A compact `bible_search` block (`BibleSearchBlock`, `blockAccess` = `view bible entity`) renders the
same form with `compact => TRUE`.

## Form — `src/Form/BibleSearchForm.php`
GET form (`#method: 'get'`, no CSRF token — read-only search). Fields: `keys`, `bible` (select of
shortnames + `- All Bibles -` when >1), and on the full page `book`, `chapter`, `verse`. Results are
built during `buildForm()` when `?keys=` is present (`buildResults()` calls the search service and
themes `bible_search_results`); `InvalidArgumentException` from bad syntax becomes a friendly
message. Cache contexts key on the relevant `url.query_args`.

## Query parser — `BibleSearchQueryParser` (service `bible.search_query_parser`)
`parse()` → `{positive: [], negative: []}`. `tokenize()` respects double quotes (phrases) and treats
a leading `-` as exclusion; unbalanced quotes or a query with no positive term throws. Terms are
literal substrings; AND semantics.

## Search service — `BibleSearch` (`src/Service/BibleSearch.php`, service `bible.search`)
Injects `@database`, `@entity_type.manager`, the parser, the highlighter, `@pager.manager`,
`@config.factory`. `search($criteria)`:
- `resolveBibleIds()` — `'all'` → every Bible; NULL/empty → config `default_bible` (or first);
  numeric → by id; else by uppercase `shortname`.
- `resolveBookIds()` — validates a `CODE` or `CODE-CODE` range against regex `^(PS|[A-Z0-9]{3})(?:-(PS|[A-Z0-9]{3}))?$`,
  resolves to book ids within scope.
- `parseNumericRange()` — validates chapter/verse `N` or `N-M`.
- `buildBaseQuery()` — `db->select('bible_verse','v')` joined to `bible` and `bible_book`, excludes
  section rows (`verse > 0`, non-`*` linemark), filters bible/book/chapter/verse, and adds one
  `LIKE`/`NOT LIKE` on `v.search_text` per positive/negative term using
  **`$this->database->escapeLike($term)`** (parameterized — no string concatenation into SQL).
- Paged via `PagerManager` (15/page default). Each row yields a `/bible/{shortname}/{book}/{chapter}#vN`
  URL, plain `text`, and `highlighted_text`.

## Highlighter — `BibleSearchHighlighter` (service `bible.search_highlighter`)
`highlight($text, $positiveTerms)` normalizes then **`Html::escape()`s** the text first, wraps
matched terms in `<span class="searchkw">`, and returns `Markup::create()` — highlighting is applied
to already-escaped text, so result markup is safe. Depends on `bible.verse_text_normalizer`.

## Normalizer — `BibleVerseTextNormalizer` (service `bible.verse_text_normalizer`)
Produces the `search_text` copy of a verse (strips embedded Strong-number tags etc.) used for both
matching and highlighting, so tags don't interfere with keyword search.
