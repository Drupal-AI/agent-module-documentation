<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
NBSP Filter is a text-format filter that manages non-breaking spaces at render time: it can strip every existing non-breaking space back to a normal space, then insert `&nbsp;` or narrow no-break spaces (U+202F) before and after configured characters — chiefly to keep punctuation from wrapping onto a new line the way French and Spanish typography require.

---

The module registers a single `@Filter` plugin (`nbsp_filter`, `TYPE_TRANSFORM_IRREVERSIBLE`) that you enable per text format at `/admin/config/content/formats`, alongside core filters. Its `process()` method runs up to five passes driven by five settings. `clean_all` (default on) first normalises all non-breaking spaces in the text — the `&nbsp;` entity, UTF-8 U+00A0, and the narrow/thin/hair/zero-width space code points — down to plain spaces, which is handy for cleaning content pasted from Word. Then `insert_before` (default `?!;:`) turns a space before those punctuation marks into `&nbsp;`, `insert_after` (default `¿¡`) turns a space after those marks into `&nbsp;`, and `insert_narrow_before`/`insert_narrow_after` (defaults `»` and `«`) turn whitespace around the guillemets into a narrow no-break space. Each character list is applied as a regex character class, so entries should be plain characters. Because it works as a filter rather than an editor plugin, the rules apply to all rendered content — migrated, API-submitted, and hand-typed alike — and settings are stored per format in `filter.format.<id>.filters.nbsp_filter`. The filter's weight in the format decides its order relative to other filters; since it only inserts space entities it is best placed late so its output is preserved. Core-only, no dependencies, no permissions, no drush.

---

- Add a non-breaking space before French punctuation (`? ! ; :`).
- Add a non-breaking space after inverted Spanish marks (`¿ ¡`).
- Insert narrow no-break spaces inside guillemets (`» «`).
- Strip stray non-breaking spaces pasted from Word.
- Normalise thin, hair, and zero-width spaces to plain spaces.
- Keep a number and its unit on the same line.
- Prevent a line break in a title before a colon.
- Apply typographic spacing rules at render time.
- Clean up spacing in imported/migrated content.
- Enforce a house style automatically across a format.
- Handle French typography correctly on a multilingual site.
- Set the punctuation list per text format.
- Turn insertion off but keep only the cleanup (`clean_all`).
- Cover API-submitted content the same as hand-typed.
- Reduce manual typographic correction for editors.
- Improve rendered text quality without an editor plugin.
- Configure the filter programmatically via `FilterFormat::setFilterConfig()`.
- Export the per-format settings through configuration management.
- Keep initials with a surname by adding a custom character to the list.
- Remove non-breaking spaces that defeat text wrapping.
