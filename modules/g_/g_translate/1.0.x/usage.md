<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GTranslate places a Google Translate widget on the site, offering machine translation of pages into many languages without translating any content in Drupal.

---

The appeal is obvious: one block, a hundred languages, no translation workflow, no cost, no content model changes. For some situations that is genuinely the right answer — a small organisation with an occasional non-English visitor, an internal tool, a site where the alternative is nothing at all. It is worth being clear about what it is and is not, because it is frequently proposed as an alternative to Drupal's translation system and it is not one. **The translation is not yours**: nothing is stored, reviewed or correctable, so a mistranslation of a legal statement, a medical instruction, a price or a safety notice is published in your name and cannot be fixed except by rewording the source. **It is not indexed**: search engines index the original, so machine-translated pages bring no multilingual search visibility, which is usually a main reason for wanting other languages. **It is a third-party script** that sees every page a visitor reads, which is a consent and data-protection question. And **it does not translate the parts that matter most** consistently — content in images, PDFs, form validation messages and anything rendered after page load. Version **1.0.1** on `^9.5` through `^12`, depending on core `block`, configured at `/admin/config/regional/g-translate`. Use it as a convenience layer on a monolingual site, and use core's translation system for languages the organisation actually commits to.

---

- Offer machine translation on a small site.
- Add many languages without a workflow.
- Help an occasional foreign-language visitor.
- Translate an internal tool.
- Provide a stopgap before real translation.
- Add a translation widget to a footer.
- Offer translation on a community site.
- Cover languages nobody maintains.
- Add translation with no content changes.
- Support a volunteer-run site.
- Provide basic accessibility across languages.
- Translate an archive nobody will localise.
- Add a language block quickly.
- Support an event's international visitors.
- Offer translation on a documentation site.
- Cover a long tail of languages.
- Provide translation without a budget.
- Add a widget alongside real translations.
