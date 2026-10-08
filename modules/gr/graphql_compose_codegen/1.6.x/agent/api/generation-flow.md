<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generation flow & services

All services are in `graphql_compose_codegen.services.yml`. Nothing here is web-routed; the CLI commands
and the MCP submodule are the two entry points.

## `SchemaInspector` (`graphql_compose_codegen.schema_inspector`)
`\Drupal\graphql_compose_codegen\Service\SchemaInspector`. Reads node and paragraph bundles/fields and maps
them to GraphQL + TypeScript shapes. The public API is **parameterised by entity type** (`'node'` /
`'paragraph'`) — there are no separate node/paragraph twin methods. An `entityTypeSpecs()` table drives the
GQL/TS prefixes (`Node`/`Drupal`, `Paragraph`/`DrupalParagraph`), the skip list, and bundle sorting.
- `getBundlesFor($entityType, $only = [])` — bundle info, filtered to what GraphQL Compose enables
  (`entity_config.<type>` → per-bundle `enabled` **and** `query_load_enabled`) when its config is present.
  Reads both the 2.x `graphql_compose.settings` and 3.x per-server `graphql_compose.settings.<id>` config via
  `getComposeConfig()` (prefix-listing `graphql_compose.settings`). Paragraphs return empty if the module is
  absent.
- `getTypeName($entityType, $kind, $bundle)` — `$kind` is `'gql'` or `'ts'`; returns the prefixed PascalCase
  type name (e.g. node → `NodeArticle` / `DrupalArticle`).
- `getFieldsFor($entityType, $bundle, $additionalSkip = [])` — extra fields only: strips the entity-type skip
  list (`SKIP_BASE_FIELDS` / `SKIP_PARAGRAPH_BASE_FIELDS`), computed fields, `revision_*`/
  `content_translation_*`, the node `base_type_fields` config, and any GraphQL-Compose-disabled field
  (`field_config.<type>` → per-bundle per-field `enabled`). Output is `ksort`ed for deterministic generation.
  Each descriptor: `name`, `gql_name` (camelCase via `toGqlFieldName()`, `field_` stripped), `ts_type`,
  `drupal_type`, `cardinality`, `required`, `target_type`, `target_bundles`. For paragraphs it also runs
  `rewriteNestedParagraphTypes()` (nested paragraph refs → bundle-specific TS unions).
- `getComponentName($entityType, $bundle)` — React component name (node: `Drupal` prefix stripped;
  paragraph: `<Bundle>Paragraph`, via `getComponentNameForParagraph()`).
- `mapFieldType(FieldDefinitionInterface)` — delegates to the field-type mapper plugin manager.
- Paragraph specifics: `getParagraphFieldMap($only, $skip)` flags `child_only` bundles (only referenced by
  another bundle), and assigns collision-safe GraphQL response-key **aliases** (`assignResponseKey()` /
  `deriveParagraphAlias()`, e.g. `items` → `tabItems` → `tabGroupItems` → numbered suffix) when two bundles
  select the same key with incompatible shapes (`buildMergeSignature()` — GraphQL SameResponseShape, one level
  deep). Aliases are computed across every enabled bundle regardless of `$only`.

## `TypeScriptGenerator` (`graphql_compose_codegen.typescript_generator`)
`\Drupal\graphql_compose_codegen\Service\TypeScriptGenerator`. `buildArtefacts($bundles, $skipFields)` returns
`relative path => content`. A generate-time `artefactSpecs()` table drives node vs paragraph output; for each
spec it computes `typeEntries()` **once** and reuses that per-bundle map across the types file, fragments
file, renderer-cases file, and one component stub per bundle. A group is only emitted when at least one of its
bundles matches, so a node-only run never blanks paragraph files. Every artefact opens with `FILE_BANNER`
marking it a scaffold ("do NOT import or commit this file as-is"). Node types `extends` the configured
`base_ts_type`; webform fields append shared `DrupalWebform*` helper types. GraphQL field selectors are chosen
per resolved TS type in `getGqlSelector()` (e.g. `Image { url alt width height }`, `Link { url title }`,
`ProcessedText { processed }`).

## `ArtefactSnapshot` (`graphql_compose_codegen.artefact_snapshot`)
`\Drupal\graphql_compose_codegen\Service\ArtefactSnapshot`. State-backed (`StateInterface`, key
`STATE_KEY = graphql_compose_codegen.last_snapshot`) SHA-1 hashes of the last generation. `record()`,
`recordFromDisk()` (one trailing newline stripped to match generator content), `load()`, `diff()`
(added/removed/changed vs snapshot), `compareDisk()` (missing/stale/extra vs disk). No filesystem dependency
for the snapshot itself.

## `PathGuard` (`graphql_compose_codegen.path_guard`)
`\Drupal\graphql_compose_codegen\Service\PathGuard`, constructed with `%app.root%`. `validate($outputDir,
$allowExternal)` throws `\InvalidArgumentException` on: empty path, any `..` occurrence (rejected by
`str_contains($outputDir, '..')` before resolution), or a resolved path equal to a dangerous root (`/`,
`/etc`, `/usr`, `/var`, `/tmp`, `/root`, `/home`, plus the macOS `/private/...` form and `/private` itself).
Without `--allow-external` it also requires the resolved path to sit inside the project root (Drupal root's
parent). Non-existent targets fall back to `lexicalNormalise()`, which strips empty/`.` segments only — `..`
is already rejected upfront, so the normaliser no longer handles it.

## `SchemaPreview` (`graphql_compose_codegen.schema_preview`)
`\Drupal\graphql_compose_codegen\Service\SchemaPreview`. Bounded, **read-only** facade wrapping the inspector,
generator, and snapshot for the MCP submodule. `run($operation, $bundles, $skipFields)` supports
`inspect|diff|preview`, validates selectors (`^[a-z][a-z0-9_]{0,63}$`, must be a list, ≤64 bundles / ≤256
fields, unique, no unknown/disabled bundle), and caps the schema (`MAX_BUNDLES=64`,
`MAX_FIELDS_PER_BUNDLE=256`, bounding the full paragraph-alias dependency set too) and the JSON result
(`MAX_RESPONSE_BYTES=262144`), throwing rather than truncating. Authorization belongs to the calling adapter;
the service itself never writes files, records a snapshot, or invokes generation hooks.
