<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Hierarchical Taxonomy provides a Migrate process plugin (`hierarchical_taxonomy`) that walks an ordered list of source levels and looks up or creates a taxonomy term at each level, building a nested parent/child tree to unlimited depth and returning the deepest term's ID.

---

Migrate Hierarchical Taxonomy adds a single Migrate **process plugin**, `hierarchical_taxonomy`, for
importing nested taxonomy from tabular/structured source data where each row carries the full path of a
term (e.g. `Continent`, `Country`, `City`). The plugin takes an ordered `source` list of level values plus
a target `bundle` (vocabulary `vid`); for each non-empty level it loads the immediate children of the
current parent in that vocabulary, matches an existing sibling term by name (case sensitive, values are
trimmed), and when none matches it creates the term under the current parent via Migrate Plus's
`EntityGenerate`. The deepest resolved/created term ID is written to the destination field.

In release 2.0.x the class `Drupal\migrate_hierarchical_taxonomy\Plugin\migrate\process\HierarchicalTaxonomy`
extends `Drupal\migrate_plus\Plugin\migrate\process\EntityGenerate` and is declared with the PHP attribute
`#[MigrateProcess(id: 'hierarchical_taxonomy')]`. It requires core Migrate, core Taxonomy and Migrate Plus
(`>=6.0.6, <7.0`), core `^10.6 || ^11.4`, and PHP `>=8.2`. It is a developer/migration tool run through the
Migrate framework (typically Drush with `migrate_tools`); it has no admin UI, routes, permissions, services
of its own beyond the help hook, or configuration schema. The public process ID and migration configuration
keys are unchanged from the 8.x-1.x line — the major bump is a platform/signature modernization, not a
config change. Imported terms are content derived from the source, so validate source data before importing.

---

- Import hierarchical taxonomy terms with unlimited nesting depth.
- Build a parent/child term tree from an ordered list of source level values.
- Look up an existing term at each level before creating a new one.
- Create missing terms under the correct parent via Migrate Plus `EntityGenerate`.
- Return the deepest (leaf) term ID to the destination field.
- Migrate a `Continent > Country > City`-style path from one source row.
- Reproduce a nested category tree (categories with sub-categories).
- Populate an `entity_reference` taxonomy field (`field_x/target_id`) during a node migration.
- Reuse already-created branches across rows instead of duplicating terms.
- Match sibling terms by name within a single vocabulary (`bundle`).
- Skip empty levels in a row while still linking the levels that are present.
- Trim leading/trailing whitespace from source level values before matching.
- Drive the import from Drush with `migrate_tools` (`migrate:import`, `migrate:status`).
- Define the hierarchy mapping entirely in migration YAML — no custom PHP needed.
- Combine with other process plugins in a field's process pipeline.
- Target a specific vocabulary by its machine name via `bundle`.
- Handle stub rows the same creation/lookup path as full rows.
- Import a taxonomy structure exported from a legacy CMS as path columns.
- Migrate multi-level menu-like category data into taxonomy.
- Populate a product-category or document-topic tree during content migration.
- Keep term nesting consistent when re-running or updating a migration.
- Point the import at an arbitrary vocabulary depth without knowing it in advance.
- Avoid writing a bespoke source/destination plugin just to nest terms.
- Seed a taxonomy hierarchy as part of a larger content-migration group.
- Resolve each level relative to the previously resolved parent (contextual lookup).
