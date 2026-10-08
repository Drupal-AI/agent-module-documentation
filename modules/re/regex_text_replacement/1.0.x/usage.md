<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Regex Text Replacement adds a text-format filter that applies regular-expression replacements to content at render time, configured as a list of `pattern||replacement` lines.

---

The use case is almost always inherited content. A migration brings in ten thousand nodes with a legacy domain in every link, or a tracking parameter on every image, or an old shortcode syntax nobody wants to update by hand. Editing the stored text is the honest fix and is sometimes impossible — the source is re-imported, or the change must be reversible, or nobody will approve a bulk update of the body field. A render-time filter handles those: the stored content is untouched and the output is corrected. Configuration is a textarea of lines, each `pattern||replacement`, with `(1)` style backreferences translated to `$1`; failures are logged rather than thrown, so a bad pattern degrades to no replacement instead of a white screen. Version **1.0.1** on `^9 || ^10 || ^11`, depending on core `filter`. Three cautions, all following from where the patterns come from — the text format settings, which need `administer filters`, already one of the most powerful permissions on a site. **Catastrophic backtracking** is the practical risk: a pattern that is fine on a paragraph can hang on a long node, and this runs on every render of every affected field. **Filter order matters**, because a replacement that inserts markup after the HTML-restricting filter has run inserts it unfiltered. And **regex on HTML** is famously fragile, so anchor the patterns tightly and test against the worst content on the site, not the best.

---

- Rewrite a legacy domain in imported links.
- Strip a tracking parameter from URLs.
- Convert an old shortcode syntax.
- Clean up migrated markup at render time.
- Fix a systematic typo across content.
- Rewrite image paths in body text.
- Normalise phone number formatting.
- Redact a pattern from displayed text.
- Update a URL without editing content.
- Apply a reversible content correction.
- Replace an obsolete product name.
- Fix broken markup from a migration.
- Rewrite internal links after a restructure.
- Add rel attributes to external links.
- Convert a plain URL into a link.
- Apply a temporary content fix.
- Correct output without a bulk update.
- Standardise a citation format.
