<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig Typography exposes the PHP-Typography library as a Twig filter, applying the refinements a typesetter would: smart quotes, proper dashes, hyphenation, and preventing widows.

---

Web typography is full of small corrections that are individually invisible and collectively the difference between text that reads well and text that does not — straight quotes becoming typographic ones, hyphens becoming en and em dashes where they should, ligatures, non-breaking spaces before units, hyphenation points inserted so justified text does not open rivers, and a last word prevented from falling alone onto its own line. `mundschenk-at/php-typography ^6.0.0` implements all of it, and this module makes it available in templates as a filter, so a theme can apply typography where it matters — headings, pull quotes, body text — without touching stored content. That last point is the design advantage worth noting: applying it in Twig means the **stored text is unchanged**, so nothing is lost if the module is removed, and the same field can be rendered with or without typographic treatment in different contexts. It ships a `twig_typography_test` submodule and targets core `^10 || ^11`. Two practical notes: hyphenation is language-dependent and needs the right language set to be correct, and typographic substitution changes characters, so anything comparing rendered output against stored text will see a difference.

---

- Convert straight quotes to typographic quotes.
- Turn hyphens into en and em dashes.
- Prevent a widow on a heading.
- Add hyphenation points to justified text.
- Improve reading quality of body text.
- Apply typography in a Twig template.
- Keep stored content unchanged.
- Style pull quotes properly.
- Apply typographic rules per template.
- Improve a long-form reading experience.
- Handle language-specific hyphenation.
- Add non-breaking spaces before units.
- Improve print stylesheet output.
- Refine headings without editor effort.
- Apply typography to a specific field.
- Improve a magazine-style layout.
- Support a publisher's typographic standard.
- Render the same field with and without typography.
