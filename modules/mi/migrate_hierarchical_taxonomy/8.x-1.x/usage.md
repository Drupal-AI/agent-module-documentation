<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Hierarchical Taxonomy provides migrate support for importing hierarchical taxonomy terms with unlimited nesting levels.

---

Migrate Hierarchical Taxonomy adds Migrate support for importing hierarchical taxonomy — terms with
parent/child relationships nested to unlimited depth — from a source into Drupal taxonomy vocabularies.
It fills a gap where flat term migration is easy but preserving deep hierarchy (categories with
sub-categories to many levels) needs extra handling. It depends on core Migrate, Migrate Plus and core
Taxonomy.

Use it in migration/import pipelines that must reproduce a nested category tree. It is a
developer/migration tool operating through the Migrate framework (typically Drush-driven), not a
runtime feature. Imported terms are content derived from the source; validate the source data. Define
the migration with this module's process/handling for the hierarchy.

---

- Migrate hierarchical taxonomy terms.
- Import unlimited nesting levels.
- Preserve parent/child term relationships.
- Reproduce a nested category tree.
- Depend on Migrate and Migrate Plus.
- Depend on core Taxonomy.
- Handle deep term hierarchy.
- Use in migration pipelines.
- Run via the Migrate framework.
- Import categories with subcategories.
- Validate source data.
- Define hierarchy handling.
- Migrate nested vocabularies.
- Import term trees.
- Support multi-level taxonomy.
- Use in Drush-driven migrations.
- Build category hierarchies.
- Reproduce term nesting.
- Import taxonomy structure.
- Handle unlimited depth.
