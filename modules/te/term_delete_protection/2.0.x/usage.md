Taxonomy Term Delete Protection blocks deletion of taxonomy terms that are still referenced by content (and protects parent terms whose descendants are referenced), preserving referential integrity — configured per vocabulary and per referencing entity type.

---

Enable protection per vocabulary on the *vocabulary edit form* (*Structure → Taxonomy → edit*), which grows a "Term Delete Protection" section listing every content entity type that has an entity-reference field pointing at taxonomy terms (nodes always; Commerce products, paragraphs, and other custom types when present). The chosen entity types are saved into `term_delete_protection.settings` (`vocabularies[]` = `{vocabulary_id, protected_entity_types[]}`). The `TermReferenceChecker` service dynamically discovers taxonomy-reference fields via `EntityFieldManager` and queries whether a term — or any of its descendant terms (recursive `loadTree`, with loop guards) — is referenced by an enabled entity type; for paragraphs it verifies a valid parent entity. Protection is applied in four layers: a KernelEvents::REQUEST **event subscriber** intercepts the term delete-form route and redirects with an error if the term is referenced; `hook_entity_operation_alter` removes the *Delete* link from term listings; `hook_form_taxonomy_term_form_alter` removes the delete button and shows a warning listing the referencing content (grouped by entity type, linked, capped at 5 newest per term); and `hook_form_taxonomy_overview_terms_alter` highlights protected term rows. Requires core taxonomy/node/field; Commerce and Paragraphs support activate automatically when those modules are installed. No permissions, no Drush, no dedicated settings page (config lives on each vocabulary form).

---

- Prevent editors from deleting a taxonomy term that is still tagged on published or unpublished content.
- Preserve referential integrity so tagged nodes never lose their category.
- Protect terms referenced by Commerce products (when Commerce is installed).
- Protect terms referenced through paragraphs, resolving to the parent node/entity.
- Protect a parent term while any child/grandchild term is still in use.
- Enable protection only for chosen vocabularies, leaving others freely deletable.
- Choose which entity types count as references, per vocabulary.
- Show editors exactly which content is using a term before they try to delete it.
- Remove the Delete operation from the term overview for protected terms.
- Remove the delete button from a protected term's edit form.
- Block direct navigation to a term's delete-form URL for referenced terms.
- Highlight protected terms visually on the vocabulary overview page.
- Keep taxonomy hierarchies intact when reorganizing content.
- Avoid orphaned references and broken facets caused by deleting in-use terms.
- Support custom content entity types automatically if they have taxonomy reference fields.
- Programmatically check whether a term is referenced via the `term_delete_protection.reference_checker` service.
- Fetch the list of referencing entities for a term for custom reporting.
- Limit warning lists to the 5 most recent referencing items to avoid UI overload.
- Let protection follow content status changes (references are re-checked live).
- Combine per-vocabulary protection with editorial workflows to enforce cleanup order.
- Guard vocabularies used by menus/landing pages from accidental term removal.
- Reduce support tickets from broken content after taxonomy cleanups.
