<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Compose Codegen is a Drush-powered scaffold generator that turns a GraphQL Compose content model into TypeScript types, GraphQL fragments, and React component stubs for a Next.js frontend.

---

GraphQL Compose Codegen inspects the node and paragraph bundles that GraphQL Compose exposes and generates ready-to-merge frontend scaffolding so a decoupled Next.js app stays in sync with the Drupal schema. Its `SchemaInspector` service reads bundle and field definitions, honours GraphQL Compose's own entity/field enablement config, and maps each Drupal field type to a TypeScript type through a pluggable set of field-type mapper plugins. The `TypeScriptGenerator` service then produces four kinds of artefact per run — a `types.generated.d.ts` type file, a `fragments.generated.ts` GraphQL fragment file, a `*-renderer-cases.generated.tsx` switch-case file, and one `*.generated.tsx` React component stub per bundle — for both node and paragraph bundles. Four Drush commands drive it: `gqcc:inspect` lists bundles and their extra fields, `gqcc:generate` writes the artefacts (to stdout or a directory), `gqcc:diff` compares the current schema to the last generation snapshot, and `gqcc:validate` checks that files on disk match the live schema and exits non-zero when they drift. When editors add or remove content types, paragraph types, or fields in the admin UI, hook implementations log dblog notices with the exact command to re-run. Output paths are checked by a `PathGuard` service that rejects `..` traversal and dangerous filesystem roots, and writes are idempotent. An optional submodule, `graphql_compose_codegen_mcp`, exposes read-only inspect/diff/preview operations as governed Tool API tools. Configuration lives in `graphql_compose_codegen.settings` (base TypeScript type name, shared base-type field list, and a default output directory).

---

- Scaffold TypeScript type definitions for every GraphQL Compose node bundle in one command.
- Scaffold TypeScript types for paragraph bundles alongside node bundles.
- Generate GraphQL inline fragments matching each bundle's exposed fields.
- Generate a `NodeRenderer` switch-case file mapping `__typename` to React components.
- Generate a `ParagraphRenderer` switch-case file for paragraph bundles.
- Generate one React component stub per node and paragraph bundle.
- Inspect the schema with `drush gqcc:inspect` to see each bundle's extra fields and their resolved TS types.
- Restrict a run to specific bundles with `--bundles=article,page`.
- Exclude shared base-type fields (title, path, body, …) from per-bundle output.
- Exclude extra fields ad-hoc with `--skip-fields`.
- Print the scaffold to stdout for review before writing anything to disk.
- Write the scaffold straight into a Next.js project with `--output-dir=../ui`.
- Preview writes without touching disk using `--dry-run`.
- Write to a location outside the project root deliberately with `--allow-external`.
- Keep regeneration churn-free thanks to idempotent, content-hash-aware writes.
- Detect schema drift in CI with `drush gqcc:validate --output-dir=../ui` (non-zero exit on mismatch).
- See what changed since the last generation with `drush gqcc:diff`.
- Get a dblog notice with the exact regenerate command whenever a bundle or field is added.
- Get a warning to clean up frontend code when a bundle or field is deleted.
- Map custom Drupal field types to TypeScript by registering a `FieldTypeMapper` plugin.
- Override a built-in field mapping with `hook_graphql_compose_codegen_field_type_mappers_alter()`.
- Hook into generation with `hook_graphql_compose_codegen_pre_generate()` / `post_generate()`.
- Automatically type Scheduler `publish_on` / `unpublish_on` and Smart Date fields.
- Scaffold a full `DrupalWebform` selection for webform reference fields.
- Configure the shared base TypeScript type name (default `NodeCommonFields`) from the admin UI.
- Expose read-only schema inspect/diff/preview to AI agents via the governed MCP Tool API submodule.
