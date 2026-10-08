<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Term Hierarchy By Language (thbl) makes the taxonomy term hierarchy — each term's parent and weight — vary per language, so translated vocabularies can have a different structure and ordering in each language. It depends on core content_translation and taxonomy.

---

The module provides a query manager and form helper that override how term parent/weight are read and stored, keying them by language. This lets the same translated terms be arranged into a different tree, or ordered differently, depending on the active language, rather than sharing one language-neutral hierarchy.

Use it on multilingual sites where category structures legitimately differ between languages (for example a menu-like vocabulary whose ordering or nesting should follow each locale's conventions). Configuration is through the standard taxonomy UI; the module alters the term forms and hierarchy queries via its services.

---

- Make taxonomy hierarchy language-aware.
- Store a different parent per language for a term.
- Order terms (weight) independently per language.
- Support locale-specific category structures.
- Keep translated vocabularies arranged per language.
- Let the same terms nest differently by locale.
- Override term parent/weight reads by language.
- Persist language-specific term ordering.
- Integrate with core content_translation.
- Alter term forms to capture per-language hierarchy.
- Drive language-aware trees via the query manager.
- Present locale-appropriate taxonomy navigation.
- Avoid a single shared language-neutral tree.
- Fit menu-like vocabularies with per-locale order.
- Reorder terms for each translation.
- Reflect cultural ordering conventions per language.
- Manage hierarchy through the standard taxonomy UI.
- Keep term translations structurally distinct.
