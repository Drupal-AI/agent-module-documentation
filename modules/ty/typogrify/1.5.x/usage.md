<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Typogrify adds automatic typographic refinements to text — smart quotes and dashes (SmartyPants), widow prevention, wrapped ampersands/caps/quotes, ligatures, fractions, arrows and more — as a **text-format filter** and as a **Twig filter**.

---

The module provides a single core text-format filter plugin (`id: typogrify`, type
`TYPE_TRANSFORM_IRREVERSIBLE`, weight 10) that you enable and configure per text format under
*Configuration → Content authoring → Text formats and editors*. Its `process()` applies, in
order and only when enabled, a set of refinements driven by the filter's settings:
`smartypants_enabled` (typographers' quotes/dashes via the bundled SmartyPants port, with a
`smartypants_hyphens` dash mode), `wrap_caps` (wrap runs of capitals in `<span class="caps">`),
`wrap_ampersand` (`<span class="amp">&</span>`), `widont_enabled` (insert a non-breaking space
so headings don't leave a single "widow" word), `wrap_initial_quotes`, `wrap_abbr` and
`wrap_numbers` (thin-space handling), `space_to_nbsp` (nbsp before `!?:;`, useful in French),
`space_hyphens` (stand-alone `-` → em dash), `hyphenate_shy` (`=` → soft hyphen), plus
character-conversion maps for `ligatures`, `arrows`, `fractions` and `quotes` (stored serialized
in config). It attaches a small CSS library (`typogrify/typogrify`) that styles the wrapper
spans (showy ampersand, small caps, hanging quotes). Settings are stored under
`filter.format.<format>` → `filters.typogrify.settings` and covered by
`config/schema/typogrify.schema.yml` (`filter_settings.typogrify`). A Twig extension adds a
`|typogrify` filter so themers can apply the same refinements to arbitrary template strings,
optionally scoped to specific options (`amp`, `widont`, `smartypants`, `caps`,
`initial_quotes`, `dash`). The static `Typogrify`, `SmartyPants` and `UnicodeConversion`
classes expose the underlying helpers for code. A migration alter maps the D6 `typogrify`
filter id on upgrade.

---

- Turn straight quotes and apostrophes into curly typographers' quotation marks site-wide.
- Convert `--`/`---` into proper en and em dashes in body copy.
- Prevent ugly single-word "widows" at the end of headings and paragraphs.
- Wrap ampersands in a styled span so `&` renders in an italic display face.
- Render runs of capital letters as small caps via a `caps` wrapper span.
- Add a Twig `|typogrify` filter to prettify a field or string in a template.
- Apply only smart quotes in a template with `{{ text|typogrify(['smartypants']) }}`.
- Apply only widow prevention to a heading with `{{ title|typogrify(['widont']) }}`.
- Insert non-breaking spaces before `!?:;` for correct French punctuation spacing.
- Replace stand-alone hyphens between spaces with em dashes.
- Wrap initial quotation marks so they can hang into the margin.
- Convert ASCII ligatures (e.g. `fi`, `fl`) to Unicode ligature glyphs.
- Convert ASCII arrows (`->`, `<-`) to Unicode arrow characters.
- Convert ASCII fractions (e.g. `1/2`) to Unicode fraction glyphs.
- Group digits in large numbers with thin spaces.
- Wrap abbreviations and add a thin space after the dots.
- Enable typographic refinements on a specific text format only (e.g. Full HTML).
- Combine with an editor so authored content is refined on output without changing storage.
- Style the ampersand/caps/quote wrappers with the bundled CSS library or your own.
- Provide consistent, professional typography across a publication without manual editing.
- Refine imported/migrated content on display, preserving the raw source in the database.
- Apply refinements to computed or Twig-rendered strings that never pass through a text format.
- Choose the dash convention (`--` = em dash, or `--`/`---` for en/em) via `smartypants_hyphens`.
- Selectively disable widow removal or caps wrapping per format via the filter settings.
