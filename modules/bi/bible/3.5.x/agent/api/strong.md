<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Strong concordance JSON lookup

Route `bible.strong_lookup` `GET /bible/strong/{code}` → `BibleStrongController::lookup()`
(`src/Controller/BibleStrongController.php`), permission **`view bible entity`**, `no_cache: TRUE`.
`{code}` regex: `^(?:[HhGg][0-9]{1,4}|[89][0-9]{4})$`.

## Code normalization — `StrongCodeNormalizer` (service `bible.strong_code_normalizer`)
`normalize($raw)` accepts canonical `H###`/`G###` (1–4 digits) and legacy numeric `8####` (→ Hebrew)
/ `9####` (→ Greek), returning a zero-padded canonical `H0430` / `G3056`, or NULL when invalid
(including code `0`). `toLegacy($canonical)` maps back to the `8####`/`9####` form (`H`→`8`, `G`→`9`).

## Response — `lookup()`
Optional query params: `translation` (default `KJVSN`, upper-cased), `langcode`, `limit` (clamped
1–200, default 50). It runs two parameterized `db->select()` queries:
- **definition** from `bible_concordance` where `concordance = {canonical}` (and `langcode` if given).
- **occurrences** from `bible_verse` joined to `bible_book` + `bible`, filtered to the translation
  shortname, matching verses whose `text__value` contains `<{canonical}>` or `<{legacy}>` using
  `escapeLike()` inside an OR group; ordered by book number / chapter / verse; count + ranged rows.

Returns JSON `{ code, definition: {name, content, langcode}|null, occurrenceCount, occurrences: [{id,
reference, text, translation}] }`. All inputs are bound query values or clamped ints; no string
concatenation into SQL, and JSON output is not HTML.
