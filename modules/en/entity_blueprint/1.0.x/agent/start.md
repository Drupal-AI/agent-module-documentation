<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Blueprint (entity_blueprint) — agent index

Bidirectional JSON entity serialization for Drupal, built for AI and external-system workflows. Serializes any
fieldable entity (nodes, block_content, paragraphs, Layout Builder pages with nested inline blocks) to clean JSON,
and deserializes JSON back into **unsaved** entities with two-phase validation. Package `Entity Blueprint`. Core
`^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.2. **Base module depends only on Drupal core** — no contrib deps.

Design rules baked into the code: never save implicitly (caller decides save/tempstore/discard); enforce access
against the acting user on every path; protect opaque Layout Builder data you don't understand; UUID-based
addressing for all nested content; fail fast with structured errors (JSON path + code + hint).

## Solution docs

- **Core architecture** — serialize/deserialize/operations, validators, field handlers, access, storage, backends,
  layout builder → [architecture.md](architecture.md)
- **Extending it** — hooks, YAML discovery (managed keys / context / skills), field-handler services, Drush commands
  → [api/extending.md](api/extending.md)
- **AI submodules & function-call tools** — `entity_blueprint_ai`, `entity_blueprint_config_ai`, the `eb_*` tools,
  skills, `_anthropic` and `_dev_tools` → [ai/tools.md](ai/tools.md)
- **Config entities & admin settings** — `entity_blueprint_config`, the two settings forms, config objects,
  create allow-list → [config/settings.md](config/settings.md)

## What it provides (base module)

- **Services** (autowired; see `entity_blueprint.services.yml`): `entity_blueprint.serializer`,
  `.deserializer`, `.operations`, `.schema_builder`, `.context_resolver`, `.skills_resolver`,
  `.element_resolver`, `.component_locator`, `.managed_keys_registry`, `.storage_handler`,
  `.access_checker`, `.structural_validator`, `.semantic_validator`, layout serializer/deserializer,
  `.backend_resolver` + `.backend.content`, `.field_handler_manager`, `.skill_type_manager`,
  `.current_entity_context`, and a `logger.channel.entity_blueprint`.
- **Extension points via tagged services**: `entity_blueprint.field_handler`, `entity_blueprint.backend`,
  `entity_blueprint.skill_type` (all `service_collector`).
- **Drush commands**: `entity-blueprint:serialize` (`ebs`), `:deserialize` (`ebd`), `:schema` (`ebsc`).
- **Hooks** (`entity_blueprint.api.php`): reference-strategy, managed-keys, context, relevant-settings,
  processable-fields alters + `entity_blueprint_entity_persisted`.
- No permissions, no config schema, no routes, no annotated plugin types in the base module.

## Submodules (all experimental)

`entity_blueprint_ai` (needs `ai`), `entity_blueprint_config`, `entity_blueprint_config_ai`,
`entity_blueprint_ai_anthropic`, `entity_blueprint_ai_dev_tools`. Only `entity_blueprint_config` provides a
permission and a config schema. See the solution docs.

## Gotchas

- Deserialization returns an **unsaved** entity/`BlueprintResult`; you must call `save()` (or persist via
  tempstore). The Drush deserialize saves by default — run it as `--user=<uid>` (default 1) because Drush
  bootstraps anonymous and access is enforced.
- With Workspaces enabled, content persistence throws `WorkspaceRequiredException` unless a workspace is active.
- `layout_builder__layout` is a top-level blueprint key, **not** inside `fields`.
- Undeclared Layout Builder opaque keys are preserved from the existing entity and never surfaced to AI; only
  keys declared managed (YAML/hook) are exposed and writable.
