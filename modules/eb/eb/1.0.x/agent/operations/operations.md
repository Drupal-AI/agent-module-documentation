<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eb — operations, definition format & the engine

## Definition format (YAML)
A definition is a flat map. Top-level keys correspond to `EbDefinition` sequences; the YAML editor emits `version` (`EbDefinition::FORMAT_VERSION = '1.0'`), `mode` (`sync`), `scope`, `id`, `label`, optional `description`, then any of:
`bundle_definitions`, `field_definitions`, `field_group_definitions`, `display_field_definitions`, `menu_definitions`. Each is a sequence of one-row-per-item maps (see `config/schema/eb.schema.yml` for every key). Example fixtures ship in `tests/fixtures/valid/` and `tests/fixtures/examples/job_board_platform.yml`.

Two input shapes are accepted: **definition format** (the keys above; detected by `OperationDataBuilder::isDefinitionFormat()`, then compiled to operations by `OperationDataBuilder::build()`), or raw **operation format** (a list where each row has an `operation` key). YAML is parsed by `eb.yaml_parser` (`YamlParser`) using Symfony `Yaml::parse` (arrays only; `.yml`/`.yaml` extensions).

## The 12 operation plugins (`Plugin/EbOperation/`, attribute `EbOperation`)
Each has `id`, `label`, and `operationType` (create/update/delete). Config schema per id under `eb.plugin.operation.<id>`.

| id | Class | Does |
|---|---|---|
| `create_bundle` | CreateBundleOperation | Create a content type / vocabulary / media type / etc. (`entity_type`, `bundle_id`, `label`, `description`, `settings`). |
| `update_bundle` | UpdateBundleOperation | Update an existing bundle's label/description/settings. |
| `delete_bundle` | DeleteBundleOperation | Delete a bundle. |
| `create_field` | CreateFieldOperation | Create a field (storage + config): `field_name`, `field_type`, `entity_type`, `bundle`, `label`, `required`, `cardinality`, `widget`, `formatter`, `*_settings`, `default_value`. |
| `update_field` | UpdateFieldOperation | Update field config/widget/formatter/default. |
| `delete_field` | DeleteFieldOperation | Delete a field; `delete_storage` also removes storage. |
| `hide_field` | HideFieldOperation | Hide a field in a given `display_type`/`display_mode`. |
| `reorder_fields` | ReorderFieldsOperation | Set `field_order` (weights) in a display. |
| `configure_form_mode` | ConfigureFormModeOperation | Set widget/weight/hidden per field in a form display. |
| `configure_view_mode` | ConfigureViewModeOperation | Set formatter/weight/hidden/label_display per field in a view display. |
| `create_menu` | CreateMenuOperation | Create a custom menu. |
| `create_menu_link` | CreateMenuLinkOperation | Create a menu link (`menu_id`, `title`, `link.uri`, `parent`, `weight`, ...). |

Operations extend `OperationBase` (implements `FullOperationInterface` = validate + execute + preview + rollback) with DI of `entity_type.manager`, `logger.channel.eb`, `config.factory`. `OperationBase::checkAccess()` defaults to requiring `import entity architecture`. Optional interfaces: `PreviewableOperationInterface`, `ReversibleOperationInterface`.

## Engine flow
1. **Build** — `eb.operation_builder` (`OperationBuilder::buildBatch()`) turns operation-data arrays into operation plugin instances.
2. **Validate** — `eb.validation_manager` (`ValidationManager::validateBatch()`) runs each operation's own `validate()` plus the 7 cross-cutting validator plugins, returning a `ValidationResult`.
3. **Resolve order** — `eb.dependency_resolver` (`DependencyResolver`) topologically orders operations (e.g. fields after their bundle, entity-reference fields after target bundles).
4. **Preview** — `eb.preview_generator` (`PreviewGenerator`) calls each `PreviewableOperationInterface::preview()`; returns `PreviewResult` objects (created/modified/deleted entities, warnings). Also formats text/HTML/JSON and a dependency tree.
5. **Execute** — `eb.operation_processor` (`OperationProcessor::executeOperation/executeBatch()`) dispatches `PRE_EXECUTE` (cancellable), runs `execute()`, logs to the `eb` channel, stores rollback data via `eb.rollback_manager`, dispatches `POST_EXECUTE`. Batches group under one rollback record keyed by `definition_id`; `stop_on_failure` gives all-or-nothing behaviour. Exceptions are caught and returned as failed `ExecutionResult`s.
6. **Change detection** — `eb.change_detector` (`ChangeDetector`, `Enum/ChangeDetectionMode`) drives smart sync (skip unchanged, update changed, create new).

## Validators (`Plugin/EbValidator/`, attribute `EbValidator`)
`field_type` (type exists), `unique_name` (no duplicate machine names), `required_fields` (required keys present), `dependency` (referenced bundles/modules exist), `circular_dependency` (no cycles), `widget_compatibility` (widget valid for field type), `formatter_compatibility` (formatter valid for field type). Extend `ValidatorBase`, return a `ValidationResult`.

## Where to run it
- UI: `/admin/config/development/eb` → Import / Definitions / Preview / Apply / Rollback / Log / Discovery / Settings tabs.
- YAML editor: `eb_ui` sub-module (see `../../modules/eb_ui/1.0.x/agent/api/endpoints.md`).
- CLI: `../drush/commands.md`.
