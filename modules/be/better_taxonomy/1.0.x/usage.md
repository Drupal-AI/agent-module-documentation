<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better Taxonomy augments Drupal core's taxonomy term overview page with name filtering, bulk term creation, and a "delete all terms" batch operation.

---

Better Taxonomy replaces the core per-vocabulary term overview form (route `entity.taxonomy_vocabulary.overview_form`, repointed to `/admin/structure/taxonomy/manage/{vocabulary}/list`) with an enhanced `ListForm` that embeds the unmodified core overview inside a wrapper. On top of core it adds: a text "contains" filter that reloads the page showing only terms whose name matches (`BTService::getSearchList()` via an entity query `LIKE`), an "Add multiple terms" form that parses a dash-indented multi-line textarea into a term hierarchy and creates it (`AddMultipleForm` + `BTService::addMultipleTerms()`), and a "Delete all terms" confirm form that deletes every term in the vocabulary through a Batch API process (`DeleteAllForm` + `DeleteAllBatch`). The "delete all" action link is surfaced in three places: the vocabulary collection operations dropdown (via an overridden `VocabularyOverrideListBuilder`), the vocabulary edit form actions (via `hook_form_taxonomy_vocabulary_form_alter`), and the overview page itself. The module defines no entities, no permissions, and no configuration — all access is delegated to core taxonomy permissions (`access taxonomy overview`, `administer taxonomy`, per-vocabulary create/delete permissions).

It is a pure UI/management enhancement in the Taxonomy package, depending only on core `taxonomy`. No external services, no API keys, no config forms.

---

- Filter a large vocabulary's terms by typing a substring into the overview "Filter" field.
- Quickly locate a specific term in a vocabulary with thousands of terms without paging.
- Create dozens of terms at once by pasting a newline-separated list into "Add multiple terms".
- Build a nested term hierarchy in one submission using single-dash-per-level indentation (e.g. `Plants`, `-Trees`, `--Oak`).
- Attach a whole batch of new terms under a chosen existing parent term via the cascading level selects.
- Seed a fresh vocabulary's initial taxonomy structure from an outline pasted as text.
- Empty a vocabulary of all its terms in one batch-processed action ("Delete all terms").
- Reset a test or staging vocabulary to zero terms before re-importing.
- Trigger "Delete all terms" from the vocabulary list (collection) operations dropdown.
- Trigger "Delete all terms" from the vocabulary edit page's action buttons.
- Trigger "Delete all terms" from within the enhanced term overview page.
- Keep using every core overview feature (drag-to-reorder, weights, per-term operations) since the core form is embedded unchanged.
- Restrict who can bulk-delete terms using core's `administer taxonomy` or per-vocabulary `delete terms in {vocabulary}` permission.
- Restrict bulk term creation using core's per-vocabulary term create access (route uses `_entity_create_access`).
- Manage editorial or publishing vocabularies with many hierarchical terms more efficiently.
- Maintain product-catalog category trees where terms are added and pruned frequently.
- Clean up classification systems with many nested terms.
- Give editors a faster term-management workflow without installing a full taxonomy-manager replacement.
- Enforce term name length automatically (bulk-add truncates each name to the vocabulary's name-field `max_length`).
- Sanitize pasted term names on bulk creation (names are stripped of tags before saving).
- Show term depth/level and parent columns in filtered search results for multi-level vocabularies.
- Operate entirely within the existing Structure → Taxonomy admin area with no new configuration to learn.
