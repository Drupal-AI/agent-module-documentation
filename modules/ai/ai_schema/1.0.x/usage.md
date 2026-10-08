<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Schema is a Drush-only tool that serialises a Drupal site's entity/field data model — bundles, fields, relationships, and physical SQL storage — into structured, LLM-friendly JSON files on disk.

---

AI Schema introspects every fieldable content entity type and bundle on the site and writes several machine-readable JSON artifacts: a full entity/field export, an entity relationship graph, a physical storage (table/column) map, a compact token-efficient model tuned for LLM context windows, generated SQL SELECT statements, and one combined file per entity bundle. Each field is annotated with a normalized type and an inferred semantic role (label, content, media, taxonomy, price, email, owner, etc.) so AI tools and external systems can reason about the model without crawling Drupal config. It has no admin UI, no routes, no permissions, and no runtime page output — all six exports run through Drush commands and write files under the project root (default `ai-schema/`). It supports Drupal 10 and 11 and requires Drush 12 or 13.

---

- Export the full entity/field model to `entity-export.json` for AI or documentation tooling.
- Produce a compact, token-efficient schema (`compact-model.json`) for ChatGPT/Claude context windows.
- Generate an entity relationship graph (`relation-graph.json`) of reference edges between bundles.
- Emit a physical storage map (`storage-map.json`) of tables and columns per bundle.
- Auto-generate ready-to-use SQL SELECT statements (`sql-queries.json`) with correct JOINs on field tables.
- Write one combined per-entity JSON file (`entities/<type>.<bundle>.json`) to narrow LLM context to a single bundle.
- Run everything at once with `drush aischema:export-all`.
- Feed the exported schema to an LLM so it can generate SQL without knowing Drupal internals.
- Document a site's content model for onboarding developers or auditors.
- Give BI/analytics tools a machine-readable map of Drupal's storage tables.
- Add semantic role hints (label/content/media/taxonomy/owner/price) to each field for better machine understanding.
- Normalize Drupal's many field types into a small set (string/text/integer/decimal/boolean/datetime/reference/file/image/list).
- Export to a custom directory by passing a path argument (e.g. `drush aischema:export-all /tmp/out`).
- Produce a smaller entity export by passing `--compact` to omit storage info.
- Support headless/JSON:API/GraphQL projects that need a schema description artifact.
- Build data pipelines that consume Drupal's structure as JSON.
- Regenerate exports after adding fields or entity types (clear caches, then re-run).
- Version or diff a site's data model over time by committing/exporting the JSON.
- Discover reference relationships (from/to bundle, field, multiplicity) programmatically.
- Map entity.bundle identifiers to their base, data, revision and field tables.
- Run individual exports (`aischema:relations`, `aischema:storage`, `aischema:compact`, `aischema:sql`, `aischema:per-entity`) when only one artifact is needed.
