<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Class `\Drupal\graphql_compose_codegen\Drush\Commands\CodegenCommands` (registered in
`drush.services.yml`, tag `drush.command`). Four commands. Bundles come from `SchemaInspector`, which only
lists bundles GraphQL Compose has enabled (`enabled` + `query_load_enabled`) when its config exists.

## `gqcc:inspect` (aliases `gqcc:i`, `graphql-compose-codegen:inspect`)
Lists every node and paragraph bundle with its GraphQL type, TypeScript type, and each **extra** field
(machine name, camelCase GQL name, resolved TS type, Drupal type, required flag). Paragraph bundles that are
only referenced by another bundle are flagged `nested-only`.
- `--bundles=platform,service` — restrict to listed bundle IDs.
- `--skip-fields=foo,bar` — extra field names to exclude.

## `gqcc:generate` (aliases `gqcc:gen`, `graphql-compose-codegen:generate`)
Builds the artefact set via `TypeScriptGenerator::buildArtefacts()` and either prints it (no output dir) or
writes it under `{output-dir}/generated/`.
- `--output-dir=../ui` — Next.js project root; falls back to config `output_dir`; relative paths resolve
  against `DRUPAL_ROOT`. Validated by `PathGuard::validate()` **before** any work.
- `--overwrite` — replace existing generated files (otherwise existing paths are skipped).
- `--bundles=`, `--skip-fields=` — same as inspect.
- `--dry-run` — log what would be written; touches nothing.
- `--allow-external` — permit an output dir outside the project root (still rejects `..` and dangerous roots).

Writes are idempotent: unchanged files are skipped, and a trailing `\n` is appended on write. After a real
write it records a snapshot from what actually landed on disk
(`ArtefactSnapshot::recordFromDisk()`). Fires `hook_graphql_compose_codegen_pre_generate` and
`…_post_generate` around the write.

Artefacts per run (node, and paragraph when the module is present):
`types.generated.d.ts`, `fragments.generated.ts`, `node-renderer-cases.generated.tsx`,
`components/<Bundle>.generated.tsx`, plus the `paragraphs/` equivalents.

## `gqcc:diff` (alias `graphql-compose-codegen:diff`)
Compares the current artefact set against the last generation snapshot (state key
`graphql_compose_codegen.last_snapshot`) and prints Added / Changed / Removed relative paths. Warns and
exits success if no snapshot exists yet. Read-only.

## `gqcc:validate` (alias `graphql-compose-codegen:validate`)
Compares files on disk under `{output-dir}/generated/` to the live schema via
`ArtefactSnapshot::compareDisk()` and prints `MISSING`/`STALE`/`EXTRA` paths.
- `--output-dir` is **required** (errors + `EXIT_FAILURE` if missing); also path-guarded.
- Returns `EXIT_FAILURE` when any file is missing or stale, `EXIT_SUCCESS` when in sync — wire it into CI or a
  pre-commit hook. (`EXTRA` files alone do not fail.)
