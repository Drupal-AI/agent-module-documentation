<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Term Glossary turns a taxonomy vocabulary into a glossary: as content is rendered, occurrences of your glossary terms are highlighted automatically, and readers can see each term's definition in a jQuery UI dialog, a Tippy.js tooltip, or a plain link. It also ships an A–Z "Glossary alphabetical" block for browsing and searching the glossary.

---

Highlighting runs at render time in a `preprocess_field` hook rather than a stored text-format filter, so field content is never modified in the database. You enable it per field on the *Manage display* screen (the eligible formatters are `text_default`, `text_trimmed`, and `string`), optionally overriding the global vocabulary for that field. Global behavior is configured at `/admin/config/glossary`: which vocabularies to use, whole-word and case-sensitive matching, match-once-per-field or per-content, synonyms drawn from a chosen field, per-term overrides, self-reference exclusion, a term view mode for the popup, JSON cache duration, and tags/classes to skip while scanning. Presentation is pluggable through a `TermGlossaryHandler` plugin type: core ships the jQuery UI dialog (`default`), `custom_js`, and `link` handlers, and the `term_glossary_abbr`, `term_glossary_tippy`, and `term_glossary_per_node` submodules add an `<abbr>` handler, Tippy.js tooltips, and per-node opt in/out respectively. The alphabetical block is backed by three JSON endpoints (search by letter, search by text, fetch by id) and a small JS layer that renders the definition on demand. Dependencies are core `taxonomy` and `text` plus `jquery_ui_dialog`. Integrators can reshape results and match markup through four alter hooks documented in `term_glossary.api.php`.

---

- Highlight glossary terms automatically in body text.
- Show a term's definition in a dialog when a reader clicks it.
- Present acronyms and jargon with inline definitions.
- Use Tippy.js tooltips instead of a modal dialog.
- Render matches as plain links to the term page.
- Build an A–Z glossary index/search page from a block.
- Search glossary terms by letter or by text from the front end.
- Let editors maintain definitions as ordinary taxonomy terms.
- Reuse an existing taxonomy vocabulary as a glossary.
- Drive a glossary from several vocabularies at once.
- Override the glossary vocabulary on a specific field.
- Match whole words only to avoid partial hits (e.g. "step" inside "step-by-step").
- Keep punctuation like hyphens from breaking word boundaries.
- Match case-sensitively when term casing matters.
- Link a term only once per field or once per whole page.
- Support synonyms so several spellings resolve to one term.
- Override match rules on individual terms with per-term fields.
- Avoid self-links when a term appears in its own description.
- Render the popup through a chosen term view mode.
- Exclude marked-up regions from scanning with the `glossary-exclude` class or ignored tags.
- Support multilingual glossaries, matching terms per language.
- Toggle glossary processing on individual nodes.
- Extend presentation with a custom handler plugin.
- Alter search results or generated match markup via hooks.
- Give a documentation or knowledge-base site inline definitions.
- Add a medical, legal, or technical terms glossary.
