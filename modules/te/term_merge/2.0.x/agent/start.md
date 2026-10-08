<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Term Merge — agent index

Merges 2+ taxonomy terms **within one vocabulary** into a single term, migrating every
reference first (via the required `term_reference_change` module) and then **deleting** the
source terms. Destructive, no undo. No settings form, no configure route (`configure: null`),
no config schema, no Drush commands, no plugins.

- **The Merge wizard: routes, the 3 forms, tempstore keys, UI path** →
  [configure/merge-wizard.md](configure/merge-wizard.md)
- **Merge from code: the `term_merge.term_merger` service, its 2 methods, its exceptions, and
  the `'<field>' not found` reference-finder failure mode** →
  [api/term-merger-service.md](api/term-merger-service.md)
- **React to a merge: the `term_merge.terms_merged` event + `TermsMergedEvent`** →
  [extend/terms-merged-event.md](extend/terms-merged-event.md)
- **Who can merge: `merge taxonomy terms` AND the `_term_merge_access_check` second gate** →
  [permissions/merge-access.md](permissions/merge-access.md)

Key facts: service id `term_merge.term_merger` →
`mergeIntoNewTerm(array $terms, string $label): TermInterface` and
`mergeIntoTerm(array $terms, TermInterface $target): void`.
Event name constant `TermMergeEventNames::TERMS_MERGED` = `'term_merge.terms_merged'`.
Permission `merge taxonomy terms`. Merge form path
`/admin/structure/taxonomy/manage/{taxonomy_vocabulary}/merge`.
