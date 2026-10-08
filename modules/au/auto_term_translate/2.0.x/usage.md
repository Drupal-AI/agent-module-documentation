Auto Taxonomy Term Translation adds Auto Node Translate's machine-translation workflow to taxonomy terms: an "Automatic Translation" tab on each term and a bulk form that translates an entire vocabulary at once.

---

Multilingual sites usually get their nodes translated but leave taxonomy terms — the tags, categories and product attributes that whole sections are filed under — until last, then translate them by hand through the standard content-translation UI. This module removes that chore. It is a thin sub-module of `auto_node_translate` (which it requires at `^3.0`) and reuses that module's configured translation provider, its `Translator` service and its provider plugin manager; it adds no translation backend of its own. On each taxonomy term it registers an "Automatic Translation" local task and entity operation pointing at `taxonomy/{taxonomy_term}/auto-translate-form`, where an editor ticks the target languages and the term's text, link and paragraph fields are translated into new (or overwritten) term translations. For whole vocabularies it adds an "Auto Translate" tab on the vocabulary overview leading to `/vocabulary/{vocabulary}/bulk-auto-translate-form`, which loads every term in the vocabulary and runs them through the Batch API, one term per batch step, saving each as a new revision logged as "Automatic translation using <api>".

Access follows core content translation rather than a single flat gate: the per-term route uses a custom access check (`AutoTermTranslateAccessCheck`) that defers to the entity type's `content_translation` access callback and only falls back to the per-bundle `auto translate …` permission, while the bulk form is gated by the module's own `use bulk auto translate` permission (marked restrict-access). Before either form runs it validates that a `default_api` is selected in `auto_node_translate.settings`, erroring out if the provider is unconfigured. Because single-word terms give a machine translator little context to disambiguate, treat the output as a first pass for human review rather than finished copy.

---

- Machine-translate a single taxonomy term into one or more site languages from its "Automatic Translation" tab.
- Translate an entire vocabulary in one operation from the vocabulary overview's "Auto Translate" tab.
- Fill in term translations left behind after a content migration or import.
- Bootstrap a newly added site language by bulk-translating all existing vocabularies.
- Translate product-attribute terms (size, colour, material) for a Commerce catalogue.
- Translate category and tag labels so a language switcher resolves every term.
- Reuse the translation provider already configured for Auto Node Translate (e.g. MyMemory) for terms too.
- Overwrite an existing term translation when the source term text has changed (per-term form flags each language as "new" or "overwrite").
- Create missing translations only for the languages an editor selects, leaving others untouched.
- Restrict bulk vocabulary translation to trusted editors via the restrict-access `use bulk auto translate` permission.
- Honour core content-translation access on the per-term route so only users who may translate a term can auto-translate it.
- Produce a first-pass draft translation of terms for a human translator to review and correct.
- Keep term translations in step after adding new terms to an already-translated vocabulary.
- Translate term description, link and referenced-paragraph fields, not just the name.
- Record each automatic translation as a new term revision with a clear revision-log message and author.
- Decide per vocabulary which term sets are safe to machine-translate versus which need human handling.
- Batch-process large vocabularies without a request timeout, one term per step with a progress bar.
- Give content teams a self-service term-translation workflow instead of exporting/importing translation files.
- Return the editor to the vocabulary overview (bulk) or the term page (single) after translating.
- Verify a translation provider is configured before allowing a translate run, with a clear error if not.
