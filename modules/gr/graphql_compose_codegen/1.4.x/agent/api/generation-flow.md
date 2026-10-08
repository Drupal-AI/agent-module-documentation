<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generation flow & services

All services are in `graphql_compose_codegen.services.yml`. Nothing here is web-routed; the CLI commands
and the MCP submodule are the two entry points.

## `SchemaInspector` (`graphql_compose_codegen.schema_inspector`)
`\Drupal\graphql_compose_codegen\Service\SchemaInspector`. Reads node and paragraph bundles/fields and maps
them to GraphQL + TypeScript shapes.
- `getBundles($only)` / `getParagraphBundles($only)` — bundle info, filtered to what GraphQL Compose enables
  (`entity_config[bundle].enabled` **and** `query_load_enabled`) when its config is present. Reads both the
  2.x `graphql_compose.settings` and 3.x per-server `graphql_compose.settings.<id>` config via
  `getComposeConfig()`.
- `getFieldsForBundle($bundle, $skip)` / `getFieldsForParagraphBundle()` — extra fields only: strips
  `SKIP_BASE_FIELDS` / `SKIP_PARAGRAPH_BASE_FIELDS`, computed fields, `revision_*`/`content_translation_*`,
  the node `base_type_fields` config, and any GraphQL-Compose-disabled field. Output is `ksort`ed for
  deterministic generation. Each descriptor: `name`, `gql_name` (camelCase, `field_` stripped), `ts_type`,
  `drupal_type`, `cardinality`, `required`, `target_type`, `target_bundles`.
- Type naming: node → `Node<Bundle>` (GQL) / `Drupal<Bundle>` (TS); paragraph → `Paragraph<Bundle>` /
  `DrupalParagraph<Bundle>`. `mapFieldType()` delegates to the field-type mapper plugin manager.
- Paragraph specifics: `getParagraphFieldMap()` flags `child_only` bundles (only referenced by another
  bundle), and assigns collision-safe GraphQL response-key **aliases** (`assignResponseKey()` /
  `deriveParagraphAlias()`, e.g. `items` → `tabItems` → `tabGroupItems`) when two bundles select the same key
  with incompatible shapes (`buildMergeSignature()` — GraphQL SameResponseShape, one level deep). Nested
  paragraph refs become TS unions via `rewriteNestedParagraphTypes()`.

## `TypeScriptGenerator` (`graphql_compose_codegen.typescript_generator`)
`\Drupal\graphql_compose_codegen\Service\TypeScriptGenerator`. `buildArtefacts($bundles, $skipFields)` returns
`relative path => content`. `artefactSpecs()` drives node vs paragraph output; each entity type contributes a
types file, fragments file, renderer-cases file, and one component stub per bundle. A group is only emitted
when at least one of its bundles matches, so a node-only run never blanks paragraph files. Every artefact
opens with `FILE_BANNER` marking it a scaffold ("do NOT import or commit as-is"). Node types `extends` the
configured `base_ts_type`; webform fields append shared `DrupalWebform*` helper types. GraphQL field
selectors are chosen per resolved TS type in `getGqlSelector()` (e.g. `Image { url alt width height }`,
`Link { url title }`, `ProcessedText { processed }`).

## `ArtefactSnapshot` (`graphql_compose_codegen.artefact_snapshot`)
`\Drupal\graphql_compose_codegen\Service\ArtefactSnapshot`. State-backed (`StateInterface`, key
`STATE_KEY = graphql_compose_codegen.last_snapshot`) SHA-1 hashes of the last generation. `record()`,
`recordFromDisk()`, `load()`, `diff()` (added/removed/changed vs snapshot), `compareDisk()`
(missing/stale/extra vs disk). No filesystem dependency for the snapshot itself.

## `PathGuard` (`graphql_compose_codegen.path_guard`)
`\Drupal\graphql_compose_codegen\Service\PathGuard`, constructed with `%app.root%`. `validate($outputDir,
$allowExternal)` throws `\InvalidArgumentException` on: empty path, any `..` segment, or a resolved path equal
to a dangerous root (`/`, `/etc`, `/usr`, `/var`, `/tmp`, `/root`, `/home`, `/private`, incl. the macOS
`/private/...` form). Without `--allow-external` it also requires the path to sit inside the project root
(Drupal root's parent).

## `SchemaPreview` (`graphql_compose_codegen.schema_preview`)
`\Drupal\graphql_compose_codegen\Service\SchemaPreview`. Bounded, **read-only** facade wrapping the inspector,
generator, and snapshot for the MCP submodule. `run($operation, $bundles, $skipFields)` supports
`inspect|diff|preview`, validates selectors (`^[a-z][a-z0-9_]{0,63}$`, ≤64 bundles / ≤256 fields, unique),
and caps the schema (`MAX_BUNDLES=64`, `MAX_FIELDS_PER_BUNDLE=256`) and the JSON result
(`MAX_RESPONSE_BYTES=262144`), throwing rather than truncating. It never writes files, records a snapshot, or
invokes generation hooks.
