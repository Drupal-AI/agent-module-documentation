# Configure — the Merge terms operation

Enable with `drush en taxonomy_manager_merge` (pulls in Term Merge + Term Reference Change).
It has no settings form and defines no permissions or config.

## How it plugs in

`taxonomy_manager_merge.module` implements
`hook_form_taxonomy_manager_vocabulary_terms_form_alter()` to add a **Merge terms** submit
button to the Taxonomy Manager editor toolbar and attach its tree library. The button is only
shown to users with `edit terms in {vocabulary}`. It opens a modal via the AJAX callback
`MergeTermsForm::mergeTermsFormCallback()`.

## The merge form

Route `taxonomy_manager_merge.admin_vocabulary.merge_terms`
(`/admin/structure/taxonomy_manager/voc/{taxonomy_vocabulary}/mergeterms`, form
`taxonomy_manager_merge_form`). `MergeTermsForm` extends Term Merge's `MergeTerms`. Fields:

| Field | Purpose |
|---|---|
| `terms` | The selected source terms to merge (prefilled from the tree selection) |
| `new` | Type a brand-new term to merge into |
| `existing` | Or pick an existing target term (`entity_autocomplete`, handler `default:filter_existing_terms`, excludes the selected terms) |
| `add_child_terms_to_target` | Also move source terms' children onto the target |
| `terms_to_synonym` | Keep source term titles as synonyms of the target |

Validation requires exactly one of `new` / `existing`. On submit it writes `terms`, `target`,
`merge_children`, `terms_to_synonym` into the `term_merge` private tempstore and redirects to
`entity.taxonomy_vocabulary.merge_confirm` (Term Merge's confirm step, which performs the
delete + reference reassignment), carrying a `destination` back to the vocabulary editor.

Large-vocabulary safety: `getSelectedOrAllTermOptions()` loads all terms only when the
vocabulary has fewer than 1000 terms, otherwise just the selected ones.
