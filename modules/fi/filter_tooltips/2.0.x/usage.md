<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Filter Tooltips adds tooltips to content by matching words against a taxonomy vocabulary: when a term name appears in the text, it is wrapped in a tooltip that reveals the term's description on hover or click. Matching can be automatic (all occurrences, with an optional limit) or manual via a CKEditor plugin.

---

- Drupal 9 or 10; uses core taxonomy/filter (no extra dependency declared).
- Enable with `drush en filter_tooltips`.
- Create a vocabulary whose terms have names (the trigger word) and descriptions (the tooltip text).
- At `admin/config/content/formats`, enable "Display tooltips in text" and pick the source vocabulary.
- Choose automatic replacement (with occurrence limit and excluded tags) or manual (CKEditor) insertion, and the trigger event (click/mouseover).

---

- Turn glossary terms into inline tooltips automatically.
- Show a term's description on hover or click.
- Pick which vocabulary supplies the tooltip terms.
- Limit how many occurrences per term get a tooltip.
- Exclude specified HTML tags (e.g. h1) from replacement.
- Insert tooltips manually with the CKEditor plugin.
- Choose the trigger event (click vs mouseover).
- Skip terms without a description.
- Avoid nesting tooltips inside existing links (`<a>` excluded).
- Localize tooltips using term language (langcode-aware term loading).
- Escape tooltip description output to prevent markup injection.
- Add cache tags/contexts from the source vocabulary.
- Build glossaries, jargon helpers, or definitions.
- Apply across any text format.
- Improve reader comprehension without extra clicks.
- Keep term content centrally editable as taxonomy.
