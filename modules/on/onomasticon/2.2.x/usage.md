<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Onomasticon turns a taxonomy vocabulary into an automatic glossary: a text filter finds glossary terms in body text and wraps them in a tooltip (or other markup) carrying the term's definition, with a CKEditor button to mark passages that should be left alone.

---

The filter, `FilterOnomasticon`, parses the text into an HTML5 DOM (via `Masterminds\HTML5`) rather than running regexes over markup, walks the body's child nodes, and replaces matched glossary terms with the configured HTML tag — so replacements never happen inside an attribute or a tag name. Its settings, all per text format, are unusually rich: which **vocabulary** holds the glossary, which **field** holds the definition (defaults to the taxonomy description), whether to run the description through `check_markup()` (with an explicit warning in the UI that this "can lead to infinite loops and break your site if term descriptions contain other glossary terms"), the **HTML tag** to wrap matches in, a list of **disabled tags** to skip (anchors and the wrapping tag are added automatically), the **implementation** of the definition (noting that a `title`-attribute implementation strips tags, since HTML attributes cannot contain markup), tooltip **orientation** (above or below), and the mouse cursor. A CKEditor plugin (`OnomasticonExcludeCkeditorButton`, plus `onomasticon.ckeditor5.yml` for CKEditor 5) gives editors a button to mark text as excluded from glossary processing, backed by its own CSS in both the editor and the front end. The filter result carries a `taxonomy_term_list:{vocabulary}` cache tag, so editing a glossary term invalidates the rendered text automatically.

---

- Explain jargon automatically wherever it appears in content.
- Build a medical or legal glossary that annotates articles.
- Show a tooltip definition on hover for technical terms.
- Maintain definitions in taxonomy rather than in each article.
- Update a definition once and have every page follow.
- Let editors exclude a passage from glossary processing.
- Use a custom field for definitions instead of the term description.
- Choose which HTML tag wraps glossary matches.
- Skip replacement inside headings or code blocks.
- Position tooltips above or below the term.
- Change the mouse cursor over glossary terms.
- Run text filters on rich-text definitions.
- Avoid regex-based replacement breaking markup.
- Keep rendered text cached until the vocabulary changes.
- Provide accessible abbreviation markup for acronyms.
- Annotate policy documents with statutory definitions.
- Support several glossaries by using different text formats.
- Give editors a CKEditor button for exclusions.
- Help new readers with domain-specific vocabulary.
- Reduce repeated in-line explanations in articles.
