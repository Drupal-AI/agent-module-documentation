<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Blueprint — hooks, YAML discovery, field handlers, Drush

## Drush commands (base module, `src/Drush/Commands/`)

- `entity-blueprint:serialize <entity_type> <id>` (`ebs`) — `--summary` (structure only), `--component=UUID`
  (single component). `SerializeCommand`.
- `entity-blueprint:deserialize <source>` (`ebd`) — `source` is a file path or `-` for stdin. `--dry-run`
  (Phase A only), `--no-save` (hydrate+validate, don't save), `--user=<uid>` (default `1`). `DeserializeCommand`
  runs deserialize+save inside `runAsUser()` (`RunsAsSelectedUserTrait`) because Drush bootstraps anonymous and
  create/field-edit access is enforced against the acting user; by default it **saves** the result.
- `entity-blueprint:schema <entity_type> [bundle]` (`ebsc`) — descriptive JSON schema. `SchemaCommand`, also
  user-switching.

## Hooks (`entity_blueprint.api.php`)

- `hook_entity_blueprint_reference_strategy_alter(&$strategy, $field_definition, $entity_type, $bundle)` — flip a
  field between `shared` and `inline` reference strategy.
- `hook_entity_blueprint_managed_keys_alter(&$managed_keys, $entity_type, $bundle)` — declare opaque Layout
  Builder keys as AI-managed. Scopes: `section_layout_settings` (nested by layout plugin id) and
  `inline_block_configuration` (nested by block type). Each key: `label`, `description`, `schema`. Undeclared
  opaque keys stay preserved and hidden from AI.
- `hook_entity_blueprint_context_alter(&$context, $entity_type, $bundle)` — attach `guidance` (string) and
  `defaults` (array) to schema output at entity, `field_types`, `block_types`, and `layouts` levels.
- `hook_entity_blueprint_relevant_settings_alter(&$relevant_settings, $definition, $all_settings)` — add/remove
  AI-relevant field settings in schema output.
- `hook_entity_blueprint_processable_fields_alter(&$definitions, $entity_type_id, $bundle)` — unset fields to
  exclude them from schema/serialize/deserialize/validate uniformly.
- `hook_entity_blueprint_entity_persisted($entity, $save, $component_uuids)` — react after
  `EntityStorageHandler` saves or tempstores (fired by the storage handler; `$save` FALSE = tempstore).

## YAML discovery (`YamlDiscoveryTrait`)

Static declarations as YAML instead of PHP; hooks still run last as an alter. Three layers merged with
`array_replace_recursive` (last module wins on scalar leaves): universal YAML → scoped YAML → hook alter.

- Managed keys: `MODULE.entity_blueprint.managed_keys.yml` (universal) or
  `MODULE.entity_blueprint.managed_keys.<ENTITY_TYPE>.<BUNDLE>.yml` (scoped). Mirrors the managed-keys hook array.
- Context: `MODULE.entity_blueprint.context.yml` / scoped variant. Mirrors the context hook array
  (`layouts`, `block_types`, field-type guidance, entity-level `guidance`/`defaults`).

Entity type and bundle are encoded in the scoped **filename**, not the file body. Discovery walks all module
directories via `ModuleHandler::getModuleDirectories()`.

## Skills (`SkillsResolver`, `.skills_resolver`)

Per-file YAML: `MODULE.entity_blueprint.skills.<SKILL_ID>.yml`, each with `label`, `description`, `type`, and
multiline `instructions`. Same-id files across modules merge (`array_replace_recursive`); results cache under
`entity_blueprint:skills` (tag `entity_blueprint_skills`) and pass through `hook_entity_blueprint_skills_alter`.
`type` names a registered `SkillType` (`default`, `create_entity`, `current_entity`) that composes runtime
context. The base module ships `create_entity` and `add_section` skill files. Skills deliver behavioral guidance
on demand (via the `eb_skill` tool) rather than stuffing it into the system prompt.

## Custom field handler (register)

```yaml
services:
  my_module.field_handler.custom:
    class: Drupal\my_module\FieldHandler\CustomFieldHandler
    tags:
      - { name: entity_blueprint.field_handler, field_types: 'my_field_type' }
```

Extend `Drupal\entity_blueprint\FieldHandler\FieldHandlerBase` and implement `doSerialize()` /
`doDeserialize()`. Return a `FieldHandlerResult`; emit `DeferredOperation`s for async work (e.g. image
generation) that a consumer processes after build. Multiple `field_types` are comma-separated. Backends
(`entity_blueprint.backend`) and skill types (`entity_blueprint.skill_type`, with a `type_id`) register the same
tagged-service way.
