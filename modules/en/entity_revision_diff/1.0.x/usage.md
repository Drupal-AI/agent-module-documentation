<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Revision Diff brings the Diff module's visual revision comparison — radio-select two revisions and see a unified/split/inline diff — to non-node revisionable entities: Block Content, Media, Taxonomy Term, and (optionally) Group.

---

Drupal 10.2+/11 core provides a version-history UI for these entities but only a plain list, and the Diff module wires its comparison in for nodes only. This module bridges the gap in `hook_entity_type_alter()` by attaching Diff 2.0's `DiffRouteProvider` and `revisions-diff`/`revision` link templates to each supported, revisionable entity type. A route subscriber (`EntityDiffRouteSubscriber`) replaces each entity's `version_history` route defaults with `EntityRevisionOverviewForm` (the list plus diff radios), a controller renders single-revision views, and `EntityRevisionRevertTranslationForm` handles translation-aware reverts. Group routes are added dynamically only when the group module is present (`GroupRouteProvider`).

Access is handled the Drupal way: every revision route carries an `_entity_access` requirement (view/update on the entity), and the module defines global and bundle-specific `view/revert/delete … revisions` permissions (static for block_content/media/taxonomy_term, dynamic via `EntityDiffPermissions` for bundles and for group). To use it, enable Diff and this module, grant the relevant revision permissions, and visit an entity's Revisions tab to compare revisions. A Views field for the current revision ID is also provided.

---

- Visually compare two revisions of a Media entity.
- Compare revisions of a Block Content (custom block) entity.
- Compare revisions of a Taxonomy Term.
- Compare revisions of a Group entity (when group module is installed).
- Select two revisions to diff via radio buttons on the revisions tab.
- View revisions in unified, split, or visual-inline layouts (Diff module).
- Revert a specific translation to an earlier revision.
- View a single revision's rendered output.
- Grant view/revert/delete revision access per entity type.
- Grant view/revert/delete revision access per bundle.
- Expose the current revision ID as a Views field.
- Audit what changed between two versions of non-node content.
- Provide editors revision diffs beyond core's plain list.
- Migrate from the deprecated entity_diff_ui module.
- Enforce access via entity view/update permissions on every route.