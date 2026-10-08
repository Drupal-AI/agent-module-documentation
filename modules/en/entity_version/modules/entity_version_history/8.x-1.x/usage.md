<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Version History adds a **"History" tab** to revisionable content entities whose bundle has a configured main version field, listing the distinct version numbers across the entity's revisions in a table with each revision's title, date and author.

---

This sub-module of Entity Version turns the stored `major.minor.patch` numbers into a browsable per-entity history. `hook_entity_type_alter()` loads every `entity_version.settings.*` config and, for each target entity type that is **revisionable and has a canonical link template**, adds an `entity-version-history` link template at `{canonical}/history`. `EntityVersionHistoryRouteSubscriber` then creates a route `entity.{entity_type}.entity_version_history` for each such type, and `HistoryLocalTask` (a local-task deriver + plugin) adds a **"History"** tab next to the entity's canonical view. The page is built by `EntityVersionHistoryController::historyOverview()`: it reads the main version field name from the bundle's `entity_version_settings` entity, runs a grouped query over the field's dedicated revision table to collect the **distinct** `major.minor.patch` values (keeping the highest revision id per version, in the entity's language), and renders a table with columns **Version, Title, Date, Created by**. Each row links to that revision (or to the entity itself for the current revision), shows the revision's short-format date and the revision author's username. Access is controlled by a custom access callback requiring the **`access entity version history`** permission and an existing version-settings mapping for the bundle; the tab only appears for revisionable entity types that have a canonical URL, and bundles without a configured main field are ignored. The module ships no configuration of its own — it relies entirely on the parent module's per-bundle settings.

---

- Show editors a "History" tab on a node listing every distinct version it has passed through.
- See at a glance which revision introduced version `2.0.0` versus `1.4.3`.
- Give reviewers the title, date and author for each version of a content item.
- Jump from a version row straight to that revision's view page.
- Provide a version-oriented audit trail alongside Drupal's raw revision list.
- Track how a policy or document evolved through its major/minor/patch numbers.
- Surface version history only for content types you have configured a main version field on.
- Restrict who can see version history with the `access entity version history` permission.
- Present history per translation (rows are filtered to the displayed language).
- Collapse many revisions that share a version number into a single row (distinct versions only).
- Add a lightweight change log without building a custom view.
- Let content teams confirm the current published version against past ones.
- Complement `entity_version_workflows` by visualising the versions its transitions produced.
- Give QA a quick way to verify version increments happened as expected across revisions.
- Show the most recent revision for each version (highest revision id per version).
- Offer a paged history table for entities with many revisions.
- Keep the history tab out of the way for entity types without canonical URLs or revisions.
