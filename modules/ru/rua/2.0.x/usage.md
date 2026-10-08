<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
RUA removes tonos accents from Greek text that CSS renders in uppercase, matching the Greek orthographic rule that capitalized words are written without their accent.

---

The whole module is one JS library and a three-line `hook_page_attachments` (`rua_page_attachments()` in `rua.module`) that attaches `rua/rua` to **every** page render — there is no config, route, permission, block or admin UI. The library (`js/jquery.rua.js`, declared in `rua.libraries.yml`, depends on `core/jquery` + `core/drupalSettings`) registers two custom jQuery pseudo-selectors, `:uppercase` (matches elements whose computed `text-transform` is `uppercase`) and `:smallcaps` (computed `font-variant` is `small-caps`), then on `$(document).ready` selects `$(":uppercase").not(".fieldset-legend")` and `$(":smallcaps").not(".fieldset-legend")` and runs `removeAcc()` over each match; the same passes are re-bound to `$(document).ajaxComplete(...)` so AJAX-inserted markup is corrected too. `removeAcc` reads the element's `innerHTML` (or `.value` for inputs), runs a fixed chain of `String.replace` swaps mapping each accented Greek vowel to its plain form (Ά→Α, ά→α, Έ→Ε, Ή→Η, Ί→Ι, Ό→Ο, Ύ→Υ, Ώ→Ω and the dialytika-tonos combinations ΐ→ϊ, ΰ→ϋ, plus a final-sigma ς→Σ swap), and writes the result back. Two consequences follow from it being a **client-side, presentation-only** transform: it never touches stored content, the search index, or what a bot sees — only the live DOM — and it leans on the browser's computed style, so it only fires where a stylesheet actually applies uppercasing. The more robust alternative, where you control markup, is a correct `lang="el"` attribute so the browser applies Greek casing rules itself; RUA is the blanket fallback for the many Drupal strings that lack it. Note the mapping is hardcoded to Greek and the module has no options to extend it without editing the JS.

---

- Fix accented Greek capitals in CSS-uppercased headings.
- Correct `text-transform: uppercase` headings on a Greek site.
- Strip the tonos from uppercase Greek navigation labels.
- Correct accents in uppercase buttons and CTAs.
- Fix `font-variant: small-caps` Greek text.
- Meet a Greek editorial / typographic standard automatically.
- Cover cases where `lang="el"` is missing per-string.
- Fix accents in an uppercase site name / logo text.
- Correct uppercase menu items site-wide.
- Fix accents in uppercase form labels and legends' siblings.
- Handle inconsistent browser Greek-uppercasing behavior.
- Apply the orthographic rule without editing content.
- Correct uppercase Greek titles in Views output.
- Re-correct AJAX-loaded uppercase Greek content.
- Polish a Greek-language deployment's typography.
- Fix accents in an uppercase banner or hero.
- Support Greek localisation quality without touching stored data.
- Keep the accent in the underlying copied text while fixing the display.
- Adapt the JS mapping as a starting point for another language's casing rules.
- Correct uppercase Greek breadcrumb and tab labels.
