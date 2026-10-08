<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

## Hooks this module invites (`graphql_compose_codegen.api.php`)
- `hook_graphql_compose_codegen_pre_generate(array $context)` — invoked by `gqcc:generate` before writing.
  `$context`: `bundles`, `paragraph_bundles`, `output_dir` (absolute, or '' for stdout), `overwrite`,
  `dry_run`.
- `hook_graphql_compose_codegen_post_generate(array $context)` — after writing; `$context` adds
  `artefacts` (relative path → content). Use it to regenerate downstream artefacts (e.g. OpenAPI).
- `hook_graphql_compose_codegen_field_type_mappers_alter(array &$definitions)` — alter discovered mapper
  plugin definitions (each has `drupalTypes`); e.g. reassign a Drupal type to another mapper. See
  [../plugins/field-type-mapper.md](../plugins/field-type-mapper.md).

## Hooks this module implements (`src/Hook/GraphqlComposeCodegenHooks.php`)
OOP hooks via `#[Hook(...)]`, bridged for D10 by legacy wrappers in `graphql_compose_codegen.module` /
`.install`. Service id `Drupal\graphql_compose_codegen\Hook\GraphqlComposeCodegenHooks`.
- `help` — help page (`help.page.graphql_compose_codegen`) summarising the four Drush commands.
- `runtime_requirements` — status-report warnings: no node bundles, and stale `base_type_fields`
  (see [../configure/settings.md](../configure/settings.md)).
- `entity_bundle_create` / `entity_bundle_delete` (node + paragraph) — log a dblog **notice** with the exact
  `drush gqcc:generate --bundles=<bundle> --output-dir=… --overwrite` on create, and a **warning** to remove
  the matching TS type / fragment / renderer case on delete.
- `field_config_insert` / `field_config_delete` (node + paragraph) — same pattern per field: a notice with
  the regenerate command on add, a warning to clean up references on removal.

These notices are informational logging only; they never run generation themselves.
