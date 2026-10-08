<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Broken reference (broken_reference) — agent index

An admin diagnostic tool that scans every `entity_reference` and `entity_reference_revisions`
field on the site and reports which stored references point at deleted (non-existent) target
entities. Package `Broken reference`. **Core only** — no module dependencies. Core requirement
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.5. Read-only: it reports, it
never deletes or repairs.

- **The report form, the scan batch, the finder query, routes/permission, and how to operate it** →
  [reports/broken-references.md](reports/broken-references.md)

## What it actually is

- **One route** `broken_entity.form` at `/admin/config/development/broken_reference`
  (`broken_reference.routing.yml`), an `_admin_route`, gated by permission
  **`search broken entity references`** (`broken_reference.permissions.yml`, `restrict access: true`).
- **One menu link** `broken_entity.form` under `system.admin_reports` ("Reports"),
  `broken_reference.links.menu.yml`.
- **One permission** `search broken entity references`. No config objects, **no config schema**,
  no plugins, no Drush, no hooks, no entities, no submodules.

## Provided classes (all under `src/`)

- **`Form\BrokenReferenceForm`** (`_form` for the route, form id `broken_entity_form`) — renders
  the report table and the "Build report" submit that launches the scan batch.
- **`Utility\BrokenReferenceFinder`** (service `broken_reference.finder`) — discovers reference
  fields (`getReferenceFields()`) and runs the entity queries that find dangling references
  (`getQueryResults()`, `getBrokenReferenceTypes()`).
- **`Batch\BrokenReferenceBatch`** (static `batchRun` / `batchFinished`) — the Batch API callbacks
  that load referencing entities in chunks of 30 and record broken items.
- **`Controller\BrokenReferenceStoreController`** (service `broken_reference.store_controller`) —
  stores/reads/clears results in the **private tempstore** collection `broken_reference`
  (key `broken`). Despite the class name it is a storage helper, not a routed controller.

## Services (`broken_reference.services.yml`)

- `broken_reference.finder` — args `@entity_type.manager`, `@entity_field.manager`,
  `@entity_type.bundle.info`.
- `broken_reference.store_controller` — arg `@tempstore.private`.
