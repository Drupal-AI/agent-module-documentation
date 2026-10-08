Taxonomy Manager Merge adds a "Merge terms" operation to the Taxonomy Manager tree UI, folding several selected duplicate terms into one target term and reassigning their references via the Term Merge module.

---

This submodule of Taxonomy Manager integrates the contrib **Term Merge** (`term_merge`) and **Term Reference Change** (`term_reference_change`) modules into the Taxonomy Manager tree editor. When enabled it uses `hook_form_FORM_ID_alter()` to add a **Merge terms** button to the vocabulary editor's toolbar (visible to users with `edit terms in {vid}`). Selecting two or more terms and clicking it opens a modal `MergeTermsForm` (extending Term Merge's `MergeTerms`) where you choose or type the target term the others should merge into. Options let you add the source terms' child terms to the target, and keep the source term titles as **synonyms** of the target. On submit it stores the selection and target in Term Merge's private tempstore and redirects to Term Merge's confirmation step, which performs the actual merge — deleting the source terms and, through Term Reference Change, reassigning every entity reference that pointed at them to the surviving target term. The form loads term options efficiently (all terms under a 1000-term limit, otherwise only the selected ones) to stay usable on large vocabularies. It has no config or permissions of its own; access is the same `edit terms in {vid}` permission used by the parent module.

---

- Add a "Merge terms" action to the Taxonomy Manager tree toolbar.
- Merge several duplicate terms (e.g. "GSoC", "Summer of Code") into one canonical term.
- Merge selected terms into a brand-new target term typed into the form.
- Merge selected terms into an existing term chosen via autocomplete.
- Reassign all entity references from the merged-away terms onto the surviving term.
- Delete the redundant source terms automatically as part of the merge.
- Keep the source terms' titles as synonyms of the target term.
- Optionally move the source terms' child terms onto the target term.
- Clean up a vocabulary that accumulated near-duplicate tags over time.
- Consolidate imported/legacy taxonomy terms after a content migration.
- Deduplicate free-tagging vocabularies where editors created variant spellings.
- Keep the merge workflow inside the same tree UI used for other term operations.
- Restrict merging to editors who already hold `edit terms in {vid}`.
- Stay performant on large vocabularies via the selected-vs-all term option limit.
- Route the merge through Term Merge's confirmation step for a reviewable action.
