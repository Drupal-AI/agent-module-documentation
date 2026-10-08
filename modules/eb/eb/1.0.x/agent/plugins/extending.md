<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eb — services, events, hooks & writing plugins

## Plugin types (3)
All discovered under `src/Plugin/<Type>/` via PHP attributes; managers extend `default_plugin_manager`.

| Type | Manager service | Attribute | Base class | Interface |
|---|---|---|---|---|
| Operation | `plugin.manager.eb_operation` | `Attribute\EbOperation` (`id`, `label`, `description`, `operationType`, `deriver`) | `PluginBase\OperationBase` | `PluginInterfaces\FullOperationInterface` (extends Operation/Previewable/Reversible/Validator interfaces) |
| Validator | `plugin.manager.eb_validator` | `Attribute\EbValidator` (`id`, `label`, `description`, `deriver`) | `PluginBase\ValidatorBase` | `PluginInterfaces\ValidatorInterface` |
| Extension | `plugin.manager.eb_extension` | `Attribute\EbExtension` (`id`, `label`, `description`, `yaml_keys`, `operations`, `module_dependencies`, `deriver`) | `PluginBase\EbExtensionBase` | `PluginInterfaces\EbExtensionInterface` |

**Extension plugins** let a module add new YAML keys and the operations that handle them through a single class (used by `eb_field_group`, `eb_pathauto`, `eb_auto_entitylabel`). `OperationDataBuilder` and `DependencyResolver` consult `plugin.manager.eb_extension`.

### Write an operation
Extend `OperationBase`, add `#[EbOperation(id: 'my_op', label: new TranslatableMarkup('My op'), operationType: 'create')]`, implement `validate(): ValidationResult`, `execute(): ExecutionResult`, `preview(): PreviewResult`, `rollback(): RollbackResult`. Read config via `$this->getDataValue('key')`; helpers: `validateRequiredFields()`, `executeWithErrorHandling()`, `rollbackWithErrorHandling()`, `getRequiredRollbackData()`, `logInfo()/logError()` (respect `log_operations`). Override `checkAccess(AccountInterface)` for a custom permission (default: `import entity architecture`). Add an `eb.plugin.operation.my_op` config schema.

## Services (`eb.services.yml`)
Engine: `eb.operation_builder`, `eb.operation_processor`, `eb.validation_manager`, `eb.preview_generator`, `eb.rollback_manager`, `eb.dependency_resolver`, `eb.change_detector`.
Data/definition: `eb.yaml_parser` (`YamlParser`), `eb.operation_data_builder` (`OperationDataBuilder`, `isDefinitionFormat()`/`build()`), `eb.definition_factory` (`DefinitionFactory::createFromYaml()`/`loadDefinition()`), `eb.definition_generator` (`DefinitionGenerator` — reverse-engineers existing entities into a definition), `eb.discovery_service` (`DiscoveryService` — enumerates field types/widgets/formatters/bundles; `eb.cache_duration` = 3600).
Field/display: `eb.field_management` (`FieldManagementService`), `eb.display_configuration` (`DisplayConfigurationService`).
Logging: `eb.eb_log_manager` (`EbLogManager`), `logger.channel.eb`.
Security helpers: `eb.content_sanitizer` (`ContentSanitizer` — XSS-filters label/description/help/title/etc. via `Xss::filter` + `Html::escape`), `eb.export_security` (`ExportSecurityService` — strips internal fields on export; optional HMAC-SHA256 signing/verification with `hash_equals`).
Interface aliases exist for autowiring (e.g. `Drupal\eb\Service\OperationProcessorInterface`).

## Events (`Event\OperationEvents`)
`PRE_VALIDATE` / `POST_VALIDATE` / `PRE_EXECUTE` / `POST_EXECUTE`. Subscribe with a normal `EventSubscriberInterface`. `OperationPreExecuteEvent::cancel(message)` aborts an operation before it runs; `OperationPostExecuteEvent` carries the `ExecutionResult` (fires for success and failure).

## Hooks
- Hook class `Hook\EbHooks` (Drupal 11 `#[Hook]` attribute, autowired): `#[Hook('entity_delete')]` cascade-deletes rollbacks when an `eb_definition` is deleted (`RollbackManager::deleteByDefinition()`).
- `hook_eb_ui_grid_provider_info()` is defined by the **eb_ui** sub-module, not the base — see the eb_ui docs.

## Result value objects (`src/Result/`)
`ValidationResult`, `PreviewResult`, `ExecutionResult`, `RollbackResult`, `OperationResult` — typed carriers for errors/warnings/messages, created/modified/deleted entities, rollback data, and success state.
