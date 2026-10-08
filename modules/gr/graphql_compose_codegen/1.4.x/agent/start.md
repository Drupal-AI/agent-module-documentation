<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Compose Codegen (graphql_compose_codegen) — agent index

Drush-powered scaffold generator: turns GraphQL Compose node/paragraph bundles into TypeScript types,
GraphQL fragments, `NodeRenderer`/`ParagraphRenderer` switch-cases, and per-bundle React component stubs
for a Next.js frontend. Version **1.4.x** (info `1.4.1`). Core `^10.6 || ^11.3`, PHP `>=8.1`.

- **Depends on:** `graphql_compose:graphql_compose` (composer: `drupal/graphql_compose ^2.1 || ^3.0`,
  `drush/drush ^12 || ^13`). Optional: paragraphs, webform (+ graphql_compose_webform), scheduler.
- **Submodule:** `graphql_compose_codegen_mcp` — governed read-only Tool API (see
  [../../modules/graphql_compose_codegen_mcp/1.4.x/agent/start.md](../../modules/graphql_compose_codegen_mcp/1.4.x/agent/start.md)).
- **Permission:** `administer graphql_compose_codegen` (restricted) gates the settings form only.
- **Config:** `graphql_compose_codegen.settings` (`base_ts_type`, `base_type_fields`, `output_dir`).
- **Nothing web-facing writes files** — file generation is Drush/CLI only.

Services (`graphql_compose_codegen.services.yml`):
- `SchemaInspector` — reads node/paragraph bundles + fields, honours GraphQL Compose enablement, maps types.
- `TypeScriptGenerator` — builds the artefact set (`buildArtefacts()`).
- `ArtefactSnapshot` — state-backed hashes of the last generation (powers diff/validate).
- `PathGuard` — validates `--output-dir` (rejects `..` and dangerous roots).
- `SchemaPreview` — bounded, read-only facade used by the MCP submodule.
- `FieldTypeMapperManager` — plugin manager for `Plugin/FieldTypeMapper` (attribute `#[FieldTypeMapper]`).

Solution docs:
- [agent/configure/settings.md](configure/settings.md) — settings form, config keys, schema, install/status checks.
- [agent/drush/commands.md](drush/commands.md) — `gqcc:inspect|generate|diff|validate`, options, exit codes.
- [agent/api/generation-flow.md](api/generation-flow.md) — services, artefact set, snapshot, path guard.
- [agent/plugins/field-type-mapper.md](plugins/field-type-mapper.md) — the field-type mapper plugin type.
- [agent/hooks/hooks.md](hooks/hooks.md) — generation lifecycle hooks + schema-change dblog notices.
